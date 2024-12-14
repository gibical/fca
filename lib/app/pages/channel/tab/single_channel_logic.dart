import 'dart:convert';

import 'package:dio/dio.dart';
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

  var isloading =false.obs;


  late ApiRequster apiRequster;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiRequster = ApiRequster(this,develperModel: true);
    getSingleChannel();
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    switch(reqCdoe){
      case 1:
        parseFromJsonSingleChannel(source);
        break;
    }
  }

  void getSingleChannel() {
    isloading(true);
    apiRequster.request("channels/${channelsModel.id}", ApiRequster.MHETOD_GET, 1);
  }

  void parseFromJsonSingleChannel(source) {
    channelsModel = ChannelsModel.fromJson(jsonDecode(source)['data']);
    isloading(false);

  }

  void addDestination() async{
    await Get.toNamed(PageRoutes.SHAREACCOUNT, arguments: [
      "onTapChannelManagement",
      "asd",
      channelsModel.destinations??[]
    ]);

    List<Destinations> destinationModelList = Get.find<ShareAccountLogic>().destinationModelList;
    int index =0;
    destinationModelList.forEach((action)async{
      index++;
      if (channelsModel.destinations.firstWhereOrNull((test)=>test.id.toString().contains(action.id.toString()))==null) {
        await addFromDestinationModelList(channelsModel.id!,action.id!);
      }
      if(index==destinationModelList.length-1){
        getSingleChannel()
;      }
    });


  }

  Future<bool> addFromDestinationModelList(String channel, String destination) async {
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
  Future<bool> deleteDestinationModelList(String channel, String destination) async {
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
    deleteDestinationModelList(channelsModel.id!,value.id!);
    channelsModel.destinations.removeWhere((test)=>test.id.toString().contains(value.id.toString()));
    update();
  }
}