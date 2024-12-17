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

import '../../../../gen/model/json/walletV2/FromJsonGetDestination.dart';
import '../../../common/app_config.dart';
import '../../../common/app_route.dart';
import '../../../common/utils/dio_inperactor.dart';
import '../../share_account/logic.dart';

class SingleChannelLogic extends GetxController implements RequestInterface {
  SingleChannelLogic(this.channelsModel);

  ChannelsModel channelsModel;

  var isloading = false.obs;
  var isloadingNewProgram = false.obs;
  var isloadingStartProgram = false.obs;
  var isloadingStopProgram = false.obs;

  late ApiRequster apiRequster;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiRequster = ApiRequster(this, develperModel: true);
    getSingleChannel();
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
    isloadingNewProgram(false);
    isloadingStartProgram(false);
    isloading(false);

    try {
      Constant.showMessege(jsonDecode(bodyError)['message']);
    } catch (e) {
      // TODO
    }
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
        parseFromJsonSingleChannel(source);
        break;
      case 2:
        parseFromJsonNewProgram(source);
      case 3:
        parseFromJsonEditProgram(source);
        break;
    }
  }

  void getSingleChannel() {
    isloading(true);
    apiRequster.request(
        "channels/${channelsModel.id}", ApiRequster.MHETOD_GET, 1);
  }

  void parseFromJsonSingleChannel(source) {
    channelsModel = ChannelsModel.fromJson(jsonDecode(source)['data']);
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
        getSingleChannel();
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
      Constant.showMessege("Please Select Value ");

      return;
    }
    if (programTypeController.text.contains("link") &&
        valueController.text.isEmpty) {
      Constant.showMessege("Please Type Value ");
      return;
    }
    if (programTypeController.text.contains("file") && selectedFileid == null) {
      Constant.showMessege("Please Select Asset ");
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
        3,
        body: body);
  }

  void parseFromJsonNewProgram(source) {
    isloadingNewProgram(false);
    Constant.showMessege("New Program Successfully Created");
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
    Constant.showMessege("Edit Program Successfully");
    Get.back(result: true);
  }
  
  Future<DateTime?> startProgram(Programs program)async{
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
}
