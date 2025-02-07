import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/home/tabs/all/view.dart';
import 'package:mediaverse/app/pages/home/tabs/image/view.dart';
import 'package:mediaverse/app/pages/home/tabs/sound/view.dart';
import 'package:mediaverse/app/pages/home/tabs/text/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/view.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';
import 'package:mediaverse/app/pages/profile/widgets/GridMainWidget.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:mediaverse/app/pages/search/widgets/asset_mini_tab_widget.dart';
import 'package:mediaverse/app/pages/search/widgets/serach_filter_bottomsheet_widget.dart';

import 'package:mediaverse/app/widgets/custom_app_bar_widget.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/widgets/appbar_btn.dart';
import '../home/widgets/mini_channel_widget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  bool isAdvancedSearchVisible = false;
  late TabController _tabController;
  int _selectedTabIndex = 0;

  var isFocusTextFiled = false.obs;

  FocusNode focus = FocusNode();
  final SearchLogic _logic = Get.put(SearchLogic());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
      if (_selectedTabIndex == 0) {
        _logic.searchAssets();
      }
      if (_selectedTabIndex == 1) {
        _logic.searchChannels();
      }
    });
    focus.addListener(() {
      isFocusTextFiled.value = focus.hasFocus;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppbarBTNWidget(
                    iconName: 'back1',
                    onTap: () {
                      Get.back();
                    }),
                Text(
                  'search_1'.tr,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                AppbarBTNWidget(iconName: 'filter', onTap: () {
                  if (_selectedTabIndex == 0) {
                    Get.bottomSheet(SerachFilterBottomSheetWidget());
                  } else {
                    Constant.showMessege("Filter in This Tab Not Supported");
                  }
                }),

              ],
            ),
          ),
          Obx(() {
            return Container(
                width: 100.w,
                height: 6.h,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: "0F0F26".toColor(),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isFocusTextFiled.value ? AppColor
                            .primaryLightColor : Colors.transparent
                    )
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16,),
                    Expanded(
                      child: Center(
                        child: TextField(
                          focusNode: focus,
                          onChanged: (s) {
                            if (_selectedTabIndex == 0) {
                              _logic.searchAssets();
                            }
                            if (_selectedTabIndex == 1) {
                              _logic.searchChannels();
                            }
                          },
                          controller: _logic.searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Here ... ",

                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {
                      _logic.searchController.clear();
                      _logic.contentModels.clear();
                      _logic.channelsModel.clear();
                      _logic.update();
                    },
                        icon: Icon(Icons.close, color: "#9C9CB8".toColor(),
                          size: 14.sp,)),
                  ],
                )
            );
          }),
          SizedBox(height: 2.h,),
          DefaultTabController(
              length: 2,
              child: TabBar(
                controller:
                _tabController,
                tabs: [
                  Tab(text: "search_2".tr,),
                  Tab(text: "search_3".tr,),

                ],
              )
          ),
          Expanded(child: GetBuilder<SearchLogic>(
              init: _logic,
              builder: (logic) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _assetTabWidget(),
                    _channelsTabWidget()
                  ],);
              }))
        ],
      )),
    );
  }


  Widget _assetTabWidget() {
    return Container(

      child: ListView(
        children: _logic.contentModels
            .asMap()
            .entries
            .map((toElement) {
          return AssetMiniTabWidget(model: toElement.value);
        }).toList(),
      ),
    );
  }

  Widget _channelsTabWidget() {
    return Container(

      child: ListView(
        children: _logic.channelsModel
            .asMap()
            .entries
            .map((toElement) {
          return Container(
              height: 9.h,
              child: MiniChannelWidget(
                  model: _logic.channelsModel.elementAt(toElement.key)));
        }).toList(),
      ),
    );
  }


}
