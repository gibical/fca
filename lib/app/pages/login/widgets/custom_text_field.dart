


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import 'country_code_widget.dart';


Widget CustomTextFieldLogin({required Widget prefix ,required String hintText , required context,required TextEditingController editingController} ){
  final textTheme = Theme.of(context).textTheme;
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: TextFormField(
      showCursor: false,
      controller: editingController,
       //
      style: textTheme.bodyLarge?.copyWith(
        color: AppColor.whiteColor
      ),
      onChanged: (s){
        print('CustomTextFieldLogin = ${s.isEmail}');
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:  TextStyle(
            color: AppColor.whiteColor.withOpacity(0.2),
        ),
        contentPadding: EdgeInsets.only(top: 8),
        fillColor: Color(0xff0E0E12).withOpacity(0.5),
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