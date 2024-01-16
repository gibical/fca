import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

Widget CardLiveWidget(String img) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 35.w,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(5.sp),
        image: DecorationImage(image: NetworkImage(img) , fit: BoxFit.cover)
      ),

    ),
  );
}
