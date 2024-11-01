import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetSessions.dart';

import '../../../gen/model/json/walletV2/FromJsonGetSesseinsModel.dart';
import 'state.dart';

class SessionsLogic extends GetxController implements RequestInterface {
  final SessionsState state = SessionsState();
  
  var isloading = true.obs;
  List<SessionsModels> list = [];
  late ApiRequster apiRequster;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: true);
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
    list = fromJsonGetSesseinsModelFromJson(source).data??[];
    isloading(false);
  }
}
