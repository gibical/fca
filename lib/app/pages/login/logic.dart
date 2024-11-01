import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';

import 'package:country_picker/country_picker.dart';
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

import '../../../gen/model/json/FromJsonGetLoginV2.dart';
import '../../common/app_color.dart';

class LoginController extends GetxController implements RequestInterface {

  late ApiRequster apiRequster;

  CountryCode code = CountryCode(dialCode: "+33");
  var timeLeft = 30.obs; // Observable variable
  Timer? _timer;



  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (timeLeft.value == 0) {
        _timer?.cancel();
        timeLeft.value = 0;
        update(); // This is optional since we are using .obs
      } else {
        timeLeft.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }


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
  TextEditingController  eTextEditingControllerOTP = TextEditingController();


  ///bool
  var isloading = false.obs;


  requestLogin(){

    isloading(true);
    switch(loginEnum){

      case LoginEnum.phone:
        // TODO: Handle this case.

        if(eTextEditingControllerPhone.text.isEmpty||eTextEditingControllerPassword.text.isEmpty){
       Constant.showMessege("Please fill out the form");
          isloading(false);

          break;
        }


        _getPhoneReuqest();
        break;
      case LoginEnum.username:
        // TODO: Handle this case.

        if(eTextEditingControllerUsername.text.isEmpty||eTextEditingControllerPassword.text.isEmpty){
          Constant.showMessege("Please fill out the form");
          isloading(false);

          break;
        }
        _getUseranmeReuqest();
        break;

      case LoginEnum.SMS:
        if(eTextEditingControllerPhone.text.isEmpty){
          Constant.showMessege("Please fill out the form");
          isloading(false);

          break;
        }
        _getOTPReuqest();

    // TODO: Handle this case.
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
      "cellphone": code.dialCode!+eTextEditingControllerPhone.text,
      "password":eTextEditingControllerPassword.text
    };
     apiRequster.request("auth/sign-in", ApiRequster.MHETOD_POST, 1,body: body);
    print('LoginController._getPhoneReuqest = ${body}');
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

    try {
      timeLeft = (jsonDecode(source)['expires_after'] as int).obs;
      startTimer();
    }  catch (e) {
      // TODO
      print('LoginController.peaseJsonFromGetPhoneOTP = ${e}');
    }

    update();

    if (!Get.currentRoute.contains(PageRoutes.OTP)) {
      Get.toNamed(PageRoutes.OTP,arguments: [this]);
    }
  }

  void praseJsonFromGetLogin(source) {

    box.write("islogin", true);

    FromJsonGetLoginV2 getLogin = FromJsonGetLoginV2.fromJson(jsonDecode(source));
    box.write("token", getLogin.token??"");
    box.write("userid", getLogin.user!.id.toString());
    Get.offAllNamed(PageRoutes.WRAPPER);
  }

  void _getOTPReuqest() {
    var body = {
      "cellphone":(code.dialCode??"")+(eTextEditingControllerPhone.text),
    };
    print('LoginController._getOTPReuqest = ${body}');
    apiRequster.request("auth/otp/request", ApiRequster.MHETOD_POST, 2,body: body);
  }
  void getOTPSumbit() {
    isloading(true);
    var body = {
      "cellphone":"${code.dialCode}${eTextEditingControllerPhone.text}",
      "otp":eTextEditingControllerOTP.text,
    };
    apiRequster.request("auth/otp/submit", ApiRequster.MHETOD_POST, 1,body: body);
  }

  void sendIDTokenToServer(String s) {
    apiRequster.request("auth/google", ApiRequster.MHETOD_POST, 1,body: {
      "access_token":s
    });

  }


}