import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/channel/tab/calendar_tab.dart';
import 'package:mediaverse/app/pages/channel/tab/channel_tab.dart';
import 'package:mediaverse/app/pages/channel/widgets/custom_calendar_widget.dart';

import '../../common/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_route.dart';
import '../share_account/logic.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final ShareAccountLogic _logic = Get.put(ShareAccountLogic());

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        toolbarHeight: 120,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 10.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 20),
                child: Text(
                  'channel_30'.tr,
                  style: FontStyleApp.titleMedium.copyWith(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: GestureDetector(
                  onTap: () {
                    // Handle the onTap event
                  },
                  child: Container(
                    height: 6.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColor.grayLightColor.withOpacity(0.1)),
                      color: Color(0xff0E0E12).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'channel_35'.tr,
                            style: FontStyleApp.bodyLarge
                                .copyWith(color: Color(0xff666680)),
                          ),
                          SvgPicture.asset(AppIcon.searchIcon,
                              color: Color(0xff666680)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
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
                labelColor: AppColor.primaryLightColor,
                dividerColor: Colors.transparent,
                tabs: [
                  _buildTab(context, 0, 'Programs'.tr),
                  _buildTab(context, 1, 'Conductor'.tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  ProgramsTab(),
                  CustomCalendarWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
