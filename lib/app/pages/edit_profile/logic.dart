import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';

import '../../../gen/model/enums/post_type_enum.dart';
import 'state.dart';

class EditProfileLogic extends GetxController implements RequestInterface {
  final EditProfileState state = EditProfileState();


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

  late ApiRequster apiRequster;
  DetailController detailController;
  EditProfileLogic(this.detailController,this.id);
  PostType type = Get.arguments[1];
  String id ;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: true);
    assetsEditingController.text = detailController.detailss!['name'];
    assetsDescreptionEditingController.text = detailController.detailss!['description']??"";
    priceController.text = detailController.detailss!['price'].toString();
    isEditEditingController.text = detailController.detailss!['forkability_status'].toString().contains("1")?"Yes":"No";
    planController.text = _getDropDownByPlan(detailController.detailss!['plan'].toString());
      try {
        languageController.text = Constant.reversedLanguageMap[detailController.detailss!['language']??""]!;
      }  catch (e) {
        // TODO
      }
    planController.addListener(() {
      update();
    });
    if(type==PostType.video){
      genreController.text = detailController.detailss!['genre']??"";
      imdbScooreController.text = detailController.detailss!['imdb_score']??"";
      imdbYeaerController.text = detailController.detailss!['production_year'].toString();
    }
  }
  sendMainRequest() {
    isloading(true);
    var box = GetStorage();
    var body = {
      "name": assetsEditingController.text,

      "plan": _getPlanByDropDown(),
      "subscription_period": subscrptionController.text,
      "description": assetsDescreptionEditingController.text,
      "lat": 0,
      "lng": 0,
      "language": Constant.languageMap[languageController.text],
      "country": Constant.languageMap[languageController.text],
      "type": 1,
      "length":  detailController.detailss!['length'],
      "forkability_status":
      isEditEditingController.text.contains("Yes") ? "1" : "2",
      "commenting_status": 1,
      "tags": []
    };
    if (!_getPlanByDropDown().toString().contains("1")) {
      body['price'] = priceController.text;
    }
    if(type == PostType.video){
      body['genre'] = genreController.text;
      body['imdb_score'] = imdbScooreController.text;
      body['production_year'] = imdbYeaerController.text;

    }
    print('PlusSectionLogic.sendMainRequest = ${body}');

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
