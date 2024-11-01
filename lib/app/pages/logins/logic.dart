import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetLogins.dart';

import '../../../gen/model/json/FromJsonGetSessions.dart';
import '../../common/app_api.dart';
import 'state.dart';

class LoginsLogic extends GetxController implements RequestInterface{
  final LoginsState state = LoginsState();

  var isloading = true.obs;
  List<dynamic> list = [];
  late ApiRequster apiRequster;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
    getSessions();
  }

  getSessions(){
    apiRequster.request("sign-ins", ApiRequster.MHETOD_GET, 1,useToken: true);
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
    list = jsonDecode(source)['data'];

    isloading(false);
  }
}
