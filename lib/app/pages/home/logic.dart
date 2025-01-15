

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/RequestInterface.dart';
import 'package:mediaverse/app/common/app_api.dart';
import 'package:mediaverse/app/common/utils/firebase_controller.dart';
import 'package:mediaverse/app/pages/home/home_tab_logic.dart';
import 'package:mediaverse/app/pages/home/tabs/all/view.dart';
import 'package:mediaverse/app/pages/home/tabs/image/view.dart';
import 'package:mediaverse/app/pages/home/tabs/sound/view.dart';
import 'package:mediaverse/app/pages/home/tabs/text/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/channel/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/view.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllChannels.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetBestVideos.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannels.dart';

import '../../../gen/model/json/FromJsonGetBestModelVideows.dart';
import '../../../gen/model/json/FromJsonGetChannelsShow.dart';
import 'models/tab_model.dart';

class HomeLogic extends GetxController implements  RequestInterface{


  HomeTabController imageController = Get.put(HomeTabController(PostType.image),tag: "image");
  HomeTabController textController = Get.put(HomeTabController(PostType.text),tag: "text");
  HomeTabController audioController = Get.put(HomeTabController(PostType.audio),tag: "audio");
  HomeTabController videoController = Get.put(HomeTabController(PostType.video),tag: "video");
  HomeTabController channelController = Get.put(HomeTabController(PostType.channel,isChannel: true),tag: "channel");

  var selectedTab = 0.obs;

  List<HomeTabModel>   homeTabsModel=[];


  PageController pageController = PageController();


  List<ChannelsModel> channels = [
    ChannelsModel(),
    ChannelsModel(),
  ];
  List<dynamic> bestVideos = [
    "m","asdasd",
    "m","asdasd",
    "m","asdasd",
    "m","asdasd",
    "m","asdasd",
  ];
  List<dynamic> mostImages = [];
  List<dynamic> mostText = [];
  List<dynamic> mostSongs = [];




  ProfileControllers profileController = Get.put(ProfileControllers());

  var imagesRecently = [].obs;
  var songsRecently = [].obs;
  var textRecently = [].obs;



  late ApiRequster apiRequster;

  var isloading = false.obs;


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster  = ApiRequster(this,develperModel: false);

    try {
      print('HomeLogic.onReady 1');
       FirebaseAnalytics.instance.logEvent(
        name: "share_image",
        parameters: {
          "image_name": "name",
          "full_text": "text",
        },
      );
      FirebaseAnalytics.instance.logEvent(name: "Entered The Setting ");
    }  catch (e) {
      // TODO
      print('HomeLogic.onReady catch');
    }finally{
      print('HomeLogic.onReady finally');

    }

    update();


    getMainReueqst();
  }

  getMainReueqst(){
    isloading(true);
    apiRequster.request("channels", ApiRequster.MHETOD_GET, 1);
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
      case 1:
        praseJsonFromChannels (source);
       case 2:
        praseJsonFromBestVideos (source);
        case 3:
        parseJsonFromMostViewdVideos (source);
         case 4:
        parseJsonFromBestText (source);
          case 5:
        parseJsonFromBestSongs (source);
           case 6:
        parseJsonFromNewsImage (source);
            case 7:
        parseJsonFromNewsSound (source);
            case 8:
        parseJsonFromNewsText (source);
    }
  }

  void praseJsonFromChannels(source) {
    try {
        channels = FromJsonGetAllChannels.fromJson(jsonDecode(source)).data ?? [];
      // if (Platform.isIOS) {
      //   channels = (FromJsonGetAllChannels.fromJson(jsonDecode(source)).data ?? []).where((te)=>te.link.toString().contains("https://s1.mediaverse.app")).toList();
      // }else{
      //
      // }
      print('HomeLogic.praseJsonFromChannels 1 =${channels}');
    }  catch (e) {
      // TODO
      print('HomeLogic.praseJsonFromChannels 2');

    }

    _getBestVideos();
  }

  void _getBestVideos() {
    apiRequster.request("assets/newest"+'?media_type=video', ApiRequster.MHETOD_GET, 2);

  }

  void praseJsonFromBestVideos(source) {
    bestVideos = FromJsonGetBestVideos.fromJson(jsonDecode(source)).data??[];



    _getMostVideos();
  }

  void _getMostVideos() {
    apiRequster.request("assets/most-viewed"+'?media_type=image', ApiRequster.MHETOD_GET, 3);

  }
  void _getMostText() {
    apiRequster.request("assets/most-viewed"+'?media_type=text', ApiRequster.MHETOD_GET, 4);

  }
  void _getMostSongs() {
    apiRequster.request("assets/newest"+'?media_type=audio', ApiRequster.MHETOD_GET, 5);

  }

  void parseJsonFromMostViewdVideos(source) {
    mostImages = FromJsonGetBestVideos.fromJson(jsonDecode(source)).data??[];
    _getMostText();

  }

  void parseJsonFromBestText(source) {
  //  log('HomeLogic.parseJsonFromBestText = ${source}');
    mostText = FromJsonGetBestText.fromJson(jsonDecode(source)).data??[];
    _getMostSongs();
  }

  void parseJsonFromBestSongs(source) {
    mostSongs = FromJsonGetBestText.fromJson(jsonDecode(source)).data??[];
    isloading(false);
    update();
  }

  void sendImageRecentlyReuqest() {
    apiRequster.request("assets/daily-recommended"+'?media_type=image', ApiRequster.MHETOD_GET, 6);

  }

  void parseJsonFromNewsImage(source) {
    imagesRecently.value = FromJsonGetBestVideos.fromJson(jsonDecode(source)).data??[];
    log('HomeLogic.parseJsonFromNewsImage = ${source}');
  }

  void sendSoundRecentlyReuqest() {

    apiRequster.request("assets/daily-recommended" +'?media_type=audio', ApiRequster.MHETOD_GET, 7);

  }

  void parseJsonFromNewsSound(source) {
    songsRecently.value = FromJsonGetBestVideos.fromJson(jsonDecode(source)).data??[];

  }
  void sendTextRecentlyReuqest() {

    apiRequster.request("assets/daily-recommended"+'?media_type=text', ApiRequster.MHETOD_GET, 8);

  }

  void parseJsonFromNewsText(source) {
    textRecently.value = FromJsonGetBestVideos.fromJson(jsonDecode(source)).data??[];

    print('HomeLogic.parseJsonFromNewsText = ${textRecently.length}');
    update();
  }

  void onpageChanged(int value) {
    selectedTab.value=value;
    update();
  }
}