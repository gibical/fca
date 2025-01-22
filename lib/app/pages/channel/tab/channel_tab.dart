import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/channel/tab/detail_channel_screen.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/view.dart';
import 'package:mediaverse/app/pages/share_account/widgets/program_show_bottom_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/channel/widgets/add_channel_card_widget.dart';
import 'package:mediaverse/app/pages/channel/widgets/card_channel_widget.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannels.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/walletV2/FromJsonGetPrograms.dart';
import '../../../common/app_color.dart';
import '../../share_account/logic.dart';

class ProgramsTab extends StatefulWidget {
  @override
  State<ProgramsTab> createState() => _ProgramsTabState();
}

class _ProgramsTabState extends State<ProgramsTab> {
  final _logic = Get.find<ShareAccountLogic>();
  bool isBack = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_logic.isloading.value) {
        return _buildLoadingScreen();
      } else {
        _initializeChannelList();
        return _buildChannelList();
      }
    });
  } //

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,
      body: Center(
        child: Lottie.asset(
          "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
          height: 10.h,
        ),
      ),
    );
  }

  void _initializeChannelList() {
    try {
      if (Get.arguments[0] == true) {
        isBack = true; //
      }
    } catch (e) {
      log('Error initializing channel list: $e');
    }
  }

  Widget _buildChannelList() {
    print('_ProgramsTabState._buildChannelList = ${_logic.channelModels}');
    return GetBuilder<ShareAccountLogic>(

        init: _logic,
        builder: (logic) {
      return Column(
        children: [
          Container(
            child: AddChannelCardWidget(), //
          ),
          Column(
            children: _logic.channelModels
                .asMap()
                .entries
                .map((toElement) => _buildChannelCard(toElement.value))
                .toList(),
          )
        ],
      );
    });
  }

  Widget _buildChannelCard(ChannelsModel model) {
    return CardChannelWidget(
      title: (model.name ?? "").toString(),
      date: (model.createdAt ?? ""),
      onTap: () => _handleChannelTap(model),
      model: model,
    );
  }

  void _handleChannelTap(ChannelsModel model) {
    try {
      if (isBack) {
        Get.back(result: model);
      } else {
       Get.bottomSheet(MyChannelManagementBottomSheet(model),isScrollControlled: true);
        // Get.bottomSheet(ProgramShowBottomSheet(model));
      }
    } catch (e) {
      log('Error handling channel tap: $e');
      Get.bottomSheet(ProgramShowBottomSheet(model));
    }
  }
}