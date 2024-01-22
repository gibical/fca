import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/enums/login_enum.dart';
import 'package:meta/meta.dart';

class LoginController extends GetxController implements RequestInterface {

  late ApiRequster apiRequster;


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
    switch(loginEnum){

      case LoginEnum.phone:
        // TODO: Handle this case.


        _getPhoneReuqest();
        break;
      case LoginEnum.username:
        // TODO: Handle this case.
        _getPhoneReuqest();
        break;

    }
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
      case 1 :
        peaseJsonFromGetPhoneOTP(source);
    }
  }

  void _getPhoneReuqest()async {
    // var headers = {
    //   'accept': 'application/json',
    //   'Content-Type': 'application/json',
    //   'X-App': '_Android',
    //   'Accept-Language': 'en-US'
    // };
    // var request = http.Request('POST', Uri.parse('https://api.mediaverse.studio/v2/auth/sign-in'));
    // request.body = jsonEncode({
    //   "cellphone": "+33652764350",
    //   "password": "secret69"
    // });
    // request.headers.addAll(headers);
    // var s = await request.send();
    // print('LoginController._getPhoneReuqest= ${s.statusCode}');
    // var body = {
    //   "cellphone":eTextEditingControllerPhone.text,
    //   "password":eTextEditingControllerPassword.text
    // };
    // apiRequster.request("auth/sign-in", ApiRequster.MHETOD_POST, 1,body: body);
     apiRequster.request("https://api64.ipify.org?format=json", ApiRequster.MHETOD_GET, 1,
     daynamicUrl: true);
  }

  void _getUseranmeReuqest() {
    var body = {
      "password":eTextEditingControllerPassword.text
    };
    if(eTextEditingControllerUsername.text.isEmail){

      body  ['username'] =  eTextEditingControllerUsername.text;
    }else{
      body  ['email'] =  eTextEditingControllerUsername.text;

    }
    apiRequster.request("phoneEndPoint", ApiRequster.MHETOD_POST, 1,body: body);
  }

  void peaseJsonFromGetPhoneOTP(source) {

  }


}