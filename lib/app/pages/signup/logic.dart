import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:meta/meta.dart';

import '../../../gen/model/json/FromJsonGetCountriesModel.dart';
import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../../common/utils/dio_inperactor.dart';

class SignUpController extends GetxController implements RequestInterface{

  late ApiRequster apiRequster;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameNameController = TextEditingController();
  TextEditingController passwordNameController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  List<CountriesModel> countreisModel =[];
  List<String> countreisString =[];

  Future<void> getAllCountries() async {
    print('SignUpController.getAllCountries 1 ');
    var dio = Dio();


    //  debugger();
    dio.interceptors.add(MediaVerseConvertInterceptor());

    print('PlusSectionLogic.getAllCountries = ${Constant.HTTP_HOST}countries');
    try {

      print('PlusSectionLogic.getAllCountries 1');

      var response = await dio.get(
        '${Constant.HTTP_HOST}countries',
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'X-App': '_Android',
          },
        ),

      );
      print('PlusSectionLogic.getAllCountries 1 = ${response.statusCode}  - ${response.data}');

      //   debugger();
      if (response.statusCode! >= 200||response.statusCode! < 300) {
        print('PlusSectionLogic.getAllCountries 2');


        (response.data['data'] as List<dynamic>).forEach((element) {
          countreisModel.add(CountriesModel.fromJson(element));
        });
        (countreisModel).forEach((element) {
          countreisString.add(element.title??"");
        });
        update();
        print('PlusSectionLogic.getAllCountries = ${countreisModel.length}');
      } else {
        print('Failed to upload file: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
    }
  }

  var isloading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: false);
    getAllCountries();
  }
  signUpRequest(){
    isloading(true);
    var body = {

      "username": usernameNameController.text,
      "password": passwordNameController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "country_iso":countreisModel.firstWhere((element) => element.title.toString().contains(languageController.text)).iso??"",
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