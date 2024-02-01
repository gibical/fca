import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';


class MassageScreen extends StatelessWidget {
  const MassageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Get.back();
        },
            icon: SvgPicture.asset(AppIcon.backIcon)),
        title: Text('Massage' , style: FontStyleApp.titleMedium.copyWith(
          color: AppColor.whiteColor
        ),),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
              itemCount: 10,
              itemBuilder: (context , index){
            return MassageItemWidget();
          }),
        ],
      ),
    );
  }

  Padding MassageItemWidget() {
    return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 6.w , vertical: 0.6.h),
            child: Container(
                height: 11.5.h,
                width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff4E4E61).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.sp),
                  border: Border(
                    left: BorderSide(color: Colors.grey.withOpacity(0.3) , width: 1),
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.3) , width: 0.4),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 6.w ,),
                    child: Row(
                      children: [
                        Text('New updates' , style: FontStyleApp.bodyMedium.copyWith(
                          color: Colors.white
                        ),),
                        Spacer(),
                        Text('April 26  13:23' , style: FontStyleApp.bodySmall.copyWith(
                          color: Colors.grey.withOpacity(0.3)
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.8.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text('Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia...' , style: FontStyleApp.bodyMedium.copyWith(
                        color: Colors.grey.withOpacity(0.7),
                    ),),
                  ),
                ],
              ),
            ),
          );
  }
}
