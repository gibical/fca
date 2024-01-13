


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';



Widget CustomTextFieldRegisterWidget({required String hintText ,required String titleText , required bool needful  } ){

  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 27 , right: 27),
        child: Row(
          children: [
            Text(titleText , style: FontStyleApp.bodySmall.copyWith(
              color: AppColor.whiteColor.withOpacity(0.88),
            )
            ),
            Text(' *' , style: FontStyleApp.bodySmall.copyWith(
              color: needful ? AppColor.errorColor :Colors.transparent,
            )
            ),
          ],
        ),
      ),
      SizedBox(
        height: 1.2.h,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25 , right: 25),
        child: SizedBox(
          height: 53,
          child: TextFormField(
            showCursor: false,

            style: FontStyleApp.bodyMedium,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle:  FontStyleApp.bodyMedium.copyWith(
                  color: AppColor.primaryDarkColor.withOpacity(0.2)
                ),
               // contentPadding: EdgeInsets.only( left: 8 , right: 8  ),
                fillColor: AppColor.whiteColor,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.sp),
                    borderSide: BorderSide.none
                ),



            ),
          ),
        ),
      ),
      SizedBox(
        height: 2.6.h,
      ),
    ],
  );
}