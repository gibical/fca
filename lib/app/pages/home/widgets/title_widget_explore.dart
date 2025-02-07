import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class TitleWidgetExplore extends StatelessWidget {
  String title;
  Function onTap;

  TitleWidgetExplore(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      margin: EdgeInsets.symmetric(
        horizontal: 16,vertical: 0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
          MaterialButton(

            onPressed: (){
              onTap.call();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("home_9".tr,style: TextStyle(
                    color: AppColor.primaryLightColor,
                    fontWeight: FontWeight.w500
                ),),
                SizedBox(width: 1.5.w,),
                Icon(Icons.arrow_forward_ios,color: AppColor.primaryLightColor,size: 9.sp,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
