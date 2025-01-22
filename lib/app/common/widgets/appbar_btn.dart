
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';



Widget AppbarBTNWidget({required String iconName ,required Function() onTap ,RxBool? isLoading }){
  return Container(
    height: 5.5.h,
    width: 5.5.h,
    decoration: BoxDecoration(

      color: AppColor.secondaryDark,
      borderRadius: BorderRadius.circular(
          8.sp
      ),
      border: Border.all(
        color: '#0F0F26'.toColor(),
      ),

    ),
    child: Material(

      color: Colors.transparent,
      child: InkWell(

        splashColor: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(
            8.sp
        ),
        onTap: onTap,
        child: Center(
          child: isLoading?.value == true ?CupertinoActivityIndicator(
            color: AppColor.whiteColor,
            radius: 7,

          ):SvgPicture.asset('assets/mediaverse/icons/${iconName}.svg' , color: Colors.white, height: 24 ,width: 24,),
        ),
      ),
    ),
  );
}
Widget AppbarBTNWidgetAll({required String iconName ,required Function() onTap ,RxBool? isLoading }){
  return Container(
    height: 5.5.h,
    width: 5.5.h,
    decoration: BoxDecoration(

      color: AppColor.secondaryDark,
      borderRadius: BorderRadius.circular(
          8.sp
      ),
      border: Border.all(
        color: '#0F0F26'.toColor(),
      ),

    ),
    child: Material(

      color: Colors.transparent,
      child: InkWell(

        splashColor: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(
            8.sp
        ),
        onTap: onTap,
        child: Center(
          child: isLoading?.value == true ?CupertinoActivityIndicator(
            color: AppColor.whiteColor,
            radius: 7,

          ):SvgPicture.asset('assets/all/icons/${iconName}.svg' , color: Colors.white, height: 24 ,width: 24,),
        ),
      ),
    ),
  );
}