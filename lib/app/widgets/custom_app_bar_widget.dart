import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/search/view.dart';

PreferredSizeWidget CustomAppBarWidget() {
  return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 80,
      title: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(
            width: 7,
          ),
          const Text('Ma.Nakhli' , style: TextStyle(
            fontSize: 19
          ),),

          const Spacer(),
          GestureDetector(
            onTap: (){
              Get.toNamed(PageRoutes.SEARCH);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: AppColor.grayLightColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: SvgPicture.asset(AppIcon.searchIcon)
              ),
            ),
          )
        ],
      ));
}
