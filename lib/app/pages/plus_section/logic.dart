import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/plus_section/widget/custom_plan_text_filed.dart';
import 'package:mediaverse/app/pages/plus_section/widget/first_form.dart';
import 'package:mediaverse/app/pages/plus_section/widget/upload_asset_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import 'state.dart';

class PlusSectionLogic extends GetxController implements RequestInterface {
  late ApiRequster apiRequster;

  TextEditingController titleController = TextEditingController();
  TextEditingController planController = TextEditingController(text: "Free");
  TextEditingController editibaleController =
      TextEditingController(text: "yes");
  TextEditingController captionController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController subscrptionController = TextEditingController();
  TextEditingController textTitleController = TextEditingController();
  TextEditingController textDisController = TextEditingController();

  String assetid = "";
  String postUploadedId = "";
  var isloading = false.obs;
  String imageOutPut = "";
  String videoOutPut = "";
  String soundOutPut = "";
  String textOutPut = "";

  double uploadedCount = 0.0;

  // برای کنترل نمایش ویجت زمان ضبط
  var isRecordingTimeVisible = false.obs;

// برای نگهداری زمان ضبط شده به صورت رشته
  var recordingTime = ''.obs;

  Future<void> startVideoRecording() async {
    if (controller == null || !controller!.value.isInitialized) {
      print('Error: select a camera first.');
      return;
    }
    if (controller!.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }
    try {
      await controller!.startVideoRecording();
      isRecordingTimeVisible.value = true; // ویجت زمان ضبط را نمایش می‌دهیم
      _startVideoRecordingTimer(); // شروع زمان‌سنج برای به‌روزرسانی زمان ضبط
      update();
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      return;
    }
    try {
      XFile video = await controller!.stopVideoRecording();
      videoOutPut = video.path;
      isRecordingTimeVisible.value = false; // ویجت زمان ضبط را مخفی می‌کنیم
      _stopVideoRecordingTimer(); // توقف زمان‌سنج
      update();
      print('Video recorded to ${video.path}');
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  void _startVideoRecordingTimer() {
    _recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordingDuration += Duration(seconds: 1);
      recordingTime.value = _formatDuration(_recordingDuration);
      update();
    });
  }

  void _stopVideoRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingDuration = Duration.zero;
    recordingTime.value = ''; // زمان ضبط را ریست می‌کنیم
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  Timer? _recordingTimer;
  Duration _recordingDuration = Duration.zero;

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;

    update();
  }

  void _initialiseControllers() async {
    _getDir();
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  final PlusSectionState state = PlusSectionState();
  MediaMode mediaMode = MediaMode.image;
  CameraController? controller;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this, develperModel: true);
    initCamera();
    planController.addListener(() {
      update();
    });
    _initialiseControllers();
  }

  var imageFile;
  late List<CameraDescription> _cameras;

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      Constant.showMessege('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      imageFile = file;
      imageOutPut = file.path;
      print('PlusSectionLogic.takePicture Picture saved to  = ${file.path}');
      return file;
    } on CameraException catch (e) {
      // _showCameraException(e);
      Constant.showMessege(e.description ?? "");
      return null;
    } finally {
      Get.to(FirstForm(), arguments: [this]);
    }
  }

  void initCamera() async {
    _cameras = await availableCameras();

    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      update();
    }).catchError((Object e) {
      if (e is CameraException) {
        print('_PlusSectionPageState.initState = ${e.description}');
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.

            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    controller!.dispose();
  }

  getTopIcon() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return 2;
      case MediaMode.image:
        // TODO: Handle this case.
        return 1;

      case MediaMode.text:
        // TODO: Handle this case.
        return 3;
      case MediaMode.video:
        return 1;

      // TODO: Handle this case.
    }
  }

  getLeftIcon() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return 1;
      case MediaMode.image:
        // TODO: Handle this case.
        return 2;
      case MediaMode.text:
        // TODO: Handle this case.
        return 1;
      case MediaMode.video:
        return 2;

      // TODO: Handle this case.
    }
  }

  getRightIcon() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return 3;
      case MediaMode.image:
        // TODO: Handle this case.
        return 3;
      case MediaMode.text:
        // TODO: Handle this case.
        return 2;
      case MediaMode.video:
        return 3;

      // TODO: Handle this case.
    }
  }

  void middleClick() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        _startOrStopRecording();
        break;
      case MediaMode.image:
        takePicture();
        // TODO: Handle this case.
        break;
      case MediaMode.text:
        Get.to(FirstForm(), arguments: [this]);
        break;
      // TODO: Handle this case.
      case MediaMode.video:
      // TODO: Handle this case.
    }
  }

  void getLeftClick() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        mediaMode = MediaMode.image;
      case MediaMode.image:
        // TODO: Handle this case.
        mediaMode = MediaMode.audio;

      case MediaMode.text:
        // TODO: Handle this case.
        mediaMode = MediaMode.image;
      case MediaMode.video:
      // TODO: Handle this case.
    }
    update();
  }

  void _startRecordingTimer() {
    _recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordingDuration += Duration(seconds: 1);
      update(); // به‌روزرسانی ویو برای نمایش زمان جدید
    });
  }

  // توقف تایمر و ریست کردن زمان ضبط
  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingDuration = Duration.zero;
  }

  String getFormattedRecordingDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_recordingDuration.inHours);
    final minutes = twoDigits(_recordingDuration.inMinutes.remainder(60));
    final seconds = twoDigits(_recordingDuration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        _stopRecordingTimer(); // توقف تایمر و به‌روزرسانی وضعیت ضبط

        recorderController.reset();

        final path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          soundOutPut = path ?? "";
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
          Get.to(FirstForm(), arguments: [this]);
        }
      } else {
        _startRecordingTimer(); // شروع تایمر و به‌روزرسانی وضعیت ضبط

        await recorderController.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRecording = !isRecording;
      update();
    }
  }

  void getRightClick() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        mediaMode = MediaMode.text;
      case MediaMode.image:
        // TODO: Handle this case.
        mediaMode = MediaMode.text;

      case MediaMode.text:
        // TODO: Handle this case.
        mediaMode = MediaMode.audio;
      case MediaMode.video:
      // TODO: Handle this case.
    }
    update();
  }

  Widget getMainWidget() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return Container(
          width: 100.w,
          height: 100.h,
          child: Scaffold(
            backgroundColor: "#02073D".toColor(),
            body: Center(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: "666680".toColor(),
                                )),
                            Text(
                              "   ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              width: 16.w,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Align(
                          child: Text(
                        getFormattedRecordingDuration(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      )),
                      Container(
                        width: 100.w,
                        height: 40.h,
                        child: Stack(
                          children: [
                            SizedBox.expand(
                                child: Image.asset(
                              "assets/images/voicebackground.png",
                              width: 100.w,
                              fit: BoxFit.fitWidth,
                            )),
                            Align(
                              child: isRecording
                                  ? Container(
                                      height: 30.h,
                                      child: AudioWaveforms(
                                        enableGesture: true,
                                        size: Size(
                                            MediaQuery.of(Get.context!)
                                                .size
                                                .width,
                                            30.h),
                                        recorderController: recorderController,
                                        waveStyle: WaveStyle(
                                            waveColor: Colors.white,
                                            extendWaveform: true,
                                            showMiddleLine: true,
                                            middleLineColor: "597AFF".toColor(),
                                            scaleFactor: 300),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          // color: const Color(0xFF1E1B26),
                                        ),
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                      ),
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case MediaMode.image:
        // TODO: Handle this case.

        if (controller != null && !controller!.value.isInitialized) {
          return FocusDetector(onFocusGained: () {}, child: Container());
        }
        return Stack(
          children: [
            if (controller != null)
              SizedBox.expand(
                  child: FocusDetector(
                      onFocusGained: () {},
                      onFocusLost: () {},
                      child: CameraPreview(controller!))),
            Obx(() {
              return Visibility(
                visible: isRecordingTimeVisible.value,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 20.w,
                    height: 4.h,
                    margin: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(400)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/images/record.svg"),
                        Text(
                          recordingTime.value,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        );
      case MediaMode.text:
        // TODO: Handle this case.
        return Container(
          width: 100.w,
          height: 100.h,
          child: Scaffold(
            backgroundColor: AppColor.blueDarkColor,
            body: Center(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: "666680".toColor(),
                                )),
                            Text(
                              "   ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              width: 16.w,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextFieldPlusWidget(
                              context: Get.context!,
                              textEditingController: textTitleController,
                              titleText: 'Title',
                              hintText: 'Insert your title',
                              isLarge: false,
                              needful: false),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Caption",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomTextFieldPlusWidget(
                              context: Get.context!,
                              textEditingController: textDisController,
                              titleText: 'Select language',
                              hintText: 'Insert Caption',
                              needful: false),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case MediaMode.video:
        // TODO: Handle this case.
        return Container();
    }
  }

  sendMainRequest() {
    isloading(true);
    var box = GetStorage();
    var body = {
      "name": titleController.text,
      "user": box.read("userid"),
      "plan": _getPlanByDropDown(),
      "subscription_period": subscrptionController.text,
      "description": captionController.text,
      "lat": 0,
      "lng": 0,
      "forkability_status":
          editibaleController.text.contains("Yes") ? "0" : "1",
      "commenting_status": 1,
      "tags": []
    };
    if (!_getPlanByDropDown().toString().contains("1")) {
      body['price'] = priceController.text;
    }
    print('PlusSectionLogic.sendMainRequest = ${body}');

    apiRequster.request(_getUrlByMediaEnum(), ApiRequster.MHETOD_POST, 1,
        body: body, useToken: true);
  }
  Future<String> saveStringToTxtFile(String stringData) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/fileName.txt';
    final file = File(filePath);
    await file.writeAsString(stringData);
    return filePath;
  }
  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
    isloading(false);
    try {
      var messege = jsonDecode(bodyError)['message'];
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
        messege,
        style: TextStyle(color: AppColor.primaryDarkColor),
      )));
    } catch (e) {}
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    switch (reqCdoe) {
      case 1:
        peaseJsonFromAddAssets(source);
        break;
    }
  }

  String _getUrlByMediaEnum() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return "audios";
      case MediaMode.image:
        // TODO: Handle this case.
        return "images";

      case MediaMode.text:
        // TODO: Handle this case.
        return "texts";

      case MediaMode.video:
        // TODO: Handle this case.
        return "videos";
    }
  }

  _getPlanByDropDown() {
    switch (planController.text) {
      case "Free":
        return "1";
      case "Ownership":
        return "2";
      case "Subscription":
        return "3";
    }
  }

  void peaseJsonFromAddAssets(source) {
    print(
        'PlusSectionLogic.peaseJsonFromAddAssets = ${jsonDecode(source)['asset_id']} - ${imageOutPut}');
    assetid = jsonDecode(source)['asset_id'].toString();
    postUploadedId = jsonDecode(source)['id'].toString();

    isloading(false);

    Get.to(UploadAssetPage(), arguments: [this]);
  }

  Future<void> uploadFileWithDio() async {
   textOutPut = await saveStringToTxtFile(textDisController.text);
    var dio = Dio();
    var formData = d.FormData.fromMap({
      'file': await d.MultipartFile.fromFile(_getFilePathFromMediaEnum(),
          filename: 'uploadfile'),
      'asset': assetid.toString(),
    });

    try {
      var response = await dio.post(
        'https://api.mediaverse.land/v2/files',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'multipart/form-data',
            'X-App': '_Android',
          },
        ),
        onSendProgress: (s, p) {
          uploadedCount = (s * 100) / p;
          print('PlusSectionLogic.uploadFileWithDio = ${s} - ${p}');
          update();
        },
      );

      if (response.statusCode == 200) {
        print('File uploaded successfully = ${response.data}');
         Get.offAllNamed(PageRoutes.WRAPPER);
        Get.toNamed(_getRouteByMedia(),arguments: {'id': postUploadedId});
      } else {
        print('Failed to upload file: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
    }
  }

  String _getFilePathFromMediaEnum() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return soundOutPut;
      case MediaMode.image:
        // TODO: Handle this case.
        return imageOutPut;

      case MediaMode.text:
        // TODO: Handle this case.
        return textOutPut;

      case MediaMode.video:
        // TODO: Handle this case.
        return videoOutPut;
    }
  }

  String _getRouteByMedia() {
    switch(mediaMode){

      case MediaMode.audio:
        // TODO: Handle this case.
        return PageRoutes.DETAILMUSIC;
      case MediaMode.image:
        // TODO: Handle this case.
        return PageRoutes.DETAILIMAGE;

      case MediaMode.text:
        // TODO: Handle this case.
        return PageRoutes.DETAILTEXT;

      case MediaMode.video:
        // TODO: Handle this case.
        return PageRoutes.DETAILVIDEO;

    }
  }
}

enum MediaMode { audio, image, text, video }