import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetBestVideos.dart';

class SearchLogic extends GetxController {
  bool isAdvancedSearchVisible = false;
  // RxList<Videos> videosLst = <Videos>[].obs;
  // RxList<Audios> audiosLst = <Audios>[].obs;
  // RxList<Images> imagesLst = <Images>[].obs;
  // RxList<Texts> textsLst = <Texts>[].obs;

  FromJsonGetAllAsstes item = FromJsonGetAllAsstes();
  RxBool isTag = false.obs;
  RxBool isLoading = false.obs;

  showAdvanceTextField() {
    isAdvancedSearchVisible = !isAdvancedSearchVisible;
    update();
  }

  List<dynamic> bestVideos = [];
  List<dynamic> pictureLST = [];
  List<dynamic> audioLST = [];
  List<dynamic> txtLST = [];

  Future<void> searchMedia(String tagOrPlan, value) async {
    isLoading.value = true;

    var body ={
      "tag": isTag.value ? tagOrPlan : "",
      "plan": !isTag.value ? tagOrPlan : "",
      "q": value,
    };
    var response =
        await Dio().get("${Constant.HTTP_HOST}search", queryParameters: body);
    log('SearchLogic.searchMedia 1 - ${ "${Constant.HTTP_HOST}search"} - $body  = ${response.data}');

    item = FromJsonGetAllAsstes.fromJson(response.data);

    try {
      bestVideos = item.all!.where((element) => element['class'].toString().contains("4")).toList();
      txtLST = item.all!.where((element) => element['class'].toString().contains("1")).toList();
      pictureLST = item.all!.where((element) => element['class'].toString().contains("2")).toList();
      audioLST = item.all!.where((element) => element['class'].toString().contains("3")).toList();

    }  catch (e) {
      // TODO
    }
    print('SearchLogic.searchMedia = ${bestVideos}');

    isLoading.value = false;
  }
}
