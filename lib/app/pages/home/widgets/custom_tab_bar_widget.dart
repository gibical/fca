import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/home/tabs/image/view.dart';
import 'package:mediaverse/app/pages/home/tabs/text/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/view.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_grid_view_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../tabs/sound/view.dart';

class CustomTabBarWidget extends StatefulWidget {
  const CustomTabBarWidget({super.key});

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
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
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              ImageTabScreen(),
              VideoTabScreen(),
              SoundTabScreen(
                  introBoxWidget: SvgPicture.asset(AppIcon.musicIcon)),
              TextTabScreen(
                introBoxWidget: Text(
                  'Be',
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25  , vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.sp),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10 , sigmaX: 10),

                child: Container(
                  height: 60,
                  color: Colors.white.withOpacity(0.7),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TabBar(

                      physics: const BouncingScrollPhysics(),
                      controller: _tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      enableFeedback: false,
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColor.primaryLightColor,
                      unselectedLabelColor: Colors.grey,
                      labelColor: AppColor.primaryLightColor,
                      dividerColor: Colors.transparent,
                      tabs: [
                        _buildTab(context, AppIcon.imageIcon, 0),
                        _buildTab(context, AppIcon.videoIcon, 1),
                        _buildTab(context, AppIcon.soundIcon, 2),
                        _buildTab(context, AppIcon.textIcon, 3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildTab(
      BuildContext context, String icon, int tabIndex) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              height: 2.h,
              icon,
              color: tabIndex == _selectedTabIndex
                  ? AppColor.primaryLightColor
                  : AppColor.primaryDarkColor.withOpacity(0.2)),

        ],
      ),
    );
  }
}
