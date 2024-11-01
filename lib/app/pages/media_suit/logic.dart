import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../common/app_config.dart';
import '../../common/utils/dio_inperactor.dart';

// class EditDataModel {
//   final String name;
//   final String? urlMedia;
//   double witdh = 20.w;
//   double hight =  0.050.h;
//   double positionX = 0.0;
//   EditDataModel(this.name, this.urlMedia);
//
//
//   void updatePosition(double newPositionX) {
//     positionX = newPositionX;
//   }
//
//   void updateSize(double newWidth, double newHeight) {
//     witdh = newWidth;
//     hight = newHeight;
//   }
// }

class EditDataModel {
  final String name;
  int? mediaClass;
  String? urlMedia;
  double second;

  double get width => second * 30.0;
  double height = 0.050.h;
  double positionX = 0.0;
  double? defaultWidthVideo;

  int start = 0;
  int end = 0;
  int length = 0;
  String? assetId;
  bool isloading = false;
  double startTrim = 0;
  double endTrim;

  double get trimWidth => (endTrim - startTrim) * 30.0;

  EditDataModel(this.name, this.urlMedia, this.defaultWidthVideo, this.assetId,
      this.mediaClass,
      {this.isloading = false, this.second = 3.0})
      : endTrim = second;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'urlMedia': urlMedia,
      'width': width.round(),
      'height': height.round(),
      'positionX': positionX,
      'start': start,
      'length': length,
      'end': end,
      'asset_id': assetId,
    };
  }

  void updatePosition(double newPositionX) {
    positionX = newPositionX;
  }

// void updateSize(double newWidth, double newHeight) {
//   width = newWidth;
//   height = newHeight;
// }

// void updateTimings(int pixelsPerSecond, int previousEnd) {
//   if (pixelsPerSecond == 0) {
//     return;
//   }
//
//   double durationInSeconds = width / pixelsPerSecond;
//
//
//   start = previousEnd + 1;
//
//
//   if (previousEnd == -1) {
//
//     end =  start + durationInSeconds.toInt() ;
//   } else {
//
//     end = previousEnd * 2;
//   }
//
//   length = end - start;
//
//   print('EditDataModel.updateTimings = ${previousEnd} - ${start} - ${end}');
// }
}

class MediaSuitController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    textAction = [
      ActionEditorModel(
          nameItem: 'Translate Text',
          onTap: () {
            translateText();
          }),
      ActionEditorModel(
          nameItem: 'Text to Image',
          onTap: () {
            textToImage();
          }),
      ActionEditorModel(
          nameItem: 'Text to speech',
          onTap: () {
            textToSpeech();
          }),
      ActionEditorModel(nameItem: 'Create story', onTap: () {}),
    ];

    videoAction = [
      ActionEditorModel(nameItem: 'Video Mute', onTap: () {}),
      ActionEditorModel(
          nameItem: 'Video Trim',
          onTap: () {
            isTrimming = true;
            update();
          }),
      ActionEditorModel(
          nameItem: 'Extract Audio',
          onTap: () {
            videoConvertToAudio();
          }),
    ];

    audioAction = [
      ActionEditorModel(
          nameItem: 'Audio to Text',
          onTap: () {
            soundConvertToText();
          }),
      ActionEditorModel(
          nameItem: 'Translate Audio',
          onTap: () {
            soundTranslate();
          }),
      ActionEditorModel(
          nameItem: 'Audio Trim',
          onTap: () {
            isTrimming = true;
            update();
          }),
      ActionEditorModel(nameItem: 'Change Speech Audio', onTap: () {}),
    ];
  }

  var editTextDataList = <EditDataModel>[].obs;
  var editImageDataList = <EditDataModel>[].obs;
  var editVideoDataList = <EditDataModel>[].obs;
  var editAudioDataList = <EditDataModel>[].obs;
  var selectedVideoIndex = Rx<int?>(null);
  var selectedImageIndex = Rx<int?>(null);
  var selectedAudioIndex = Rx<int?>(null);
  var selectedTextIndex = Rx<int?>(null);

  var isloadingSubmit = false.obs;
  var isloadingAssetConvert = false.obs;
  var isWaitingAssetConvert = false.obs;
  List<ActionEditorModel> textAction = [];
  List<ActionEditorModel> videoAction = [];
  List<ActionEditorModel> audioAction = [];
  bool isResizing = false;
  bool isTrimming = false;

  //clear timeline
  void clearTimeline() {
    editTextDataList.clear();
    editImageDataList.clear();
    editVideoDataList.clear();
    editAudioDataList.clear();
    isTrimming = false;
  }

  //trim TimeLine Video and Audio

  void confirmAudioTrim() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editAudioDataList[selectedAudioIndex.value!].assetId;
    var model = editAudioDataList[selectedAudioIndex.value!];

    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/audio-trim';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());

      print('${fileId}');
      var response = await s.post(apiUrl,
          options: Options(headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          }),
          data: {
            "file": fileId,
            "start": model.startTrim.round(),
            "length": model.endTrim.round(),
          });

      print(
          'DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        final newSeconds = model.endTrim - model.startTrim;
        final newContainer = EditDataModel(
          editAudioDataList[selectedAudioIndex.value!].name,
          editAudioDataList[selectedAudioIndex.value!].urlMedia!,
          0,
          editAudioDataList[selectedAudioIndex.value!].assetId.toString(),
          3,
          second: newSeconds,
        );

        editAudioDataList.add(newContainer);
        model.second -= newSeconds;
        model.endTrim = model.second;
        model.startTrim = 0;
        isTrimming = false;
        selectedAudioIndex.value = -1;

        Constant.showMessege("Request Succesful");

        print(response.data);
        isloadingAssetConvert(false);
      } else {
        isloadingAssetConvert(false);
      }
    } catch (e) {
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  void confirmVideoTrim() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editVideoDataList[selectedVideoIndex.value!].assetId;
    var model = editVideoDataList[selectedVideoIndex.value!];

    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/audio-trim';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());

      print('${fileId}');
      var response = await s.post(apiUrl,
          options: Options(headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          }),
          data: {
            "file": fileId,
            "start": model.startTrim.round(),
            "length": model.endTrim.round(),
          });

      print(
          'DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        final newSeconds = model.endTrim - model.startTrim;
        final newContainer = EditDataModel(
          editVideoDataList[selectedVideoIndex.value!].name,
          editVideoDataList[selectedVideoIndex.value!].urlMedia!,
          0,
          editVideoDataList[selectedVideoIndex.value!].assetId.toString(),
          3,
          second: newSeconds,
        );

        editVideoDataList.add(newContainer);
        model.second -= newSeconds;
        model.endTrim = model.second;
        model.startTrim = 0;
        isTrimming = false;
        // selectedVideoIndex.value = -1;

        Constant.showMessege("Request Succesful");

        print(response.data);
        isloadingAssetConvert(false);
      } else {
        isloadingAssetConvert(false);
      }
    } catch (e) {
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  // void confirmTrim(EditDataModel model , Rx<int?> trimIndex , trimList) {
  // final newSeconds = model.endTrim - model.startTrim;
  // final newContainer = EditDataModel();
  //
  // trimList.add(newContainer);
  //   model.second -= newSeconds;
  //   model.endTrim = model.second;
  //   model.startTrim = 0;
  //   isTrimming = false;
  // trimIndex.value = -1;

  // }

  ///Convert asset TimeLine [selectedAudioIndex]
  void soundTranslate() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editAudioDataList[selectedAudioIndex.value!].assetId;
    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/audio-translate-text';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());

      print('DetailController.soundTranslate = ${fileId}');
      var response = await s.post(apiUrl,
          options: Options(headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          }),
          data: {"file": fileId});

      print(
          'DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        Constant.showMessege("Request Succesful");

        print(response.data);
        isloadingAssetConvert(false);

        Get.find<MediaSuitController>().setDataEditAudio(
            editAudioDataList[selectedAudioIndex.value!].name,
            editAudioDataList[selectedAudioIndex.value!].urlMedia!,
            editAudioDataList[selectedAudioIndex.value!].assetId.toString(),
            isloading: true);
      } else {
        isloadingAssetConvert(false);
      }
    } catch (e) {
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  void soundConvertToText() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editAudioDataList[selectedAudioIndex.value!].assetId;
    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/audio-text';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());

      print('DetailController.soundConvertToText = ${fileId}');
      var response = await s.post(apiUrl,
          options: Options(headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          }),
          data: {"file": fileId});

      if (response.statusCode == 200) {
        Constant.showMessege("Request Succesful ");
        print(response.data);

        isloadingAssetConvert(false);

        Get.find<MediaSuitController>().setDataEditText(
            editAudioDataList[selectedAudioIndex.value!].name,
            editAudioDataList[selectedAudioIndex.value!].urlMedia!,
            editAudioDataList[selectedAudioIndex.value!].assetId.toString(),
            isloading: true);
      } else {
        // Handle errors
        // Constant.showMessege("Request Denied : ${response.data['status']}");
        isloadingAssetConvert(false);
      }
    } catch (e) {
      // Constant.showMessege("Request Denied : ${e.toString()}");
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  ///Convert asset TimeLine [selectedVideoIndex]
  void videoConvertToAudio() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editVideoDataList[selectedVideoIndex.value!].assetId;
    print(fileId);
    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/video-audio';
      var response = await Dio().post(apiUrl,
          options: Options(headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          }),
          data: {"file": fileId});

      if (response.statusCode == 200) {
        Constant.showMessege("Request Succesful ");

        print(response.data);
        isloadingAssetConvert(false);

        Get.find<MediaSuitController>().setDataEditAudio(
            editVideoDataList[selectedVideoIndex.value!].name,
            editVideoDataList[selectedVideoIndex.value!].urlMedia!,
            editVideoDataList[selectedVideoIndex.value!].assetId.toString(),
            isloading: true);
        selectedVideoIndex.value = null;
      } else {
        // Handle errors
        Constant.showMessege("Request Denied : ${response.data['status']}");
        isloadingAssetConvert(false);
      }
    } catch (e) {
      // Handle errors
      Constant.showMessege("Request Denied : ${e.toString()}");
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  ///Convert asset TimeLine [selectedTextIndex]
  Future<String> _runCustomSelectBottomSheet(
      List<String> models, String title) async {
    var sxz = await Get.bottomSheet(Container(
      width: 100.w,
      height: 50.h,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
          color: "474755".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3.h,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (s, p) {
              return InkWell(
                onTap: () {
                  try {
                    return Get.back(result: models.elementAt(p));
                  } catch (e) {
                    // TODO
                  }
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  height: 4.h,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        models.elementAt(p),
                        style: TextStyle(color: Colors.white.withOpacity(0.4)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 100.w,
                        height: 1,
                        color: Colors.white.withOpacity(0.15),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: models.length,
          ))
        ],
      ),
    ));
    return sxz.toString();
  }

  void textToImage() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editTextDataList[selectedTextIndex.value!].assetId;
    print('DetailController.textToImage = ${{
      "file": fileId,
      "asset_id": fileId,
      "size": "1024x1024"
    }}');
    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/text-image';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s.post(
        apiUrl,
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {"file": fileId, "size": "1024x1024"},
      );

      print(
          'DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        print('result:');
        print(response.data);
        Constant.showMessege("Request Succesful  ");
        Get.find<MediaSuitController>().setDataEditImage(
            editTextDataList[selectedTextIndex.value!].name,
            editTextDataList[selectedTextIndex.value!].urlMedia!,
            editTextDataList[selectedTextIndex.value!].assetId!,
            isloading: true);
        isloadingAssetConvert(false);
      } else {
        // Handle errors
        // Constant.showMessege("Request Denied : ${response.data['status']}");
        isloadingAssetConvert(false);
      }
    } catch (e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  void textToSpeech() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editTextDataList[selectedTextIndex.value!].assetId;
    String language = await _runCustomSelectBottomSheet(
        Constant.languages, "Select Language");
    String loclae = Constant.languageMap[language] ?? "";
    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/text-audio';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s.post(
        apiUrl,
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {"file": fileId, "language": loclae},
      );

      print(
          'DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        isloadingAssetConvert(false);

        Constant.showMessege("Request Succesful  ");
        Get.find<MediaSuitController>().setDataEditAudio(
            editTextDataList[selectedTextIndex.value!].name,
            editTextDataList[selectedTextIndex.value!].urlMedia!,
            editTextDataList[selectedTextIndex.value!].assetId!,
            isloading: true);
      } else {
        // Handle errors
        //Constant.showMessege("Request Denied : ${response.data['status']}");
      }
    } catch (e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {
      isloadingAssetConvert(false);
    }
  }

  void translateText() async {
    isloadingAssetConvert(true);
    isWaitingAssetConvert(true);
    var fileId = editTextDataList[selectedTextIndex.value!].assetId;
    String language = await _runCustomSelectBottomSheet(
        Constant.languages, "Select Language");
    String loclae = Constant.languageMap[language] ?? "";
    try {
      final token = GetStorage().read("token");

      String apiUrl = '${Constant.HTTP_HOST}tasks/text-translate';
      var s = Dio();
      s.interceptors.add(MediaVerseConvertInterceptor());
      var response = await s.post(
        apiUrl,
        options: Options(
          headers: {
            'accept': 'application/json',
            'X-App': '_Android',
            'Accept-Language': 'en-US',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {"file": fileId, "language": loclae},
      );

      print(
          'DetailController._fetchMediaData = ${response.statusCode}  - ${response.data}');
      if (response.statusCode == 200) {
        isloadingAssetConvert(false);

        Constant.showMessege("Request Succesful  ");
        Get.find<MediaSuitController>().setDataEditText(
            editTextDataList[selectedTextIndex.value!].name,
            editTextDataList[selectedTextIndex.value!].urlMedia!,
            editTextDataList[selectedTextIndex.value!].assetId!,
            isloading: true);
        print(response.data);
      } else {
        // Handle errors
        //   Constant.showMessege("Request Denied : ${response.data['status']}");
        isloadingAssetConvert(false);
      }
    } catch (e) {
      // Handle errors
      // Constant.showMessege("Request Denied : ${e.toString()}");
      isloadingAssetConvert(false);

      print('DetailController._fetchMediaData = $e');
    } finally {}
  }

  //Multi Select

  var tempSelectedItems = <EditDataModel>[].obs;

  void confirmSelection() {
    for (var item in tempSelectedItems) {
      if (item.mediaClass == 1) {
        setDataEditText(item.name, item.urlMedia!, item.assetId!,
            isloading: item.isloading);
      } else if (item.mediaClass == 2) {
        setDataEditImage(item.name, item.urlMedia!, item.assetId!,
            isloading: item.isloading);
      } else if (item.mediaClass == 3) {
        setDataEditAudio(item.name, item.urlMedia!, item.assetId!,
            isloading: item.isloading);
      } else if (item.mediaClass == 4) {
        setDataEditVideo(item.name, item.urlMedia!, item.defaultWidthVideo ?? 3.0, item.assetId!,
            isloading: item.isloading);
      }
    }
    tempSelectedItems.clear();
  }

  void addItemToTempList(
      String name, String url, widthVideoItem, String assetId, int mediaClass,
      {bool isloading = false}) {
    if (mediaClass == 1) {
      tempSelectedItems
          .add(EditDataModel(name, url, 0, assetId, 1, isloading: isloading));
    } else if (mediaClass == 2) {
      tempSelectedItems
          .add(EditDataModel(name, url, 0, assetId, 2, isloading: isloading));
    } else if (mediaClass == 3) {
      tempSelectedItems
          .add(EditDataModel(name, url, 0, assetId, 3, isloading: isloading));
    } else if (mediaClass == 4) {
      tempSelectedItems.add(EditDataModel(name, url, widthVideoItem, assetId, 4,
          isloading: isloading));
    } else {}
  }

  void removeItemFromTempList(String assetId) {
    tempSelectedItems.removeWhere((item) => item.assetId == assetId);
  }

  void setDataEditText(String name, String textUrl, String assetId,
      {bool isloading = false}) {
    editTextDataList
        .add(EditDataModel(name, textUrl, 0, assetId, 1, isloading: isloading));

    selectedTextIndex.value = editTextDataList.length - 1;
  }

  void setDataEditImage(String name, String imageUrl, String assetId,
      {bool isloading = false}) {
    editImageDataList.add(
        EditDataModel(name, imageUrl, 0, assetId, 2, isloading: isloading));
    selectedImageIndex.value = editImageDataList.length - 1;
  }

  void setDataEditVideo(
      String name, String videoUrl, double videoTime, String assetId,
      {bool isloading = false}) {
    double widthVideoItem = videoTime * 16.0;

    editVideoDataList.add(EditDataModel(
        name, videoUrl, widthVideoItem, assetId, 4,
        isloading: isloading, second: videoTime));

    selectedVideoIndex.value = editVideoDataList.length - 1;
  }

  void setDataEditAudio(
    String name,
    String audioUrl,
    String assetId, {
    bool isloading = false,
    double time = 5,
  }) {
    editAudioDataList.add(EditDataModel(name, audioUrl, 0, assetId, 3,
        isloading: isloading, second: time));

    selectedAudioIndex.value = editAudioDataList.length - 1;
  }

  //video player

  //

  double minPaddingValue = 25;
  double maxPaddingValue = 40.0;

  void selectFirstMediaSelected() {
    if (selectedVideoIndex.value == null && editVideoDataList.isNotEmpty) {
      selectedVideoIndex(0);
    } else if (selectedAudioIndex.value == null &&
        editAudioDataList.isNotEmpty) {
      selectedAudioIndex(0);
    }
  }

  String videoConfig() {
    if (editVideoDataList.isNotEmpty) {
      List<Map<String, dynamic>> jsonList = [];
      int previousItemEnd = 0;
      for (int i = 0; i < editVideoDataList.length; i++) {
        var currentItem = editVideoDataList[i];
        var currentItemEnd =
            previousItemEnd + currentItem.defaultWidthVideo!.round();

        var resultEnd = currentItemEnd / 16;

        currentItem.start = previousItemEnd + 1;
        // var endTime = currentItem.second.toInt();
        currentItem.end = resultEnd.toInt();

        if (i > 0) {
          currentItem.end = resultEnd.toInt() * 2;
        }
        currentItem.length = currentItem.end - currentItem.start;
        jsonList.add(currentItem.toJson());

        previousItemEnd = resultEnd.toInt();
      }

      String jsonData = jsonEncode(jsonList);
      print(jsonData);

      return jsonData;
    } else {
      return "null";
    }
  }

  String textConfig() {
    if (editTextDataList.isNotEmpty) {
      List<Map<String, dynamic>> jsonList = [];
      int previousEnd = 0;

      for (int i = 0; i < editTextDataList.length; i++) {
        var currentItem = editTextDataList[i];
        currentItem.start =
            previousEnd + 1; // Ensure the start is properly updated
        currentItem.end = currentItem.start +
            currentItem.second
                .toInt(); // Calculate the end time based on the item's length

        jsonList.add({
          'start': currentItem.start,
          'end': currentItem.end,
          'length': currentItem.end - currentItem.start,
          'id': currentItem.assetId,
        });

        previousEnd = currentItem.end; // Update previousEnd for the next item
      }

      String jsonData = jsonEncode(jsonList);
      print(jsonData);
      return jsonData;
    } else {
      print('empty List - TEXT');
      return "null";
    }
  }

  String imageConfig() {
    if (editImageDataList.isNotEmpty) {
      List<Map<String, dynamic>> jsonList = [];
      int previousEnd = 0;

      for (int i = 0; i < editImageDataList.length; i++) {
        var currentItem = editImageDataList[i];
        currentItem.start = previousEnd + 1;
        currentItem.end = currentItem.start + currentItem.second.toInt();

        jsonList.add({
          'start': currentItem.start,
          'end': currentItem.end,
          'length': currentItem.end - currentItem.start,
          'id': currentItem.assetId,
        });

        previousEnd = currentItem.end;
      }

      String jsonData = jsonEncode(jsonList);
      print(jsonData);
      return jsonData;
    } else {
      print('empty List - IMAGE');
      return "null";
    }
  }

  String audioConfig() {
    if (editAudioDataList.isNotEmpty) {
      List<Map<String, dynamic>> jsonList = [];
      int previousEnd = 0;

      for (int i = 0; i < editAudioDataList.length; i++) {
        var currentItem = editAudioDataList[i];
        currentItem.start = previousEnd + 1;
        currentItem.end = currentItem.start + currentItem.second.toInt();

        jsonList.add({
          'start': currentItem.start,
          'end': currentItem.end,
          'length': currentItem.end - currentItem.start,
          'id': currentItem.assetId,
        });

        previousEnd = currentItem.end;
      }

      String jsonData = jsonEncode(jsonList);
      print(jsonData);
      return jsonData;
    } else {
      print('empty List - AUDIO');
      return "null";
    }
  }

  void exportOnline() async {
    selectedTextIndex.value = null;
    selectedVideoIndex.value = null;
    selectedImageIndex.value = null;
    selectedAudioIndex.value = null;

    print('====================Video==============================');
    var video = videoConfig();
    print('==============================Text====================');
    var text = textConfig();
    print('====================Image==============================');
    var image = imageConfig();
    print('====================Audio==============================');
    var audi = audioConfig();

    isloadingSubmit(true);

    var dio = Dio();
    var body;

    var tacks = [];
    if (video.contains("null") == false) {
      tacks.add({
        "type": "video",
        "items": jsonDecode(video.replaceAll("asset_id", "id"))
      });
    }
    if (audi.contains("null") == false) {
      tacks.add({
        "type": "audio",
        "items": jsonDecode(audi.replaceAll("asset_id", "id"))
      });
    }
    if (image.contains("null") == false) {
      tacks.add({
        "type": "image",
        "items": jsonDecode(image.replaceAll("asset_id", "id"))
      });
    }
    if (text.contains("null") == false) {
      tacks.add({
        "type": "text",
        "items": jsonDecode(text.replaceAll("asset_id", "id"))
      });
    }
    body = {'tracks': tacks};

    print('ShareAccountLogic.sendIDTokenToServer = ${jsonEncode(body)}');
    dio.interceptors.add(MediaVerseConvertInterceptor());
    dio.interceptors.add(CurlLoggerDioInterceptor());

    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}tasks/mix',
        data: jsonEncode(body),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'X-App': '_Android',
          },
        ),
      );

      if (response.statusCode! >= 200 || response.statusCode! < 300) {
        print(
            '==================================================================================================');
        print('Time line Asset Create successfully = ${response.data}');
        print(
            '==================================================================================================');
        clearTimeline();
        Constant.showMessege(
            "Time line Asset Create successfully Wait To Render...");
      } else {
        isloadingSubmit(false);

        print('Failed to upload file: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      isloadingSubmit(false);

      print('DioError: ${e.response!.statusCode}');
    }
  }

  void setAssetLoadingValue(String s) {
    //  debugger();

    var json = jsonDecode(s);
    String url_media =
        "${"https://" + json['storage']}.mediaverse.app/${json['path']}";
    editAudioDataList.forEach((element) {
      if (element.isloading) {
        element.assetId = json['asset_id'];
        element.urlMedia = url_media;
        element.isloading = false;
      }
    });
    editImageDataList.forEach((element) {
      if (element.isloading) {
        element.assetId = json['asset_id'];
        element.urlMedia = url_media;
        element.isloading = false;
      }
    });

    editVideoDataList.forEach((element) {
      if (element.isloading) {
        element.assetId = json['asset_id'];
        element.urlMedia = url_media;
        element.isloading = false;
      }
    });
    editTextDataList.forEach((element) {
      if (element.isloading) {
        element.assetId = json['asset_id'];
        element.urlMedia = url_media;
        element.isloading = false;
      }
    });

    update();
  }
}

//helper

class DurationAudio {
  static formtTime(Duration value) {
    String digit(int n) => n.toString().padLeft(2, '0');
    final hour = digit(value.inHours);
    final min = digit(value.inMinutes.remainder(60));
    final sec = digit(value.inSeconds.remainder(60));
    return [if (value.inHours > 0) hour, min, sec].join(":");
  }
}

// class ScrollSynchronizer {
//   final List<ScrollController> _controllers = [];
//   bool _scrolling = false;
//   double _lastScrollOffset = 0;
//
//   void scrollListener(ScrollController controller) {
//     if (_scrolling) return;
//
//     double currentScroll = controller.position.pixels;
//     double scrollDifference = currentScroll - _lastScrollOffset;
//
//     _controllers.forEach((c) {
//       if (c != controller) {
//         c.jumpTo(currentScroll);
//       }
//     });
//
//     _lastScrollOffset = currentScroll;
//   }
//
//   void registerScrollController(ScrollController controller) {
//     _controllers.add(controller);
//     controller.addListener(() {
//       if (!_scrolling) {
//         _scrolling = true;
//         _controllers.forEach((c) {
//           if (c != controller) c.animateTo(controller.position.pixels, duration: Duration(milliseconds: 300), curve: Curves.ease);
//         });
//         _scrolling = false;
//       }
//     });
//   }
//
//   void unregisterScrollController(ScrollController controller) {
//     _controllers.remove(controller);
//   }
// }
//v2
// class ScrollSynchronizer {
//   final List<ScrollController> _controllers = [];
//   bool _scrolling = false;
//
//   void scrollListener(ScrollController controller) {
//     if (_scrolling) return;
//
//     _scrolling = true;
//     double currentScroll = controller.position.pixels;
//
//     for (var c in _controllers) {
//       if (c != controller) {
//         c.jumpTo(currentScroll);
//       }
//     }
//
//     _scrolling = false;
//   }
//
//   void registerScrollController(ScrollController controller) {
//     _controllers.add(controller);
//     controller.addListener(() => scrollListener(controller));
//   }
//
//   void unregisterScrollController(ScrollController controller) {
//     _controllers.remove(controller);
//   }
// }
class ScrollSynchronizer {
  final List<ScrollController> _controllers = [];
  bool _scrolling = false;

  void scrollListener(ScrollController controller) {
    if (_scrolling) return;

    _scrolling = true;
    double currentScroll = controller.position.pixels;

    for (var c in _controllers) {
      if (c != controller) {
        print('Synchronizing scroll position: ${currentScroll}');
        c.jumpTo(currentScroll);
      }
    }

    _scrolling = false;
  }

  void registerScrollController(ScrollController controller) {
    if (!_controllers.contains(controller)) {
      _controllers.add(controller);
      controller.addListener(() => scrollListener(controller));
    }
  }

  void unregisterScrollController(ScrollController controller) {
    if (_controllers.contains(controller)) {
      controller.removeListener(() => scrollListener(controller));
      _controllers.remove(controller);
    }
  }
}

///video action

class ActionEditorModel {
  String nameItem;
  Function() onTap;

  ActionEditorModel({required this.nameItem, required this.onTap});
}
