

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../common/app_color.dart';
import '../common/app_image.dart';



Widget LogoAppWidget(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(AppImage.logo),
      SizedBox(
        height: 1.h,
      ),
      Text(
        'MediaVers',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      Text(
        'content is wealth',
        style: TextStyle(
          color: AppColor.primaryLightColor,
          fontSize: 14,
        ),
      ),

    ],
  );
}