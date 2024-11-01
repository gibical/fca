import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/search/view.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget CustomAppBarWidget(context) {
  final theme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return AppBar(
      backgroundColor:  theme.secondary,
      
      toolbarHeight: 85,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25 ,),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(PageRoutes.SEARCH);
            // Get.find<HomeLogic>().getMainReueqst();
          },
          child: Container(
            height: 6.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search' ,style: FontStyleApp.bodyLarge.copyWith(
                    color: Color(0xff666680)
                  ),),
                  SvgPicture.asset(AppIcon.searchIcon , color: Color(0xff666680),)
                ],
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColor.grayLightColor.withOpacity(0.1)
                ),
                color: Color(0xff0E0E12).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.sp) , bottomRight: Radius.circular(50.sp))
      ),
    );
}
