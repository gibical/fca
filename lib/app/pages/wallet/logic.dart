import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetWallet.dart';
import 'package:meta/meta.dart';

class WalletController extends GetxController implements RequestInterface{
  late ApiRequster apiRequster;

  var isloading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
    getWalletBalance();
  //  getStripe();
  }
  
  getWalletBalance(){
    isloading(true);
    apiRequster.request("wallets", ApiRequster.MHETOD_GET, 1,useToken: true);
  }

  getStripe(){
   // isloading(true);
    apiRequster.request("stripe/account", ApiRequster.MHETOD_GET, 2,useToken: true);
  }
  getStripeConnect(){
   // isloading(true);
    apiRequster.request("stripe/connect", ApiRequster.MHETOD_POST, 3,useToken: true);
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
    if(reqCode==2){
      getStripeConnect();
    }
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
   // walletModel = WalletModel.fromJson(jsonDecode(source)[0]);
    isloading(false);

  }






  ///New Version of API



  void bill(){

    apiRequster.request("bills", ApiRequster.MHETOD_GET, 1);
  }

  void invoices(){

    apiRequster.request("invoices", ApiRequster.MHETOD_GET, 2);
  }


  void invoicesLink(invoideID){

    apiRequster.request("invoices/${invoideID}/link", ApiRequster.MHETOD_GET, 3);
  }


  void stripeSubscription(){

    apiRequster.request("stripe/subscription", ApiRequster.MHETOD_GET, 4);
  }

  void stripeSubscriptionLink(){

    apiRequster.request("stripe/subscription/link", ApiRequster.MHETOD_GET, 4);
  }
  void stripPeyout(){

    apiRequster.request("stripe/payout", ApiRequster.MHETOD_GET, 5);
  }
  void stripPeyoutLink(){

    apiRequster.request("stripe/payout", ApiRequster.MHETOD_GET, 5);
  }





}




