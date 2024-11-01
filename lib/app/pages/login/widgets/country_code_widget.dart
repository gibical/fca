

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';


Widget CountryCodeWidget(context,LoginController controller){


  final textTheme = Theme.of(context).textTheme;
  return Row(
    mainAxisSize: MainAxisSize.min,
 //   alignment: Alignment.center,
    children: [
      SizedBox(width: 3.w,),
      GestureDetector(
        onTap: (){

        },
        child: IgnorePointer(
          ignoring: false,
          child: CountryCodePicker(

            padding: EdgeInsets.zero,
            dialogBackgroundColor: AppColor.blueDarkColor,

            // mode: CountryCodePickerMode.dialog,
            onChanged: (country) {
              controller.code  =country;
              print('CountryCodeWidget = ${country.dialCode}');
            },
            initialSelection: 'FR',
            showFlag: true,
            showDropDownButton: true,barrierColor: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
      Container(
        height: 28,
        width: 1.5,
        color: AppColor.whiteColor.withOpacity(0.2),
      ),
      SizedBox(width: 5,)
    ],
  );
}