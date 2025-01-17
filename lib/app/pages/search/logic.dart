import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetBestVideos.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';

import '../../../gen/model/json/FromJsonGetAllChannels.dart';
import '../../common/utils/dio_inperactor.dart';

class SearchLogic extends GetxController {
  bool isAdvancedSearchVisible = false;
  // RxList<Videos> videosLst = <Videos>[].obs;
  // RxList<Audios> audiosLst = <Audios>[].obs;
  // RxList<Images> imagesLst = <Images>[].obs;`
  // RxList<Texts> textsLst = <Texts>[].obs;

  List<String> plans = [
    "search_6".tr,
    "search_7".tr,
    "search_8".tr,
  ];
  List<String> types = [
    "search_11".tr,
    "search_12".tr,
    "search_13".tr,
    "search_14".tr,
    "search_15".tr,

  ];

  int selecetedPlan =0;
  int selecetedType =0;

  List<ContentModel> contentModels=  [ ];
  List<ChannelsModel> channelsModel=  [ ];
  RxBool isTag = false.obs;
  RxBool isLoadingAssets = false.obs;
  RxBool isLoadingChannels = false.obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController tagOrPlanController = TextEditingController();

  showAdvanceTextField() {
    isAdvancedSearchVisible = !isAdvancedSearchVisible;
    update();
  }


  Future<void> searchAssets() async {
    isLoadingAssets.value = true;

    var body ={
      "q": searchController.text,
    };
    if(selecetedType!=0){
      body['media_type']  = types.elementAt(selecetedType).toLowerCase();
    }
    if(selecetedPlan!=0){
      if (selecetedPlan==1) {
        body['license_type']  = "free";
      }
      if (selecetedPlan==2) {
        body['license_type']  = "ownership";
      }
    }
    print('SearchLogic.searchAssets = ${body}');
    var response =
        await Dio().get("${Constant.HTTP_HOST}assets", queryParameters: body, options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),);
    if (response.statusCode==200) {
      FromJsonGetContentFromExplore fromExplore = FromJsonGetContentFromExplore.fromJson(response.data);
      contentModels.clear();
      contentModels = fromExplore.data??[];
    }

    update();
    try {

    }  catch (e) {
      // TODO
    }

    isLoadingAssets.value = false;
  }

  void searchChannels() async{
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    isLoadingChannels.value = true;
    var body ={
      "q": searchController.text,
    };

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}'"channels",queryParameters: body,

        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );



      if (response.statusCode! >= 200 && response.statusCode! < 300) {

        channelsModel = FromJsonGetAllChannels.fromJson(response.data).data??[];
        print('Request succeeded: ${response.statusCode} = ${channelsModel.length} = ${response.requestOptions.queryParameters}');
        isLoadingChannels(false);
        update();
      } else {
        print('Request failed: ${response.statusMessage}');
        return null;
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return null;
    }
  }
}
