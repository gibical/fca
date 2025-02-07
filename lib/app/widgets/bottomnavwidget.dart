


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../common/app_icon.dart';
import '../pages/wrapper/logic.dart';
import '../pages/wrapper/widgets/select_destination_bottom_sheet.dart';

class BottomNavWidget extends GetView<WrapperController> {
  @override
  Widget build(BuildContext context) {
    return GetX<WrapperController>(
        builder: (builderController) => Container(
          decoration: BoxDecoration(
            color: "17172e".toColor()
          ),
          child: Stack(
            children: [

              Container(
                height: 8.2.h,

                child: Row(
                  //   mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    ItemBottomNavBar(
                        iconActive: "assets/all/icons/bottom_nav_1.svg",
                        icon: "assets/all/icons/bottom_nav_1.svg",
                        size: 23,
                        indexItem: 0),

                    ItemBottomNavBar(
                        iconActive: "assets/all/icons/bottom_nav_2.svg",
                        icon: "assets/all/icons/bottom_nav_2.svg",
                        size: 23,
                        indexItem: 1),
                FloatingActionButton(
                      shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      splashColor: Colors.transparent,
                      backgroundColor: AppColor.primaryLightColor,
                      onPressed: () {
                        Get.bottomSheet(SelectDestinationBottomSheet());
                      },
                      child: Icon(
                        Icons.add,
                        color:Colors.white,
                      ),
                    ),

                    ItemBottomNavBar(
                        iconActive: "assets/all/icons/bottom_nav_4.svg",
                        icon: "assets/all/icons/bottom_nav_4.svg",
                        size: 18.5,
                        indexItem: 2),

                    ItemBottomNavBar(
                        iconActive: "assets/all/icons/bottom_nav_5.svg",
                        icon: "assets/all/icons/bottom_nav_5.svg",
                        size: 23,
                        indexItem: 3),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}

Widget ItemBottomNavBar({

  required String iconActive,
  required String icon,
  required int indexItem,
  required double size,
}) {
  final builderController = Get.find<WrapperController>();
  Color activColor = builderController.selectedIndex.value == indexItem ?AppColor.primaryLightColor:"#9C9CB8".toColor();
  return Expanded(
      child: GestureDetector(
          onTap: () {
            builderController.navigatePages(indexItem);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                builderController.selectedIndex.value == indexItem ? iconActive : icon,
                height: size,
                color: activColor,
              ),
              SizedBox(height: 1.h/2,),
              Text("nav_${indexItem+1}".tr,style: TextStyle(color:activColor,fontSize: 8.sp ),)
            ],
          )
      ));
}

class MyBorderShape extends ShapeBorder {
  MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)),//
      );
  }

  double holeSize = 75;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 4)),
        ),
      Path()
        ..addOval(
          Rect.fromCenter(
            center: rect.center.translate(0, -rect.height / 2),
            height: holeSize,
            width: holeSize,
          ),
        ),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
