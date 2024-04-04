import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:mediaverse/app/pages/profile/tab/ownser_tab_screen.dart';
import 'package:mediaverse/app/pages/profile/tab/subs_tab_screen.dart';
import 'package:mediaverse/app/pages/profile/widgets/card_profile_info.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/app_route.dart';
import '../../common/font_style.dart';
import '../channel/tab/channel_tab.dart';
import '../channel/widgets/custom_calendar_widget.dart';
import '../home/logic.dart';
import '../home/tabs/all/view.dart';
import '../home/tabs/image/view.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ProfileControllers logic = Get.find<HomeLogic>().profileController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return logic.isloading.value
          ? Scaffold(
              backgroundColor: AppColor.blueDarkColor,
              body: Container(
                child: Center(
                  child:
                      Lottie.asset("assets/json/Y8IBRQ38bK.json", height: 10.h),
                ),
              ),
            )
          : Scaffold(




              appBar: AppBar(
                backgroundColor: AppColor.blueDarkColor,

                title: CardProfileInfoWidget(logic),
                toolbarHeight: 230,

                flexibleSpace: Stack(
                  children: [
                    Container(
                      height: 9.h,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.white,
                        AppColor.primaryLightColor,
                        AppColor.primaryLightColor,
                      ])),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 6.5.h),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Row(
                            children: [
                              Container(
                                height: 85,
                                width: 85,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.blueDarkColor,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppColor.blueDarkColor,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${logic.model.firstName ?? ""} ${logic.model.lastName ?? ""}',
                                          style:
                                              FontStyleApp.titleSmall.copyWith(
                                            color: AppColor.whiteColor,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${logic.model.email ?? ""} ',
                                          style:
                                              FontStyleApp.bodyMedium.copyWith(
                                            color: AppColor.whiteColor
                                                .withOpacity(0.2),
                                            fontSize: 8.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(PageRoutes.SETTING);
                                      },
                                      child: Container(
                                        width: 45,
                                        height: 45,

                                        child: Transform.scale(
                                            scale: 0.5,
                                            child: SvgPicture.asset(
                                              AppIcon.settingIcon,
                                              height: 50,
                                            )),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.4))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColor.blueDarkColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(60.sp),
                          bottomLeft: Radius.circular(60.sp),
                        ),
                      ),
                      height: 60,
                      child: TabBar(
                        tabAlignment: TabAlignment.center,
                        physics: const BouncingScrollPhysics(),
                        isScrollable: true,
                        controller: _tabController,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        enableFeedback: false,
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColor.primaryLightColor,
                        unselectedLabelColor: Colors.grey,
                        labelColor: AppColor.whiteColor,
                        dividerColor: Colors.transparent,
                        tabs: [
                          _buildTab(context, 0, 'Subscribe'),
                          _buildTab(context, 1, 'Ownership'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          SubscrTabScreen(),
                          OwnerTabScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Widget _buildTab(BuildContext context, int tabIndex, String label) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(label)],
      ),
    );
  }
}
