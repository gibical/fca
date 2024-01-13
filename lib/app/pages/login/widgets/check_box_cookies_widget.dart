import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';

import '../../../common/app_color.dart';


Widget CheckBoxWidget(){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Checkbox(
        value: true,
        onChanged: (_){},
        activeColor: AppColor.primaryLightColor,
        overlayColor: MaterialStatePropertyAll(Colors.transparent),

      ),
      Text('accept' , style: FontStyleApp.bodyLarge.copyWith(
        color: AppColor.whiteColor
      )
      ),
      SizedBox(width: 3,),
      Text('cookies' , style: FontStyleApp.bodyLarge.copyWith(
          color: AppColor.whiteColor,
        decoration: TextDecoration.underline
      )),
    ],
  );
}