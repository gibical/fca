import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import 'add_program_bottonsheet.dart';

class ProgramsEmptyState extends StatelessWidget {
  const ProgramsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 10),
          Container(
            width: 80.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/all/icons/my_channel_3.svg"),
                SizedBox(
                  height: 1.h ,
                ),
                Text(
                  "my_channel_9".tr,
                  style: TextStyle(
                      color: "#9C9CB8".toColor(), fontSize: 9.sp),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
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
    );
  }

  void _showSlecltProGramTyoeBottmSheet()async {
   dynamic result =  Get.bottomSheet(AddProgramBottonsheet(false),isScrollControlled: true);

  }
}
