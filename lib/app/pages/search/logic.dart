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

    var response =
        await Dio().get("${Constant.HTTP_HOST}search", queryParameters: {
      "tag": isTag.value ? tagOrPlan : "",
      "plan": !isTag.value ? tagOrPlan : "",
      "q": value,
    });
    log('SearchLogic.searchMedia = ${response.data}');

    item = FromJsonGetAllAsstes.fromJson(response.data);

    bestVideos = response.data["videos"]
        .map((e) => e)
        .toList();
    txtLST = response.data["texts"].map((e) => e).toList(); 
    pictureLST = response.data["images"].map((e) => e).toList();
    audioLST = response.data["audios"].map((e) => e).toList();

    isLoading.value = false;
  }
}
