import 'dart:convert';

import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAssets.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetProfile.dart';
import 'package:meta/meta.dart';

import '../../../gen/model/json/FromJsonGetImages.dart';

class ProfileController extends GetxController implements RequestInterface{

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

  late FromJsonGetImages fromJsonGetImages;
  late ProfileModel model;
  late ApiRequster apiRequster;

  late AssetsModel assetsModel;
  var isloading =false.obs;


  var isloading1 =false.obs;
  var isloading2 =false.obs;
  var isloading3 =false.obs;
  var isloading4 =false.obs;
  var isloading5 =false.obs;
  var isloading6 =false.obs;



  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster =ApiRequster(this,develperModel: true);
    onGetProfileMethod();
  }


  onGetProfileMethod(){
    isloading(true);
    apiRequster.request("profile", ApiRequster.MHETOD_GET, 1,useToken: true);
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
        praseJsonFromGetProfile(source);
        break;
      case 2 :
        praseJsonFromGetAssets(source);
        break;
      case 3 :
        praseJsonFromGetAllMyAssets(source);
        break;
      case 4 :
        parseJsonFromGetAllImages(source);
        break;
    }
  }

  void praseJsonFromGetProfile(source) {

    model = ProfileModel.fromJson(jsonDecode(source));
    onGetProfileAssets();
    onGetAssetsPhoto();

  }
  onGetProfileAssets(){
    isloading(true);
    apiRequster.request("profile/statics", ApiRequster.MHETOD_GET, 2,useToken: true);
  }


  onGetAssetsAll(){
    isloading1(true);
    apiRequster.request("profile/assets", ApiRequster.MHETOD_GET, 3,useToken: true);
  }

  onGetAssetsPhoto(){
    isloading1(true);
    apiRequster.request("profile/images", ApiRequster.MHETOD_GET, 4,useToken: true);
  }

  void praseJsonFromGetAssets(source) {
    assetsModel = AssetsModel.fromJson(jsonDecode(source));
    isloading(false);

  }

  void praseJsonFromGetAllMyAssets(source) {}

  void parseJsonFromGetAllImages(source) {

    fromJsonGetImages = FromJsonGetImages.fromJson(jsonDecode(source));
    isloading1(false);
  }
}