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

  bool isAdvancedSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1.h,
          color: Colors.white,
        ),
        if (isAdvancedSearchVisible)
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 13,
                      ),
                      fillColor: AppColor.grayLightColor,
                      filled: true,
                      hintText: 'Search in all media',
                      hintStyle: FontStyleApp.bodyMedium.copyWith(
                          color: AppColor.primaryDarkColor.withOpacity(0.2)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.sp),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 13,
                      ),
                      fillColor: AppColor.grayLightColor,
                      filled: true,
                      hintText: 'Search in all media',
                      hintStyle: FontStyleApp.bodyMedium.copyWith(
                          color: AppColor.primaryDarkColor.withOpacity(0.2)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.sp),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ),
        Container(
          height: 1,
          color: Colors.black.withOpacity(0.1),
        ),
        Container(
          color: Colors.white,
          height: 60,
          child: TabBar(
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
            labelColor: AppColor.primaryLightColor,
            dividerColor: Colors.transparent,
            tabs: [
              _buildTab(context, 'Image', AppIcon.imageIcon, 0),
              _buildTab(context, 'Video', AppIcon.videoIcon, 1),
              _buildTab(context, 'Sound', AppIcon.soundIcon, 2),
              _buildTab(context, 'Text', AppIcon.textIcon, 3),
            ],
          ),
        ),
        Expanded(
          child: Padding(
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
        )
      ],
    );
  }

  Widget _buildTab(
      BuildContext context, String label, String icon, int tabIndex) {
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
          SizedBox(
            width: 1.8.w,
          ),
          if (tabIndex == _selectedTabIndex)
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5.sp,
                color: AppColor.primaryLightColor,
              ),
            ),
        ],
      ),
    );
  }
}
