import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gibical/app/common/app_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/font_style.dart';
import '../../../profile/logic.dart';
import '../../../transactions/view.dart';
import '../../../wrapper/logic.dart';

class BillingWidget extends StatelessWidget {
  ProfileControllers logic;

  BillingWidget(this.logic);

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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            height: 7.h,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                children: [
                                  Text('wallet_1'.tr,
                                    style: FontStyleApp.bodyMedium.copyWith(
                                        color: Colors.grey
                                    ),),

                                  SizedBox(
                                    width: 2.w,
                                  ),

                                  Container(
                                    height: 3.5.h,
                                    width: 1,
                                    color: Colors.grey,
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text("${Get.find<WrapperController>().walletBalance} €",style: TextStyle(
                                      color: Colors.white,fontWeight: FontWeight.bold
                                  ),),

                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text('${logic.walletModel.balance ?? ""}',
                                    style: FontStyleApp.bodyLarge.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.to(TransactionsPage());
                                      //logic.getStripe();
                                    },
                                    child: Text('wallet_2'.tr,
                                      style: FontStyleApp.bodyMedium.copyWith(
                                          color: AppColor.primaryLightColor,
                                          fontWeight: FontWeight.w600
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15.sp),
                                border: Border.all(
                                    color: AppColor.grayLightColor.withOpacity(0.1)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Stack(
                          alignment: Alignment.center,
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
                              padding: EdgeInsets.all(5.w),
                              child: Row(
                                children: [
                                  Expanded(child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Type: "  +"Task Audio to text" ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                        Text("Amount: "  +"45\&" ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11.sp),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                      ],
                                    ),
                                  )),
                                  Text("Date :" + DateTime.now().toFormattedDateString(),style: TextStyle(
                                    color: Colors.white.withOpacity(0.5)
                                  ),)
                                ],
                              ),
                            )

                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        InkWell(onTap: (){
                          logic.getsubscriptionSetting();
                        },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 14.w),
                            height: 7.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('wallet_5'.tr, style: FontStyleApp.bodyLarge
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
                      ],),visible:! logic.isBillingStripeConnected,),
                      Visibility(child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: InkWell(
                            onTap: (){
                              logic.getStripeConnect();
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
                      ],),visible: logic.isBillingStripeConnected,),

                    ],
                  ),
                )
            );
          });
        });
  }
}
