import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/home/tabs/all/view.dart';
import 'package:mediaverse/app/pages/home/tabs/image/view.dart';
import 'package:mediaverse/app/pages/home/tabs/text/view.dart';
import 'package:mediaverse/app/pages/home/tabs/video/view.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_grid_view_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/item_video_tab_screen.dart';
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


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              AllTabScreen(),
              ImageTabScreen(),
              VideoTabScreen(),
              SoundTabScreen(introBoxWidget: SvgPicture.asset(AppIcon.musicIcon),),
              TextTabScreen(introBoxWidget: Text('BE' , style: FontStyleApp.headMedium,))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
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
        ],
      ),
    );

  }

  Widget _buildTab(
      BuildContext context, String icon, int tabIndex , bool isLabel) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       isLabel ? Text('All'):   SvgPicture.asset(
              height: 2.h,
              icon,
              color: tabIndex == _selectedTabIndex
                  ? AppColor.primaryLightColor
                  : Color(0xff666680),),

        ],
      ),
    );
  }
}
