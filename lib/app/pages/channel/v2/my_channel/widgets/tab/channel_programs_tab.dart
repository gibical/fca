import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/delete_programs_dialog.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/programs_empty_state.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../add_program_bottonsheet.dart';
import '../live_empty_state.dart';
import '../program_show_page.dart';

class ChannelProgramsTab extends StatefulWidget {
  const ChannelProgramsTab({super.key});

  @override
  State<ChannelProgramsTab> createState() => _ChannelProgramsTabState();
}

class _ChannelProgramsTabState extends State<ChannelProgramsTab> {
  MyChannelController logic = Get.find<MyChannelController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyChannelController>(
        init: logic,
        builder: (logic) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: Container(
              padding: EdgeInsets.only(top: 3.h),
              child: (logic.mainChannelModel.programs ?? []).isEmpty
                  ? ProgramsEmptyState()
                  : Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: logic.mainChannelModel.programs!.length,
                                  itemBuilder: (s, i) {
                                    Programs program = logic.mainChannelModel.programs!.elementAt(i);
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 1.h),
                                      child: Container(
                                        width: 100.w,
                                        height: 8.h,
                                        decoration: BoxDecoration(
                                          color: "0f0f26".toColor(),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        child: MaterialButton(
                                          onPressed: (){
                                            Get.bottomSheet(ProgramShowPage(program),isScrollControlled: true);
                                          },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Expanded(child: Column(

                                                children: [
                                                  Text(program.name??""),
                                                  Text(DateFormat('d MMMM, h:mm a').format(DateTime.parse(program.createdAt??"")),style: TextStyle(color: "#9C9CB8".toColor(),fontSize: 9.sp),),
                                                ],
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                              )),
                                              GestureDetector(

                                                  child: SvgPicture.asset("assets/all/icons/trash.svg"),
                                              onTap: (){

                                                    Get.dialog(DeleteProgramsDialog(program));
                                              },)
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                          Container(
                            width: 100.w,
                            height: 5.h,
                            margin: EdgeInsets.symmetric(vertical: 2.h),
                            decoration: BoxDecoration(
                                color: AppColor.primaryLightColor,
                                borderRadius: BorderRadius.circular(500)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                _showSlecltProGramTyoeBottmSheet();
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/all/icons/my_channel_4.svg"),
                                  SizedBox(width: 1.5.w,),
                                  Text("my_channel_10".tr,style: TextStyle(fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
            ),
          );
        });
  }
  void _showSlecltProGramTyoeBottmSheet()async {
    dynamic result =  Get.bottomSheet(AddProgramBottonsheet(false),isScrollControlled: true);

  }
}
