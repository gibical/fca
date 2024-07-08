


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sizer/sizer.dart';

import '../common/app_icon.dart';
import '../pages/wrapper/logic.dart';

class BottomNavWidget extends GetView<WrapperController> {
  @override
  Widget build(BuildContext context) {
    return GetX<WrapperController>(
        builder: (builderController) => Transform.translate(
          offset: Offset(0.0, -25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 9, sigmaX: 9),
                child: Stack(
                  children: [
                    Container(
                        height: 9.2.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border(
                              left: BorderSide(color: Colors.grey.withOpacity(0.3) ,width: 1.5),
                              bottom: BorderSide(color: Colors.grey.withOpacity(0.3)  ,),
                            )
                        )

                    ),
                    Container(
                      height: 9.2.h,
                      decoration: ShapeDecoration(
                        color: Colors.grey.withOpacity(0.35),
                        shape: MyBorderShape(),
                        shadows: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 8.0,
                              offset: Offset(1, 1)),
                        ],
                      ),
                      child: Row(
                        //   mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                          ItemBottomNavBar(
                              iconActive: AppIcon.exploreIcon,
                              icon: AppIcon.exploredeIcon,
                              size: 23,
                              indexItem: 0),

                          ItemBottomNavBar(
                              iconActive: AppIcon.channelIcon,
                              icon: AppIcon.channeldeIcon,
                              size: 23,
                              indexItem: 1),
                          SizedBox(width: 60,),

                          ItemBottomNavBar(
                              iconActive: AppIcon.walletIcon,
                              icon: AppIcon.walletdeIcon,
                              size: 18.5,
                              indexItem: 2),

                          ItemBottomNavBar(
                              iconActive: AppIcon.profileIcon,
                              icon: AppIcon.profiledeIcon,
                              size: 23,
                              indexItem: 3),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
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
  return Expanded(
      child: GestureDetector(
          onTap: () {
            builderController.navigatePages(indexItem);
          },
          child: SvgPicture.asset(
            builderController.selectedIndex.value == indexItem ? iconActive : icon,
            height: size,
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
        RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)),
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
