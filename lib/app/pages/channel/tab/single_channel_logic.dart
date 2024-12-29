import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:meta/meta.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player/video_player.dart';

import '../../../../gen/model/json/FromJsonGetChannelsLive.dart';
import '../../../../gen/model/json/walletV2/FromJsonGetDestination.dart';
import '../../../common/app_config.dart';
import '../../../common/app_route.dart';
import '../../../common/utils/dio_inperactor.dart';
import '../../share_account/logic.dart';
import 'ChannalLiveController.dart';

class SingleChannelLogic extends GetxController implements RequestInterface {
  SingleChannelLogic(this.channelsModel);

  ChannelsModel channelsModel;

  ValueKey mainLiveKey = ValueKey("${DateTime.now().millisecondsSinceEpoch}");
  List<LiveModel> livemodels = [];
  var isloading = false.obs;
  var isloadingNewProgram = false.obs;
  var isloadingStartProgram = false.obs;
  var isloadingStopProgram = false.obs;
  var isChannelLiveStarted = false.obs;
  String lastEvent = "";




  late VideoPlayerController controllerVideoPlay;

  // Screenshot and save to gallery
  ScreenshotController screenshotController = ScreenshotController();

  late ApiRequster apiRequster;

  Timer? refreshTimer;

  @override
  void onInit() {
    super.onInit();
    apiRequster = ApiRequster(this, develperModel: false);

    getSingleChannel(true);
    startPeriodicRefresh();
  }

  @override
  void onClose() {
    refreshTimer?.cancel();
    super.onClose();
  }

  void startPeriodicRefresh() {
    refreshTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      getSingleChannel(false);
    });
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    isloadingNewProgram(false);
    isloadingStartProgram(false);
    isloading(false);

    try {
      Constant.showMessege(jsonDecode(bodyError)['message']);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onStartReuqest(int reqCode) {}

  @override
  void onSucces(source, int reqCdoe) {
    switch (reqCdoe) {
      case 1:
        parseFromJsonSingleChannel(source);
        break;
      case 2:
        parseFromJsonNewProgram(source);
        break;
      case 3:
        parseFromJsonEditProgram(source);
        break;
      case 4:
        parseFromJsonGetlives(source);
        break;
      case 5:
        parseFromJsonFromSwitch(source);
        break;
    }
  }

  void getSingleChannel(bool isFirst) {
   if(isFirst) isloading(true);
    apiRequster.request(
        "channels/${channelsModel.id}", ApiRequster.MHETOD_GET, 1);
  }

  void getChannelsLive() {
    apiRequster.request(
        "channels/${channelsModel.id}/lives", ApiRequster.MHETOD_GET, 4);
  }

  void parseFromJsonSingleChannel(source) {
    channelsModel = ChannelsModel.fromJson(jsonDecode(source)['data']);
    if(lastEvent!=channelsModel.lastEvent&&channelsModel.lastEvent.toString().contains("started")){
      isChannelLiveStarted(true);
    }else{
      isChannelLiveStarted(false);
    }
    getChannelsLive();
    isloading(false);
  }

  void addDestination() async {
    await Get.toNamed(PageRoutes.SHAREACCOUNT, arguments: [
      "onTapChannelManagement",
      "asd",
      channelsModel.destinations ?? []
    ]);

    List<Destinations> destinationModelList =
        Get.find<ShareAccountLogic>().destinationModelList;
    int index = 0;
    destinationModelList.forEach((action) async {
      index++;
      if (channelsModel.destinations.firstWhereOrNull(
              (test) => test.id.toString().contains(action.id.toString())) ==
          null) {
        await addFromDestinationModelList(channelsModel.id!, action.id!);
      }
      if (index == destinationModelList.length - 1) {
        getSingleChannel(false);
      }
    });
  }

  Future<bool> addFromDestinationModelList(
      String channel, String destination) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.post(
        '${Constant.HTTP_HOST}channels/$channel/destinations/$destination',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('Request succeeded: ${response.statusCode}');
        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return false;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return false;
    }
  }

  Future<bool> deleteDestinationModelList(
      String channel, String destination) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.delete(
        '${Constant.HTTP_HOST}channels/$channel/destinations/$destination',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('Request succeeded: ${response.statusCode}');
        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return false;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return false;
    }
  }

  void deleteDestionationModel(Destinations value) {
    deleteDestinationModelList(channelsModel.id!, value.id!);
    channelsModel.destinations.removeWhere(
            (test) => test.id.toString().contains(value.id.toString()));
    update();
  }

  void sendNewProgramReqyest(
      TextEditingController nameController,
      TextEditingController programTypeController,
      TextEditingController valueController,
      selectedFileid,
      bool isEdit,
      Programs? program) {
    var body = {
      "name": nameController.text,
      "source": programTypeController.text
    };
    if (programTypeController.text.isEmpty) {
      Constant.showMessege("alert_14".tr);

      return;
    }
    if (programTypeController.text.contains("link") &&
        valueController.text.isEmpty) {
      Constant.showMessege("alert_15".tr);
      return;
    }
    if (programTypeController.text.contains("file") && selectedFileid == null) {
      Constant.showMessege("alert_5".tr);
      return;
    }

    if (programTypeController.text.contains("link")) {
      body['value'] = valueController.text;
    }
    if (programTypeController.text.contains("file")) {
      body['value'] = selectedFileid;
    }
    if (isEdit) {
      body['value'] = selectedFileid;
    }
    isloadingNewProgram(true);

    String url = "";
    if (isEdit) {
      url = "programs/${program!.id}";
    } else {
      url = "channels/${channelsModel.id}/programs";
    }

    apiRequster.request(
        url,
        isEdit ? ApiRequster.MHETOD_PUT : ApiRequster.MHETOD_POST,
        isEdit ? 3 : 2,
        body: body);
  }

  void parseFromJsonNewProgram(source) {
    isloadingNewProgram(false);
    Constant.showMessege("alert_16".tr);
    Get.back(result: true);
  }

  void deleteChannelModel(Programs value) {
    deleteChannelModelList(channelsModel.id!, value.id!);
    channelsModel.programs?.removeWhere(
            (test) => test.id.toString().contains(value.id.toString()));
    update();
  }

  Future<bool> deleteChannelModelList(String s, String t) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.delete(
        '${Constant.HTTP_HOST}programs/$t',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('Request succeeded: ${response.statusCode}');
        return true;
      } else {
        print('Request failed: ${response.statusMessage}');
        return false;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return false;
    }
  }

  void parseFromJsonEditProgram(source) {
    isloadingNewProgram(false);
    Constant.showMessege("alert_17".tr);
    Get.back(result: true);
  }

  Future<DateTime?> startProgram(Programs program) async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    isloadingStartProgram(true);

    try {
      var response = await dio.patch(
        '${Constant.HTTP_HOST}'"programs/${program.id}/start",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('SingleChannelLogic.startProgram = ${response.data}');
      isloadingStartProgram(false);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('Request succeeded: ${response.statusCode}');
        Constant.showMessege("alert_18".tr);
        return DateTime.now();
      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return null;
    }
  }

  void parseFromJsonGetlives(source) {
    livemodels =
        FromJsonGetChannelsLive.fromJson(jsonDecode(source)).data ?? [];
    print('SingleChannelLogic.parseFromJsonGetlives = ${livemodels.length}');
    update();
  }

  void switchTo(String liveID) {
    var body = {
      "live_id":liveID
    };
    apiRequster.request("channels/${channelsModel.id}/switch", ApiRequster.MHETOD_POST, 5,
    useToken: true,body: body);
  }

  void parseFromJsonFromSwitch(source) async{
    Constant.showMessege("alert_19".tr);
  }
}
