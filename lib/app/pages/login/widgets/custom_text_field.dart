


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import 'country_code_widget.dart';


Widget CustomTextFieldLogin({required Widget prefix ,required String hintText , required context,required TextEditingController editingController,bool  isFalsePadding=false} ){
  final textTheme = Theme.of(context).textTheme;
  return  Padding(
    padding:  EdgeInsets.only(left:isFalsePadding?0: 16 , right:isFalsePadding?0:  16),
    child: TextFormField(
     // showCursor: false,
      controller: editingController,
       //
      style: textTheme.bodyLarge?.copyWith(
        color: AppColor.whiteColor
      ),
      onChanged: (s){
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
Widget PAsswordCustomTextFieldLogin({required Widget prefix ,required String hintText , required context,required TextEditingController editingController,bool  isFalsePadding=false} ){
  final textTheme = Theme.of(context).textTheme;
  return  Padding(
    padding:  EdgeInsets.only(left:isFalsePadding?0: 16 , right:isFalsePadding?0:  16),
    child: TextFormField(
      obscureText: true,
     // showCursor: false,
      controller: editingController,
       //
      style: textTheme.bodyLarge?.copyWith(
        color: AppColor.whiteColor
      ),
      onChanged: (s){
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