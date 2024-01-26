
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

class AddChannelCardWidget extends StatelessWidget {
  const AddChannelCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 10),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
            width: 0.7
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Add Channel'  , style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.grayLightColor.withOpacity(0.5),

            ),),
            SizedBox(width: 2.w,),
            Icon(Icons.add , color:  AppColor.grayLightColor.withOpacity(0.5),size: 20),
          ],
        )
      ),
    );
  }
}
