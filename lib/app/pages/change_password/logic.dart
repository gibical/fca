import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';

import '../../common/app_color.dart';
import 'state.dart';

class ChangePasswordLogic extends GetxController implements  RequestInterface{
  final ChangePasswordState state = ChangePasswordState();


  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController eTextEditingControllerOTP = TextEditingController();

  late ApiRequster apiRequster;

  var isloading  =false.obs;
  var isShowCode  =false.obs;
  @override
  void onReady() {
    apiRequster = ApiRequster(this,develperModel: false);
    // TODO: implement onReady
    super.onReady();
  }


  void changePassword(){
    if (isShowCode.isFalse) {
      var body = {
        "password": passwordController.text,
        "password_confirmation": repeatPasswordController.text,
        "otp": "asf",
      };
      isloading(true);

      apiRequster.request("profile/password", ApiRequster.MHETOD_PATCH, 1,body: body,useToken: true);
    }else{
      var body = {
        "otp": eTextEditingControllerOTP.text,

      };
      isloading(true);

      apiRequster.request("profile/password/otp", ApiRequster.MHETOD_POST, 2,body: body,useToken: true);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
    isloading(false);

    try{
      var messege = jsonDecode(bodyError)['message'];
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(messege,
        style: TextStyle(color: AppColor.primaryDarkColor),)));

    }catch(e){

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
        parseJsonFromGetExpierAfter(source);
      case 2:
        parseJsonFromOTPcode(source);
    }
  }

  void parseJsonFromGetExpierAfter(source) {
    isShowCode(true);
    isloading(false);
  }

  void parseJsonFromOTPcode(source) {
    Constant.showMessege("Request Succesfuly");
    isloading(false);

    Get.back();
  }
}
