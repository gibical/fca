
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';

Widget selectFilterItem({required String title , required Function() onTap }) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 6.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.blueDarkColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12.sp)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(children: [

          Text(title , style: Theme
                                  .of(Get.context!)
                                  .textTheme.bodySmall?.copyWith(

          )
          ),
          Spacer(),
          SvgPicture.asset(AppIcon.downIcon , color: AppColor.whiteColor,)
        ],),
      ),
    ),
  );
}