import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/gen/model/enums/login_enum.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetLogin.dart';
import 'package:meta/meta.dart';

import '../../common/app_color.dart';

class LoginController extends GetxController implements RequestInterface {

  late ApiRequster apiRequster;


  var box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    apiRequster = ApiRequster(this,develperModel: true);
  }





  LoginEnum loginEnum = LoginEnum.phone;

  ///TextControllers


  TextEditingController  eTextEditingControllerPhone = TextEditingController();
  TextEditingController  eTextEditingControllerUsername = TextEditingController();
  TextEditingController  eTextEditingControllerEmail = TextEditingController();
  TextEditingController  eTextEditingControllerPassword = TextEditingController();


  ///bool
  var isloading = false.obs;


  requestLogin(){

    isloading(true);
    switch(loginEnum){

      case LoginEnum.phone:
        // TODO: Handle this case.

        if(eTextEditingControllerPhone.text.isEmpty||eTextEditingControllerPassword.text.isEmpty){
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("Please fill out the form",
            style: TextStyle(color: AppColor.primaryDarkColor),)));
          isloading(false);

          break;
        }


        _getPhoneReuqest();
        break;
      case LoginEnum.username:
        // TODO: Handle this case.
        if(eTextEditingControllerUsername.text.isEmpty||eTextEditingControllerPassword.text.isEmpty){
          ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("Please fill out the form",
            style: TextStyle(color: AppColor.primaryDarkColor),)));
          isloading(false);

          break;
        }
        _getUseranmeReuqest();
        break;

    }
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
    isloading(false);
    print('LoginController.onError ${bodyError}');
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
    isloading(false);

    switch(reqCdoe){
      case 1 :
        praseJsonFromGetLogin(source);
      case 2 :
        peaseJsonFromGetPhoneOTP(source);
    }
  }

  void _getPhoneReuqest()async {

    var body = {
      "cellphone":eTextEditingControllerPhone.text,
      "password":eTextEditingControllerPassword.text
    };
     apiRequster.request("auth/sign-in", ApiRequster.MHETOD_POST, 1,body: body);
   //  apiRequster.request("https://api64.ipify.org?format=json", ApiRequster.MHETOD_GET, 1, daynamicUrl: true);
  }

  void _getUseranmeReuqest() {
    var body = {
      "password":eTextEditingControllerPassword.text
    };
    if(!eTextEditingControllerUsername.text.isEmail){

      body  ['username'] =  eTextEditingControllerUsername.text;
    }else{
      body  ['email'] =  eTextEditingControllerUsername.text;

    }
    apiRequster.request("auth/sign-in", ApiRequster.MHETOD_POST, 1,body: body);
  }

  void peaseJsonFromGetPhoneOTP(source) {

  }

  void praseJsonFromGetLogin(source) {

    box.write("islogin", true);

    FromJsonGetLogin getLogin = FromJsonGetLogin.fromJson(jsonDecode(source));
    box.write("token", getLogin.token??"");
    Get.offAllNamed(PageRoutes.HOME);
  }


}