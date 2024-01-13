import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';


Widget CustomRegisterButtonWidget({required String title  , required Function() onTap}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          title,
          style: FontStyleApp.bodyLarge.copyWith(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w300,
          )
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.sp)
            ),
            backgroundColor: AppColor.primaryLightColor

        ),
      ),
    ),
  );
}