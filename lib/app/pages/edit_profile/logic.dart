import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';

import '../../../gen/model/enums/post_type_enum.dart';
import '../../../gen/model/json/FromJsonGetCountriesModel.dart';
import '../../common/utils/dio_inperactor.dart';
import 'state.dart';

class EditProfileLogic extends GetxController implements RequestInterface {
  final EditProfileState state = EditProfileState();
  List<CountriesModel> countreisModel =[];
  List<String> countreisString =[];

  TextEditingController assetsEditingController = TextEditingController();
  TextEditingController assetsDescreptionEditingController = TextEditingController();
  TextEditingController isEditEditingController = TextEditingController();
  TextEditingController subscrptionController = TextEditingController();
  TextEditingController planController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imdbScooreController = TextEditingController();
  TextEditingController imdbYeaerController = TextEditingController();
  var isloading = false.obs;
  var isloading1 = true.obs;

  late ApiRequster apiRequster;
  DetailController detailController;
  EditProfileLogic(this.detailController,this.id);
  PostType type = Get.arguments[1];
  String id ;

  Future<void> getAllCountries() async {
    var dio = Dio();


    dio.interceptors.add(MediaVerseConvertInterceptor());

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}countries',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'multipart/form-data',
            'X-App': '_Android',
          },
        ),

      );

      if (response.statusCode! >= 200||response.statusCode! < 300) {


        (response.data['data'] as List<dynamic>).forEach((element) {
          countreisModel.add(CountriesModel.fromJson(element));
        });
        (countreisModel).forEach((element) {
          countreisString.add(element.title??"");
        });
        isloading1(false);
        update();
        print('PlusSectionLogic.getAllCountries = ${countreisModel.length}');
      } else {
        print('Failed to upload file: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }
  String getSubscrptioonPeriod(){

    switch (subscrptionController.text){
      case "1 Day":
        return "24";
      case "3 Days":
        return "72";
      case "1 Week":
        return "168";
      case "1 Month":
        return "720";
      default:
        return "24";

    }
  }
  String getSubscriptionPlan(int periodHours) {
    String subscriptionPlan = "1 Day"; // Default plan

    switch (periodHours) {
      case 24:
        subscriptionPlan = "1 Day";
        break;
      case 72:
        subscriptionPlan = "3 Days";
        break;
      case 168:
        subscriptionPlan = "1 Week";
        break;
      case 720:
        subscriptionPlan = "1 Month";
        break;
      default:
        subscriptionPlan = "Invalid Plan";
    }

    return subscriptionPlan;
  }
  startPageFunction(details)async{
    isloading1(true);

    update();
    countreisModel.clear();
    countreisString.clear();
    await getAllCountries();
    apiRequster = ApiRequster(this,develperModel: false);
    assetsEditingController.text = details['media']['name'];
    assetsDescreptionEditingController.text = details['media']['description']??"";
    subscrptionController.text =getSubscriptionPlan( int.tryParse(details['subscription_period'].toString())??24);
    priceController.text = (details['price']/100).toString();
    isEditEditingController.text = details['forkability_status'].toString().contains("1")?"Yes":"No";
    planController.text = _getDropDownByPlan(details['license_type'].toString());

    try {
      String name= (details['country']??"").toString().toUpperCase();
      languageController.text =countreisModel.firstWhere((element) => element.iso.toString().contains(name)).title??"";
    }  catch (e) {
      // TODO
      print('EditProfileLogic.startPageFunction catch ${e}');
    }
    planController.addListener(() {
      update();
    });
    if(type==PostType.video){
      genreController.text = details['genre']??"";
      try {
        imdbScooreController.text = details['imdb_score']??"";
      }  catch (e) {
        // TODO
      }
      imdbYeaerController.text = details['production_year'].toString();
    }

    update();
  }
  sendMainRequest() {
    isloading(true);
    var box = GetStorage();
    var body = {
      "name": assetsEditingController.text,

      "license_type": _getPlanByDropDown(),
      "subscription_period":getSubscrptioonPeriod(),
      "description": assetsDescreptionEditingController.text,
      "lat": 0,
      "lng": 0,
      "language": Constant.languageMap[languageController.text],
      "country":countreisModel.firstWhere((element) => element.title.toString().contains(languageController.text)).iso??"",
      "type": 1,
    //  "length":  detailController.detailss!['length'],
      "forkability_status": isEditEditingController.text.contains("Yes") ? "1" : "2",
      "commenting_status": 1,
      "tags": []
    };
    if (!_getPlanByDropDown().toString().contains("1")) {
      body['price'] = (double.tryParse((priceController.text))!*100).toInt().toString();
    }
    if(type == PostType.video){
      body['genre'] = genreController.text;
      body['imdb_score'] = imdbScooreController.text;
      body['production_year'] = imdbYeaerController.text;

    }
    print('PlusSectionLogic.sendMainRequest = ${body}"}');

     apiRequster.request(_getUrlByMediaEnum()+"/${id}", ApiRequster.MHETOD_PUT, 1,
         body: body, useToken: true, );
  }
  String _getUrlByMediaEnum() {
    switch (type) {
      case PostType.audio:
      // TODO: Handle this case.
        return "audios";
      case PostType.image:
      // TODO: Handle this case.
        return "images";

      case PostType.text:
      // TODO: Handle this case.
        return "texts";

      case PostType.video:
      // TODO: Handle this case.
        return "videos";
    }
  }
  _getPlanByDropDown() {
    switch (planController.text) {
      case "Free":
        return "1";
      case "Ownership":
        return "2";
      case "Subscription":
        return "3";
    }
  }
  _getDropDownByPlan(String string ) {
    switch (string) {
      case "1":
        return "Free";
      case "2":
        return "Ownership";
      case "3":
        return "Subscription";
    }
  }
  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError

    isloading(false);
    try {
      Constant.showMessege("Request Denied : ${bodyError}");
    }  catch (e) {
      // TODO
    }
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest
  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    Constant.showMessege("Request Succesfuly ");
    Get.back();
    isloading(false);

  }
}
