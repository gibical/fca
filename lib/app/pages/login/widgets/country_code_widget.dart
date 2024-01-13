

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';


Widget CountryCodeWidget(){
  return Stack(
    alignment: Alignment.center,
    children: [
      CountryCodePicker(
             flagWidth: 25,
        onChanged: print,
        initialSelection: 'FR',
        textStyle: FontStyleApp.bodyMedium.copyWith(
          color: AppColor.whiteColor
        ),

        dialogBackgroundColor: Colors.pink,
        barrierColor: Colors.transparent,
        dialogSize: Size(500, 500),
        boxDecoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15.sp)
        ),
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
      Positioned(

        right: 10,
        child: Container(
          height: 28,
          width: 1.5,
          color: AppColor.primaryDarkColor.withOpacity(0.2),
        ),
      )
    ],
  );
}