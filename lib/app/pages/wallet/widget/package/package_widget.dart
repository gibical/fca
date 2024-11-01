import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/font_style.dart';
import '../../../profile/logic.dart';
import '../../../transactions/view.dart';
import '../../../wrapper/logic.dart';

class PackageWidget extends StatelessWidget {
  ProfileControllers logic;

  PackageWidget(this.logic);

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      SizedBox(height: 10.h,),
                      Visibility(child: Column(children: [
                        Text("Select Your Plan",style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.sp
                        ),),
                        SizedBox(
                          height: 3.h,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [

                            Column(
                              children: logic.plansModel.asMap().entries.map((e){
                                return    Container(
                                  width: 100.w,
                                  height: 10.h,

                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15.sp),
                                      border: Border.all(
                                          color: AppColor.grayLightColor.withOpacity(0.1)
                                      )
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 32,vertical: 1.h),
                                  padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
                                  child: Row(
                                    children: [
                                      Expanded(child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${e.value.name}"  ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            Text("${e.value.description}"
                                                "n an unknown printer took "  ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 7.sp),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                      )),
                                      Row(
                                        children: [


                                          Container(
                                            width: 16.w,
                                            height: 3.h,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColor.primaryLightColor
                                                ),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: MaterialButton(
                                              onPressed: (){},
                                              padding: EdgeInsets.zero,

                                              child: Center(
                                                child: Text("Subscribe",style: TextStyle(color:AppColor.primaryLightColor,fontWeight: FontWeight.w400 ),),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                      ],),visible:logic.isSubscribedPlan,),
                      Visibility(child: Column(children: [
                        Text("Your Active Plan is ",style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19.sp
                        ),),
                        SizedBox(
                          height: 3.h,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [

                            Column(
                              children: [

                                Container(
                                  width: 100.w,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15.sp),
                                      border: Border.all(
                                          color: AppColor.grayLightColor.withOpacity(0.1)
                                      )
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 32),
                                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                                  child: Row(
                                    children: [
                                      Expanded(child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 3.w,),
                                            Text("GOLD"  ,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            Text("orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, whe"
                                                "n an unknown printer took "  ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 7.sp),maxLines: 3,overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                      )),

                                    ],
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        InkWell(
                          onTap: (){
                            logic.getsubscriptionSetting();
                          }, child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 14.w),
                          height: 7.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Cancel '.tr, style: FontStyleApp.bodyLarge
                                  .copyWith(
                                  color: Colors.grey
                              ),),


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
                        SizedBox(height: 2.h,),
                        Text('Canceling Your Current Package Will affecr Your Bills Starting Next Month '.tr
                            ,style: TextStyle(
                            color: Colors.white,fontSize: 7.5.sp
                        ),),
                      ],),visible:! logic.isSubscribedPlan,),

                    ],
                  ),
                )
            );
          });
        });
  }
}
