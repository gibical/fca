import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:mediaverse/app/common/font_style.dart';

import '../../../common/app_color.dart';


Widget CodeOTPWidget(context){

  final textTheme = Theme.of(context).textTheme;
  return SizedBox(
    height: 53,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25 , left: 10),
            child: Text('otp_1'.tr , style: textTheme.bodyMedium?.copyWith(
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
    ),
  );
}