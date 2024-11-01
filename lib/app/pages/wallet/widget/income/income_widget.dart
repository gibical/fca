import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/font_style.dart';
import '../../../profile/logic.dart';
import '../../../transactions/view.dart';
import '../../../wrapper/logic.dart';

class IncomeWidget extends StatelessWidget {
  ProfileControllers logic;

  IncomeWidget(this.logic);

  @override
  Widget build(BuildContext context) {
    String processName(String title) {
      String processedTitle = title.length > 10
          ? '${title.substring(0, 10)} ...'
          : title;

      return processedTitle;
    }
    return GetBuilder<ProfileControllers>(
        init: logic,
        builder: (logic) {
          return Obx(() {
            return (logic.isloading.value||logic.isloadingWallet.value) ? Scaffold(
              backgroundColor: AppColor.blueDarkColor,

              body: Container(

                child: Center(
                  child: Lottie.asset("assets/json/Y8IBRQ38bK.json", height: 10.h),
                ),
              ),
            ) : Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 7.h,
                      ),
                      Visibility(child: Column(children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Text("Your Are Successfuly Connected To Stripe",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp),),
                        Container(child: Lottie.asset("assets/json/success2.json",repeat:
                        false
                        ),height: 15.h,),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        InkWell(
                          onTap: (){
                            try {
                              launchUrlString(logic.setupURL);
                            }  catch (e) {
                              // TODO
                            }
                        }, child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            height: 7.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Setup Panel'.tr, style: FontStyleApp.bodyLarge
                                    .copyWith(
                                    color: Colors.grey
                                ),),
                                SizedBox(width: 2.w,),
                                SvgPicture.asset(
                                    AppIcon.addIcon, height: 16, color: Colors.grey)
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        InkWell(
                          onTap: (){
                            try {
                              launchUrlString(logic.setupURL);
                            }  catch (e) {
                              // TODO
                            }
                        }, child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            height: 7.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Dashboard Panel'.tr, style: FontStyleApp.bodyLarge
                                    .copyWith(
                                    color: Colors.grey
                                ),),
                                SizedBox(width: 2.w,),
                                SvgPicture.asset(
                                    AppIcon.addIcon, height: 16, color: Colors.grey)
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                )
                            ),
                          ),
                        ),
                      ],),visible: logic.isIncomeStripeConnected,),
                      Visibility(child: Column(children: [

                        Text("Your Are Not Connected To Stripe",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp),),
                        Container(
                            width: 60.w,
                            height: 25.h,
                            child: Lottie.asset("assets/json/empty.json")
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          child: InkWell(
                            onTap: (){
                              logic.getPayoutConnect();
                            },
                            child: Container(

                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 23.w),
                                height: 7.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'wallet_4'.tr, style: FontStyleApp.bodyLarge.copyWith(
                                        color: Colors.grey
                                    ),),
                                    SizedBox(width: 2.w,),
                                    SvgPicture.asset(
                                        AppIcon.addIcon, height: 16, color: Colors.grey)
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],),visible: !logic.isIncomeStripeConnected,),

                    ],
                  ),
                )
            );
          });
        });
  }
}
