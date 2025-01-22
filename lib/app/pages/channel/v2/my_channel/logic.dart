import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/utils/dio_inperactor.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/tab/channel_live_tab.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/tab/channel_programs_tab.dart';
import 'package:meta/meta.dart';

import '../../../../../gen/model/json/FromJsonGetChannelsLive.dart';
import '../../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import '../../../../common/app_config.dart';
import 'models/channel_tab_model.dart';

class MyChannelController extends GetxController {
  ChannelsModel baseModel;
  List<ContentModel> videoContentModels = [];

  int selectedTabIndex = 0;
  List<LiveModel> livemodels = [LiveModel()];

  MyChannelController(this.baseModel);

  var isLoadingAssets = false.obs;
  PageController pageController = PageController();
  List<ChannelTabModel> tabListModel = [
    ChannelTabModel("my_channel_1".tr, ChannelLiveTab()),
    ChannelTabModel("my_channel_2".tr, ChannelProgramsTab()),
    ChannelTabModel("my_channel_3".tr, Container()),
    ChannelTabModel("my_channel_4".tr, Container()),
  ];

  void getVideoAsset() async {
    isLoadingAssets.value = true;

    var dio = Dio();
    dio.interceptors.add(MediaVerseConvertInterceptor());
    var response = await Dio().get(
      "${Constant.HTTP_HOST}assets",
      queryParameters: {"media_type": "video"},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read("token")}',
          'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      FromJsonGetContentFromExplore fromExplore =
          FromJsonGetContentFromExplore.fromJson(response.data);
      videoContentModels.clear();
      videoContentModels = fromExplore.data ?? [];
    }


    update();
    try {} catch (e) {
      // TODO
    }

    isLoadingAssets.value = false;
  }
}
