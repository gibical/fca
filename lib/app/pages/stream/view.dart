import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/stream/widget/camear_stream_widget.dart';
import 'package:mediaverse/app/pages/stream/widget/stream_stream_widget.dart';
import 'package:mediaverse/app/pages/wallet/logic.dart';
import 'package:mediaverse/app/pages/wrapper/logic.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/font_style.dart';
import '../channel/tab/channel_tab.dart';
import 'logic.dart';

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage>     with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  StreamViewController _streamController = Get.find<WrapperController>().streamViewController;
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
        toolbarHeight: 70,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 1.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 20),
                child: Text(
                  'Stream Management'.tr,
                  style: FontStyleApp.titleMedium.copyWith(color: Colors.white),
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
                  _buildTab(context, 0, 'Camera'.tr),
                  _buildTab(context, 1, 'Screen'.tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  CameraStreamWidget(),
                  ScreenStreamWidget(),
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
