

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/utils/dio_inperactor.dart';
import 'package:mediaverse/app/common/utils/utils.dart';
import 'package:mediaverse/app/pages/live/widgets/player_live_widget.dart';
import 'package:mediaverse/app/pages/plus_section/logic.dart';
import 'package:mediaverse/app/pages/plus_section/widget/first_form.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../../common/app_config.dart';

class LiveController extends GetxController{
  RxMap<String, dynamic>? liveDetails = RxMap<String, dynamic>();
  RxBool isLoadingLive = false.obs;
  RxBool isRecordingLive = false.obs;
  var isExpanded = false.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }

 List<String> titlesRecordText  =  [
   '1 Minute',
   '3 Minute',
   '5 Minute',
 ];
 List<String> titlesRecordIcon  =  [
   'assets/mediaverse/icons/time1.svg',
   'assets/mediaverse/icons/time2.svg',
   'assets/mediaverse/icons/time3.svg',
 ];
  bool isExpandedViewBodyText = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLiveData();
    initializeTimer();
    selectedIndex = 0;
  }

  void fetchLiveData() async {
    await _getLive( liveDetails, isLoadingLive);

  }


  Future<void> _getLive(

   RxMap<String, dynamic>? details, RxBool isLoading) async {
    try {

      final token = GetStorage().read("token");
      isLoading.value = true;
      String apiUrl =
          '${Constant.HTTP_HOST}channels/${Get.arguments['channelId']}';

      var response = await Dio().get(apiUrl, options: Options(headers: {
        'accept': 'application/json',
        'X-App': '_Android',
        'Accept-Language': 'en-US',
        'Authorization': 'Bearer $token',
      }));

      if (response.statusCode == 200) {
        details?.value = RxMap<String, dynamic>.from(response.data['data']);

        initPlayerVideo('${response.data['data']['current_url']}');
        print('82872738238273');
        print(response.data['data']['current_url']);
      } else {
        // Handle errors
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoading.value = false;
    }
  }











  int selectedIndex = -1;
  List<bool> isSelectedList = [false, false, true];
  List<String> titles = ['2', '3', '5'];
  int getTimeRecord(int idx) {
    switch (idx) {
      case 0:
        return 120;
      case 1:
        return 180;
      case 2:
        return 300;
      default:
        return 0;
    }
  }

  var isLoadingRecord = false.obs;
  var isSuccessRecord = false.obs;

  void postTimeRecord(String channelId) async {


    try {
      isLoadingRecord.value = true;

      final token = GetStorage().read("token");
      String apiUrl = '${Constant.HTTP_HOST}tasks/channel-record';

      Dio dio= Dio();
      dio.interceptors.add(MediaVerseConvertInterceptor());
      dio.interceptors.add(CurlLoggerDioInterceptor());//
      print('LiveController.postTimeRecord 1');
      var response = await dio.post(
        apiUrl,
        data: {
          "channel": channelId.toString(),
          "length": getTimeRecord(selectedIndex),
        },
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        Constant.showMessege('Success , Recording... ${getTimeRecord(selectedIndex)} s');
        isSuccessRecord.value = true;

        startTimer();
      } else {

        isSuccessRecord.value = false;
      }
    } catch (e) {
      print("Error: $e");
      isSuccessRecord.value = false;

    } finally {
      await Future.delayed(Duration(seconds: getTimeRecord(selectedIndex)));
      isLoadingRecord.value = false;
    }
  }
 var remainingTime = 0.obs;
  var isRecording = false.obs;
  Timer? _timer;

  void startTimer() {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    final endTime = startTime + (getTimeRecord(selectedIndex) * 1000);

    GetStorage().write('startTime', startTime);
    GetStorage().write('endTime', endTime);

    isRecording.value = true;
    updateTimer();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void updateTimer() {
    final endTime = GetStorage().read('endTime');
    if (endTime == null) return;

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final diff = (endTime - now) ~/ 1000;

      if (diff <= 0) {
        remainingTime.value = 0;
        isRecording.value = false;
        _timer?.cancel();
      } else {
        remainingTime.value = diff;
      }
    });
  }

  void initializeTimer() {
    final endTime = GetStorage().read('endTime');
    if (endTime == null) {
      remainingTime.value = 0;
      isRecording.value = false;
      return;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = (endTime - now) ~/ 1000;

    if (diff <= 0) {
      remainingTime.value = 0;
      isRecording.value = false;
    } else {
      remainingTime.value = diff;
      isRecording.value = true;
      updateTimer();
    }
  }


  void stopTimer() {
    _timer?.cancel();
    isRecording.value = false;
    GetStorage().remove('startTime');
    GetStorage().remove('endTime');
  }
















  //Screenshot and save to gallery
  ScreenshotController screenshotController = ScreenshotController();

  saveScreenShot(Uint8List byte) async {
    final time = DateTime.now();
    final name = 'Mediaverse $time';

    File? savedImage = await saveImage(byte);

    PlusSectionLogic logic = Get.put(PlusSectionLogic(), tag: "Save_${DateTime.now().millisecondsSinceEpoch}");

    logic.mediaMode = MediaMode.image;
    logic.imageFile = savedImage!;
    logic.imageOutPut = savedImage.path;

    Get.to(FirstForm(logic), arguments: [logic]);
  }

  Future<File?> saveImage(Uint8List bytes) async {
    // Check storage permission (optional)
    // ...

    // Get app directory path
    final appDir = await getApplicationCacheDirectory();

    // Generate unique filename
    final screenShotName = "${DateTime.now().millisecondsSinceEpoch}.png";

    // Create file object
    final file = File('${appDir.path}/$screenShotName');

    // Write image bytes to file
    await file.writeAsBytes(bytes);

    // Return saved image path
    return file;
  }
  takeScreenShot(){
    screenshotController.capture().then((Uint8List? image){
      saveScreenShot(image!);



    });
    //Get.snackbar('Success', 'The screenshot is saved in your gallery' , backgroundColor: Colors.green);
  }





  //new Player Logic
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(true);
  Rx<Duration> currentPosition = const Duration().obs;
  RxBool showIconPlayPause = false.obs;

  RxBool loadingVideo = true.obs;

  //method
  void updatePlayPauseState() {
    isPlayingNotifier.value = videoPlayerController!.value.isPlaying;
    currentPosition.value = videoPlayerController!.value.position;

    if (showIconPlayPause.value) {
      Future.delayed(const Duration(seconds: 1), () {
        showIconPlayPause.value = false;
      });
    }
  }

  initPlayerVideo(String? url) async {
    if (videoPlayerController != null) {
      videoPlayerController?.removeListener(updatePlayPauseState);
      chewieController?.dispose();
      await videoPlayerController?.dispose();
      videoPlayerController = null;
      chewieController = null;
    }
    loadingVideo.value = true;

    WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
        videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
            url ?? 'https://www.taxmann.com/emailer/images/CompaniesAct.mp4'));

        videoPlayerController?.initialize().then(
              (value) {
            chewieController = ChewieController(
              videoPlayerController: videoPlayerController!,
              autoPlay: true,
              looping: false,
              showControlsOnInitialize: true,
              allowFullScreen: true,
              allowedScreenSleep: false,
              allowMuting: true,
              allowPlaybackSpeedChanging: false,
              customControls:
              CustomControls(isPlayingNotifier: isPlayingNotifier),
              materialProgressColors: ChewieProgressColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
                backgroundColor: Colors.grey,
                bufferedColor: Colors.lightGreen,
              ),
            );
            loadingVideo.value = false;
          },
        );
        videoPlayerController?.addListener(updatePlayPauseState);
      },
    );
  }
}



