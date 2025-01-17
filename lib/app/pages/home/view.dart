import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/tabs/image/view.dart';
import 'package:mediaverse/app/pages/home/tabs/sound/view.dart';
import 'package:mediaverse/app/pages/home/tabs/text/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/channel/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/view.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';

import 'package:mediaverse/app/pages/wrapper/logic.dart';
import 'package:mediaverse/app/widgets/custom_app_bar_widget.dart';
import 'package:sizer/sizer.dart';

import 'models/tab_model.dart';
import 'tabs/all/view.dart';

class HomeScreen extends GetView<WrapperController> {

  HomeLogic homeLogic = Get
      .find<WrapperController>()
      .homeLogic;

  @override
  Widget build(BuildContext context) {
    homeLogic.homeTabsModel  = [
      HomeTabModel("home_2".tr, AllTabScreen()),
      HomeTabModel("home_3".tr, ChannelTabScreen()),
      HomeTabModel("home_4".tr, VideoTabScreen()),
      HomeTabModel("home_5".tr, ImageTabScreen()),
      HomeTabModel("home_6".tr, SoundTabScreen()),
      HomeTabModel("home_7".tr, TextTabScreen()),
    ];
    return Scaffold(
      backgroundColor: "000018".toColor(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Column(
            children: [

              /// Search Widget
              Container(
                width: 100.w,
                height: 6.h,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: "0F0F26".toColor(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: MaterialButton(


                  padding: EdgeInsets.symmetric(horizontal: 16),
                  onPressed: (){
                    Get.toNamed(PageRoutes.SEARCH);
                  },
                  child: Row(
                    children: [
                      Text(
                        "home_1".tr, style: TextStyle(color: "9C9CB8".toColor()),)
                    ],
                  ),
                ),
              ),

              /// Tabs
              GetBuilder<HomeLogic>(
                  init: homeLogic,
                  builder: (logic) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: 2.h
                      ),
                      width: 100.w,
                      child: Row(
                        children: homeLogic.homeTabsModel
                            .asMap()
                            .entries
                            .map((toElement) {
                          bool _isActive = homeLogic.selectedTab.value ==
                              toElement.key;
                          return Expanded(
                            child: Container(

                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                onPressed: () {
                                  homeLogic.selectedTab.value = toElement.key;
                                  homeLogic.pageController.animateToPage(
                                      homeLogic.selectedTab.value,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.bounceIn); //
                                  homeLogic.update();
                                },
                                padding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    Center(child: Text(
                                      toElement.value.title, style: TextStyle(
                                        color: _isActive
                                            ? Colors.white
                                            : "9C9CB8"
                                            .toColor()
                                    ),)),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: 100.w,
                                      height: 3,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 3.w),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              500),
                                          color: _isActive
                                              ? "2563EB".toColor()
                                              : Colors.transparent
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),

              /// PageView
              Expanded(
                child: GetBuilder<HomeLogic>(
                    init: homeLogic,
                    builder: (logic) {
                  return PageView.builder(
                    controller: homeLogic.pageController,
                    itemCount: homeLogic.homeTabsModel.length,
                    itemBuilder: (w, i) {
                      return homeLogic.homeTabsModel
                          .elementAt(i)
                          .widget;
                    },
                    onPageChanged: homeLogic.onpageChanged,
                  );
                }),
              )
            ],
          ),
        ),
      ),

    );

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: CustomAppBarWidget(context),
      body: CustomTabBarWidget(homeLogic),

    );
  }
}


