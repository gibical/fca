import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:meta/meta.dart';

class SingleChannelLogic extends GetxController implements RequestInterface {
  SingleChannelLogic(this.channelsModel);
  ChannelsModel channelsModel;

  var isloading =false.obs;



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
  }


}