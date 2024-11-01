


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';



Widget CustomTextFieldRegisterWidget({required String hintText ,required String titleText , required bool needful  , required context ,

TextEditingController? textEditingController,bool? showCursor} ){
  final textTheme = Theme.of(context).textTheme;
  return     Padding(
    padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 25),
    child: SizedBox(
      height: 53,
      child: TextFormField(
        controller: textEditingController??TextEditingController(),
        showCursor: showCursor??false,

        style: textTheme.bodyMedium?.copyWith(
          color:  AppColor.whiteColor
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:  textTheme.bodyMedium?.copyWith(
            color:  AppColor.whiteColor.withOpacity(0.2),
          ),
          // contentPadding: EdgeInsets.only( left: 8 , right: 8  ),
          prefixIcon: Stack(
             alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25 , left: 10),
                child: Text(titleText , style: textTheme.bodyMedium?.copyWith(
                    color: Color(0xff4E4E61).withOpacity(0.5)
                )
                ),
              ),
              Positioned(

                right: 10,
                child: Container(
                    height: 28,
                    width: 1.5,
                    color:Color(0xff4E4E61).withOpacity(0.5)
                ),
              )
            ],
          ),
          fillColor: Color(0xff0E0E12).withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9.sp),
              borderSide: BorderSide.none
          ),



        ),
      ),
    ),
  );
}