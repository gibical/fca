

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gibical/app/common/font_style.dart';
import 'package:gibical/app/pages/login/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';


Widget CountryCodeWidget(context,LoginController controller){


  final textTheme = Theme.of(context).textTheme;
  return Row(
    mainAxisSize: MainAxisSize.min,
 //   alignment: Alignment.center,
    children: [
      IgnorePointer(
        ignoring: false,
        child: CountryCodePicker(
               flagWidth: 25,
          onChanged: (CountryCode d){
            print('CountryCodeWidget = ${d.dialCode}');
            controller.code  =d;

          },
          initialSelection: 'FR',
          textStyle: textTheme.bodyMedium!.copyWith(
            color: Colors.white,
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