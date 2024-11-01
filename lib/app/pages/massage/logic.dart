import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetMesseges.dart';
import 'package:meta/meta.dart';

import '../../../gen/model/json/FromJsonGetSessions.dart';
import '../../common/app_api.dart';

class MessegeController extends GetxController implements RequestInterface {

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  var isloading = true.obs;
  List<MessegesModel> list = [];
  late ApiRequster apiRequster;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
    getSessions();
  }

  getSessions(){
    apiRequster.request("notifications", ApiRequster.MHETOD_GET, 1,useToken: true);
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
    list = FromJsonGetMesseges.fromJson(jsonDecode(source)).data??[];
    isloading(false);
  }
}