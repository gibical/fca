import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:sizer/sizer.dart';


class BestItemExploreWidget extends GetView<HomeLogic> {
  const BestItemExploreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 190,
        height: 190,
        decoration: BoxDecoration(
          color: theme.onBackground.withOpacity(0.1),
          image: DecorationImage(image: AssetImage('assets/images/test1.png' ,) , fit: BoxFit.cover),
          border: Border.symmetric(horizontal: BorderSide(
            width: 0.9,
            color: theme.onBackground.withOpacity(0.2 , ),
          )),
          borderRadius: BorderRadius.all(Radius.circular(20.sp))
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4),
                     Colors.transparent,

                ])
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15 , bottom: 10),
              child: SvgPicture.asset(AppIcon.videoIcon , color: AppColor.grayLightColor.withOpacity(0.5)  , height: 1.8.h),
            )
          ],
        )
      ),
    );
  }
}
