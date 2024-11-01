

import 'dart:io';
import 'dart:typed_data';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/utils/dio_inperactor.dart';
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


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchLiveData();
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
        print(response.data);
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
    Get.back();

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
        _showSnackbar('Success', "Recording...", Colors.green, Icons.fiber_smart_record_sharp);
        isSuccessRecord.value = true;
      } else {
        _showSnackbar('Error', "Try again!", Colors.red, Icons.info);
        isSuccessRecord.value = false;
      }
    } catch (e) {
      print("Error: $e");
      isSuccessRecord.value = false;
      _showSnackbar('Error', "Try again!", Colors.yellow, Icons.info);
    } finally {
      await Future.delayed(Duration(seconds: getTimeRecord(selectedIndex)));
      isLoadingRecord.value = false;
    }
  }

  void _showSnackbar(String title, String message, Color backgroundColor, IconData icon) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      icon: Icon(icon),
    );
  }


















  late VideoPlayerController controllerVideoPlay;

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
}



