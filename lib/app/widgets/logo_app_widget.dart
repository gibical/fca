

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../common/app_color.dart';
import '../common/app_image.dart';



Widget LogoAppWidget(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/splash_ic2.png",
      height: 10.h,)
    ],
  );
}