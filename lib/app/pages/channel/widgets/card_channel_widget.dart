
import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

Widget CardChannelWidget({required String title , required String date}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
    child: Container(
      width: double.infinity,
      height: 8.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.white.withOpacity(0.22),
            strokeAlign: BorderSide.strokeAlignCenter
          )
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        AppColor.primaryLightColor,
                      ])
              ),
            ),
            SizedBox(width: 2.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title , style: FontStyleApp.bodyMedium.copyWith(
                  color: AppColor.whiteColor,
                ),
                ), Text(date , style: FontStyleApp.bodySmall.copyWith(
                  color: AppColor.grayLightColor.withOpacity(0.5),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}