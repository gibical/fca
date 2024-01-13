import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';

import '../../../common/app_color.dart';


Widget CodeOTPWidget(){
  return SizedBox(
    height: 53,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25 , left: 10),
            child: Text('Code' , style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.primaryDarkColor.withOpacity(0.2)
            )
            ),
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
      ),
    ),
  );
}