import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import '../media_suit/logic.dart';

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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
   // FirebaseAnalytics.instance.logEvent(name: "Entered The Profile ");

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
                      Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json", height: 10.h),
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
                                child: Stack(
                                  children: [
                                    SizedBox.expand(
                                      child: CircleAvatar(
                                        backgroundColor: AppColor.blueDarkColor,
                                        backgroundImage:
                                           NetworkImage(logic.model.imageUrl??""),
                                      ),
                                      
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 40,
                                        width: 85,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(200),
                                            bottomRight: Radius.circular(200)
                                          )
                                        ),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(200),
                                                  bottomRight: Radius.circular(200)
                                              )
                                          ),
                                          onPressed: (){
                                            logic.checkAndRequestPermission();
                                          },
                                          child: Center(
                                            child: Transform.scale(
                                              scale: .5,
                                              child: Container(

                                                  child: Image.asset("assets/${F.assetTitle}/images/upload.png")),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width:
                              3.w),
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
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(

                    children: [
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColor.blueDarkColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100.sp),
                            bottomLeft: Radius.circular(100.sp),
                          ),
                        ),
                        height: 50,

                      ),

                      Expanded(
                        child:  OwnerTabScreen(),
                      ),
                    ],
                  ),
                  Get.arguments == 'edit_screen' ?  Obx((){
                    if(     Get.arguments == 'edit_screen' &&   Get.find<MediaSuitController>().tempSelectedItems.value.length != 0){
                      return GestureDetector(
                        onTap: (){

                          Get.find<MediaSuitController>().confirmSelection();


                          Get.back();
                        },
                        child: Container(
                          color: AppColor.blueDarkColor,

                          height: 70,

                          child: Center(
                            child: Text('Back to editor - Item selected: ${Get.find<MediaSuitController>().tempSelectedItems.value.length}' , style: TextStyle(
                              color: AppColor.primaryLightColor,
                              fontSize: 15
                            ),),
                          ),
                        ),
                      );
                    }else{
                      return SizedBox();
                    }


                  }):SizedBox(),

                ],
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
