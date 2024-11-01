import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../gen/model/json/FromJsonGetTransactions.dart';
import '../../../gen/model/json/walletV2/FromJsomGetBills.dart';
import '../../common/RequestInterface.dart';
import '../../common/app_api.dart';
import 'state.dart';

class TransactionsLogic extends GetxController  implements RequestInterface{
  late ApiRequster apiRequster;

  var isloading = false.obs;

  List<BilingModel> list = [ ];
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
  }

  getWalletBalance(){
    apiRequster = ApiRequster(this,develperModel: false);

    print('TransactionsLogic.getWalletBalance');
    isloading(true);
    apiRequster.request("bills", ApiRequster.MHETOD_GET, 1,useToken: true);
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
        parseJsonFromGetWalletBalance(source);
    }
  }

  void parseJsonFromGetWalletBalance(source) {
   // debugger();

    list = FromJsomGetBills.fromJson(jsonDecode(source)).data??[];
    print('TransactionsLogic.parseJsonFromGetWalletBalance = ${source}');
    isloading(false);

  }
}
