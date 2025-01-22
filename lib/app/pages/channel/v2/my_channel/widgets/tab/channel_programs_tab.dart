import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/programs_empty_state.dart';
import 'package:sizer/sizer.dart';

import '../live_empty_state.dart';

class ChannelProgramsTab extends StatefulWidget {
  const ChannelProgramsTab({super.key});

  @override
  State<ChannelProgramsTab> createState() => _ChannelProgramsTabState();
}

class _ChannelProgramsTabState extends State<ChannelProgramsTab> {
  MyChannelController logic = Get.find<MyChannelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 3.h),
        child: (logic.baseModel.programs??[]).isEmpty
            ? ProgramsEmptyState()
            : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                ),
            ),
      ),
    );
  }
}
