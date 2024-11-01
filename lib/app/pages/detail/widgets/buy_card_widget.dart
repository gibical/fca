

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';

Widget BuyCardWidget({required   price ,required title , required  selectedItem }){
  return Container(
    height: 22.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topRight: Radius.circular(16.sp) , topLeft: Radius.circular(16.sp)),
      color: Colors.white.withOpacity(0.1),
    ),
    child:Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 7.5.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(15)
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Text("$title: ${price}" , style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                    SizedBox(
                      height: 1.8.h,
                    ),
                    Spacer(),
                    SvgPicture.asset(AppIcon.detail4Icon , color: Colors.white,),
                    SizedBox(
                      width: 4.5.w,
                    ),

                    SvgPicture.asset(AppIcon.detail1Icon , color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0 , vertical: 10),
            child: SizedBox(
              height: 6.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Get.find<DetailController>().buyAsset(selectedItem['asset_id']);


                },
                child: Text('details_11'.tr , style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),),
                style: ElevatedButton.styleFrom(
                    shadowColor: AppColor.primaryLightColor.withOpacity(0.4),
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.3.sp)),
                    backgroundColor: AppColor.primaryLightColor
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}