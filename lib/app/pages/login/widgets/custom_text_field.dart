


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import 'country_code_widget.dart';


Widget CustomTextFieldLogin({required Widget prefix ,required String hintText} ){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: TextFormField(
      showCursor: false,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], //
      style: TextStyle(
          color: AppColor.primaryDarkColor
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:  TextStyle(
            color: AppColor.primaryDarkColor.withOpacity(0.2)
        ),
        contentPadding: EdgeInsets.only(top: 8),
        fillColor: AppColor.whiteColor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9.sp),
            borderSide: BorderSide.none
        ),

        prefixIcon:prefix

      ),
    ),
  );
}