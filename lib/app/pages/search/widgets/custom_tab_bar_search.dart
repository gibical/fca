import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/search/widgets/advance_search_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';



class CustomTabBarSearchWidget extends StatefulWidget {
  const CustomTabBarSearchWidget({super.key});

  @override
  State<CustomTabBarSearchWidget> createState() => _CustomTabBarSearchWidgetState();
}

class _CustomTabBarSearchWidgetState extends State<CustomTabBarSearchWidget>
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
    return Column(
      children: [
        AdvanceSearchWidget(),

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
              _buildTab(context, 'search_6'.tr, AppIcon.imageIcon, 0),
              _buildTab(context, 'search_7'.tr, AppIcon.videoIcon, 1),
              _buildTab(context, 'search_8'.tr, AppIcon.soundIcon, 2),
              _buildTab(context, 'search_9'.tr, AppIcon.textIcon, 3),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children:  [


              
              Scaffold(
                body: Center(child: Text('search_10'.tr , style: TextStyle(
                  color: AppColor.primaryDarkColor,
                  fontSize: 20
                ),)),
              ),
              Scaffold(
                body: Center(child: Text('search_10'.tr , style: TextStyle(
                    color: AppColor.primaryDarkColor,
                    fontSize: 20
                ),)),
              ),
              Scaffold(
                body: Center(child: Text('search_10'.tr , style: TextStyle(
                    color: AppColor.primaryDarkColor,
                    fontSize: 20
                ),)),
              ),
              Scaffold(
                body: Center(child: Text('search_10'.tr , style: TextStyle(
                    color: AppColor.primaryDarkColor,
                    fontSize: 20
                ),)),
              ),





            ],
          ),
        ),
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
              icon , color: tabIndex == _selectedTabIndex
              ? AppColor.primaryLightColor
              : AppColor.primaryDarkColor.withOpacity(0.2)
          ),
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
