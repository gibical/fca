import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import 'animation_text_field_widget.dart';



class AdvanceSearchWidget extends GetView<SearchLogic> {
  const AdvanceSearchWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchLogic>(builder: (controller){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20 , right: 20 , ),
            child: GestureDetector(
              onTap: (){
                controller.showAdvanceTextField();
              },
              child: Container(
                color: AppColor.whiteColor,
                height: 5.h,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('search_1'.tr , style: FontStyleApp.bodyMedium.copyWith(
                      color: AppColor.primaryDarkColor.withOpacity(0.2)
                    )),
                    SvgPicture.asset(controller.isAdvancedSearchVisible ? AppIcon.downIcon : AppIcon.upIcon)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),

          if (controller.isAdvancedSearchVisible)
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 18 , right: 18 , top: 10),
                child: AnimationTextFieldWidget(
                  child: Column(
                    children: [
                      CustomFieldAdvance('search_2'.tr, 'search_3'.tr),
                      SizedBox(height: 1.h),
                      CustomFieldAdvance('search_4'.tr, 'search_5'.tr),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget CustomFieldAdvance(String hintText ,String title  ,  ){
    return   Row(
      children: [
        Text(title , style: FontStyleApp.bodyMedium.copyWith(
          color: AppColor.primaryDarkColor.withOpacity(0.2)
        ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: SizedBox(

            child: TextField(
              cursorHeight: 23,
              style: FontStyleApp.bodyLarge,
              cursorColor: AppColor.primaryDarkColor.withOpacity(0.8),
              cursorOpacityAnimates: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 13,
                ),
                fillColor: AppColor.grayLightColor,
                filled: true,
                hintText: hintText,
                hintStyle: FontStyleApp.bodyMedium.copyWith(
                  color: AppColor.primaryDarkColor.withOpacity(0.2)
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.sp),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
