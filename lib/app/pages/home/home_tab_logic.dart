import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/pages/home/widgets/sort_select_bottom_sheet.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:meta/meta.dart';

import '../../../gen/model/json/FromJsonGetAllChannels.dart';
import '../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import '../../common/app_config.dart';
import '../../common/utils/dio_inperactor.dart';

class HomeTabController extends GetxController {
  int sortType = 1;

  List<ContentModel> models = [];
  List<ChannelsModel> channelsModel = [];
  var isloadingMini =true.obs;
  var isloadingPage =true.obs;

  PostType postType;

  bool isChannel;
  HomeTabController(this.postType,{this.isChannel=false});

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    
   if(!isChannel) getInitRequest(true);
   if(isChannel) getChnannelInitRequest(true);
  }
  
  void openSort()async {
    int? s =  await Get.bottomSheet(SortSelectBottomSheet(sortType));
    if(s!=null){
      sortType = s;
      getChnannelInitRequest(false);
      update();
    }
  }

  void getInitRequest(bool isFirstTime)async {
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    if(isFirstTime)isloadingMini(true);
    isloadingPage(true);
    update();

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}'"assets",
        queryParameters: {
          "media_type":_getMediaTypeBYPostType(),
          "sort":_getsortBySortType(),
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json',
          },
        ),
      );



      if (response.statusCode! >= 200 && response.statusCode! < 300) {

        models = FromJsonGetContentFromExplore.fromJson(response.data).data??[];
        if(kDebugMode)print('Request succeeded: ${response.statusCode} = ${models.length} = ${response.requestOptions.queryParameters}');
        isloadingPage(false);
        isloadingMini(false);
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

  _getMediaTypeBYPostType() {
    switch(postType){

      case PostType.image:
        return "image";
      case PostType.video:
        return "video";
      case PostType.audio:
        return "audio";
      case PostType.text:
        return "text";
      case PostType.channel:
        return "channel";
    }
  }

  _getsortBySortType() {
    switch(sortType){
      case 0:
        return "created_at";
      case 1:
        return "views_count";
      case 2:
        return "sales_count";
    }
  }

  void getChnannelInitRequest(bool bool) async{
    var dio = Dio();

    dio.interceptors.add(MediaVerseConvertInterceptor());

    if(bool)isloadingMini(true);
    isloadingPage(true);

    try {
      var response = await dio.get(
        '${Constant.HTTP_HOST}'"channels",

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
        if(kDebugMode)print('Request succeeded: ${response.statusCode} = ${models.length} = ${response.requestOptions.queryParameters}');
        isloadingPage(false);
        isloadingMini(false);
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
