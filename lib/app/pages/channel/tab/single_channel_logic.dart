import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:meta/meta.dart';

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
    print('SingleChannelLogic.parseFromJsonSingleChannel = ${channelsModel.programs?.length}');
    isloading(false);

  }


}