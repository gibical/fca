import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/massage/logic.dart';
import 'package:mediaverse/app/pages/massage/single_view.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetMesseges.dart';
import 'package:sizer/sizer.dart';


class MassageScreen extends StatelessWidget {
  final logic = Get.put(MessegeController());

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
      ):
      Scaffold(
        backgroundColor: AppColor.blueDarkColor,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(onPressed: () {
            Get.back();
          },
              icon: SvgPicture.asset(AppIcon.backIcon)),
          title: Text('messege_2'.tr, style: FontStyleApp.titleMedium.copyWith(
              color: AppColor.whiteColor
          ),),
        ),
        body: logic.list.isEmpty?  Container(
            padding: EdgeInsets.zero,
            child: Center(child: Text("messege_3".tr))):CustomScrollView(
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

  Padding MassageItemWidget(MessegesModel elementAt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
      child: InkWell(
        onTap: (){

          Get.to(SingleMassageScreen(),arguments: [elementAt]);
        },
        child: Container(
          height: 11.5.h,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w,),
                child: Row(
                  children: [
                    Text('${elementAt.message}', style: FontStyleApp.bodyMedium.copyWith(
                        color: Colors.white
                    ),),
                    Spacer(),
                    Text(
                      'April 26  13:23', style: FontStyleApp.bodySmall.copyWith(
                        color: Colors.grey.withOpacity(0.3)
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
                 elementAt.createdAt??"",
                  style: FontStyleApp.bodyMedium.copyWith(
                    color: Colors.grey.withOpacity(0.7),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
