import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

Widget ItemVideoTabScreen(){
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7 ,vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 27.h,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(AppIcon.videoIcon),
                  Positioned(
                      bottom: 10,
                      left: 20,
                      child: Text('Velit officia consequat.')),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                image: DecorationImage(image: AssetImage('assets/images/test.png' ) , fit: BoxFit.cover ,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.55), BlendMode.hardLight),
                )
              ),
            ),
          SizedBox(height: 1.h,),
          Text('Amet minim mollit non deserunt ullamco est sit. amet sint. Velit officia consequat duis...' , style: FontStyleApp.bodyLarge.copyWith(
            color: AppColor.grayLightColor.withOpacity(0.6),

          ),),
          SizedBox(height: 2.3.h,),
          Row(
            children: [
              CircleAvatar(
                radius: 11,
              ),
              SizedBox(width: 2.w,),
              Text('Ralph Edwards' , style: FontStyleApp.bodySmall.copyWith(
                color: AppColor.grayLightColor.withOpacity(0.6),

              ),),
              Spacer(),
              Text('8:15' , style: FontStyleApp.bodySmall.copyWith(
                color: AppColor.grayLightColor.withOpacity(0.6),

              ),),
              SizedBox(width: 2.w,),
            ],
          )

        ],
      ),
    ),
  );
}