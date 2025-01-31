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
    _tabController = TabController(length: 2, vsync: this, initialIndex: Get.arguments[1]);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((callback){
      _streamController.programModel = Get.arguments[0];
      _streamController.url = _streamController.programModel!.streamUrl;
      print('_StreamHomePageState.initState = ${_streamController.programModel!
          .streamUrl}');
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColor.backgroundColor,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [

            SizedBox(height: 10.h,),
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
