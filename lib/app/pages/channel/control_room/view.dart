import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/channel/control_room/widget/inout_widget.dart';
import 'package:mediaverse/app/pages/channel/control_room/widget/output_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/font_style.dart';
import 'logic.dart';

class ControlRoomPage extends StatefulWidget {
  @override
  State<ControlRoomPage> createState() => _ControlRoomPageState();
}

class _ControlRoomPageState extends State<ControlRoomPage>     with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;


ControlRoomLogic logic = Get.put(ControlRoomLogic());

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
        toolbarHeight: 6.h,
        centerTitle: true,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22.0, bottom: 20),
              child: Text(
                'Control Room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp
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
                  _buildTab(context, 0, 'Output'),
                  _buildTab(context, 1, 'Input'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  OutPutWidget(),
                  InputWidget(),
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
