

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/font_style.dart';


Container CustomCommentSinglePageWidget() {
  return Container(
    height: 17.5.h,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15.sp),
        border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.3) , width: 0.6),
            left: BorderSide(color: Colors.white.withOpacity(0.3) , width: 0.8),

            right: BorderSide(color: Colors.white.withOpacity(0.3) , width: 0.1)
        )
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal:6.w , vertical: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Text('details_12'.tr , style: FontStyleApp.bodyLarge.copyWith(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600
              ),
              ),

            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(

            children: [
              CircleAvatar(
                radius: 19,
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                  child: Container(
                    height: 5.h,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text('details_13'.tr),
                        )),
                    decoration: BoxDecoration(
                        color: AppColor.blueDarkColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(7.sp)
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    ),
  );
}