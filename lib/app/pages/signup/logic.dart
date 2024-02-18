import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:meta/meta.dart';

import '../../common/app_color.dart';

class SignUpController extends GetxController implements RequestInterface{

  late ApiRequster apiRequster;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();


  var isloading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
  }
  signUpRequest(){
    isloading(true);
    var body = {

      "username": usernameNameController.text,
      "password": passwordNameController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text
    };
    print('SignUpController.signUpRequest = ${body}');
    apiRequster.request("auth/sign-up-completion", ApiRequster.MHETOD_POST, 1,body: body);

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
    Get.offAllNamed(PageRoutes.SPLASH);

  }

}