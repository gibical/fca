
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../common/font_style.dart';

Widget CardMarkSinglePageWidget({required String label , required String type }) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      height: 5.h,
      width: 40.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey.withOpacity(0.5)
          ),
          borderRadius: BorderRadius.circular(10.sp)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label , style: FontStyleApp.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.5)
            ),),
            SizedBox(
              width: 2.w,
            ),
            Container(
                height: 2.3.h,
                width: 1,
                color: Colors.white.withOpacity(0.5)
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(type , style: FontStyleApp.bodyMedium.copyWith(
                color: Colors.white
            ),),
          ],
        ),
      ),
    ),
  );
}