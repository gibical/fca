import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetSessions.dart';

import 'state.dart';

class SessionsLogic extends GetxController implements RequestInterface {
  final SessionsState state = SessionsState();
  
  var isloading = true.obs;
  List<SessionsModel> list = [];
  late ApiRequster apiRequster;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
    getSessions();
  }
  
  getSessions(){
    apiRequster.request("sessions", ApiRequster.MHETOD_GET, 1,useToken: true);
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
    list = FromJsonGetSessions.fromJson(jsonDecode(source)).data??[];
    isloading(false);
  }
}
