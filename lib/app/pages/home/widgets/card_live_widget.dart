import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

Widget CardLiveWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 35.w,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(5.sp),
        border: Border.all(
          color: AppColor.primaryDarkColor.withOpacity(0.2),
              width: 0.6
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 35.w / 3
            ,
            height: 8.h,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(5.sp),
              image: DecorationImage(image:AssetImage('assets/images/test.png') ),
            ),
          ),
          SizedBox(width: 1.5.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('euro news' , style: FontStyleApp.bodyMedium,),
              Text('news' , style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.primaryDarkColor.withOpacity(0.2)
              ),)
            ],
          )
        ],
      )
    ),
  );
}
