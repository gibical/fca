import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetWallet.dart';
import 'package:meta/meta.dart';

class WalletController extends GetxController implements RequestInterface{
  late ApiRequster apiRequster;

  var isloading = false.obs;

  WalletModel walletModel = WalletModel();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: true);
    getWalletBalance();
  }
  
  getWalletBalance(){
    isloading(true);
    apiRequster.request("wallets", ApiRequster.MHETOD_GET, 1,useToken: true);
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
    walletModel = WalletModel.fromJson(jsonDecode(source)[0]);
    isloading(false);

  }

}