import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_program_bottonsheet.dart';

class ProgramsScheduleEmptyState extends StatelessWidget {

  Programs programs;
  MyChannelController logic = Get.find<MyChannelController>();

  ProgramsScheduleEmptyState(this.programs);

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/all/icons/my_channel_8.svg"),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "my_channel_34".tr,
                  style: TextStyle(
                      color: "#9C9CB8".toColor(), fontSize: 9.sp),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),

        ],
      ),
    );
  }

  void _showSlecltProGramTyoeBottmSheet() async {
    dynamic result = Get.bottomSheet(
        AddProgramBottonsheet(false), isScrollControlled: true);
  }

}
