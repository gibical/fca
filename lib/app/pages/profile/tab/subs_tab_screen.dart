import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'ownser_tab_screen.dart' as own;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../widgets/GridMainWidget.dart';
import 'ownser_tab_screen.dart';


class SubscrTabScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBarWidget2(),
    );
  }
}

class CustomTabBarWidget2 extends StatefulWidget {


  @override
  State<CustomTabBarWidget2> createState() => _CustomTabBarWidget2State();
}

class _CustomTabBarWidget2State extends State<CustomTabBarWidget2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
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


  ProfileControllers profileController = Get.find<HomeLogic>().profileController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return GetBuilder<ProfileControllers>(

        init: profileController,

        builder: (logic) {
          return Stack(
            children: [

              TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [

                 CustomTabScreen(logic.ownerImages,"profile/subscriptions"),
                 CustomTabScreen(logic.ownerImages,"profile/subscriptions/images"),
                 CustomTabScreen(logic.ownerImages,"profile/subscriptions/videos"),
                 CustomTabScreen(logic.ownerImages,"profile/subscriptions/audios"),
                 CustomTabScreen(logic.ownerImages,"profile/subscriptions/texts"),

                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11.sp),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),

                      child: Container(
                        height: 60,
                        color: theme.secondary,

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TabBar(

                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            overlayColor: MaterialStateProperty.all(
                                Colors.transparent),
                            enableFeedback: false,
                            indicatorWeight: 2,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: AppColor.primaryLightColor,
                            unselectedLabelColor: Color(0xff666680),
                            labelColor: AppColor.primaryLightColor,
                            dividerColor: Colors.transparent,
                            tabs: [
                              _buildTab(context, AppIcon.imageIcon, 0, true),
                              _buildTab(context, AppIcon.imageIcon, 1, false),
                              _buildTab(context, AppIcon.videoIcon, 2, false),
                              _buildTab(context, AppIcon.soundIcon, 3, false),
                              _buildTab(context, AppIcon.textIcon, 4, false),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Obx(() {
              //   return Visibility(
              //     //visible: false,
              //     visible: widget.homeLogic.isloading.value,
              //     child: Container(
              //       width: 100.w,
              //       height: 100.h,
              //       color: Colors.black.withOpacity(0.5),
              //       child: Center(
              //         child: Lottie.asset(
              //             "assets/json/Y8IBRQ38bK.json", height: 18.h),
              //       ),
              //     ),
              //   );
              // })

            ],
          );
        });
  }

  Widget _buildTab(BuildContext context, String icon, int tabIndex,
      bool isLabel) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLabel ? Text('All') : SvgPicture.asset(
            height: 2.h,
            icon,
            color: tabIndex == _selectedTabIndex
                ? AppColor.primaryLightColor
                : Color(0xff666680),),

        ],
      ),
    );
  }

  RxList<T> convertToRxList<T>(List<T> normalList) {
    return RxList<T>(normalList);
  }
}

class AllTabScreen extends StatelessWidget {


  FromJsonGetAllAsstes model;

  AllTabScreen(this.model);

  @override
  Widget build(BuildContext context) {
    List combinedList = randomisedList([
      ...(model.images ?? []),
      ...(model.audios ?? []),
      ...(model.videos ?? []),
      ...(model.texts ?? []),
    ]);
    print('AllTabScreen.build = ${model.all!.length}');
    return Container(

        padding: EdgeInsets.only(top: 13.h),
        height: 50.h,
        child: GridView(


          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: (model.all??[])
              .asMap()
              .entries
              .map((e) {
            return GridPostView2((model.all??[]).elementAt(e.key));
          }).toList(),

        ));
  }

  List<T> randomisedList<T>(List<T> list) {
    for (int i = list.length - 1; i > 0; i--) {
      int randomIndex = (i + new Random().nextInt(list.length - i)) as int;
      T temp = list[i];
      list[i] = list[randomIndex];
      list[randomIndex] = temp;
    }
    return list;
  }

}

