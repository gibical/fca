import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetSessions.dart';
import 'package:sizer/sizer.dart';

import '../../../gen/model/json/walletV2/FromJsonGetSesseinsModel.dart';
import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/font_style.dart';
import 'logic.dart';

class SessionsPage extends StatelessWidget {

  final logic = Get.put(SessionsLogic());
  final state = Get
      .find<SessionsLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return logic.isloading.value?Scaffold(
        backgroundColor: AppColor.blueDarkColor,

        body: Container(

          child: Center(
            child:  Lottie.asset("assets/json/Y8IBRQ38bK.json",height: 10.h),
          ),
        ),
      ): Scaffold(
        backgroundColor: AppColor.blueDarkColor,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () {
            Get.back();
          },
              icon: SvgPicture.asset(AppIcon.backIcon)),
          title: Text('sessions_1'.tr, style: FontStyleApp.titleMedium.copyWith(
              color: AppColor.whiteColor
          ),),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
                itemCount: logic.list.length,
                itemBuilder: (context, index) {
                  return MassageItemWidget(logic.list.elementAt(index));
                }),
          ],
        ),
      );
    });
  }

  Padding MassageItemWidget(SessionsModels elementAt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
      child: Container(

        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff4E4E61).withOpacity(0.3),
            borderRadius: BorderRadius.circular(16.sp),
            border: Border(
              left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
              bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.3), width: 0.4),
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w,),
              child: Row(
                children: [
                  Text(' ${elementAt.name??""}', style: FontStyleApp.bodyMedium.copyWith(
                      color: Colors.white
                  ),),

                ],
              ),
            ),
            SizedBox(
              height: 0.8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
               elementAt.updatedAt??"",
                style: FontStyleApp.bodyMedium.copyWith(
                  color: Colors.grey.withOpacity(0.7),
                ),),
            ),
            SizedBox(
              height: 1.5.h,
            ),
          ],
        ),
      ),
    );
  }
}
