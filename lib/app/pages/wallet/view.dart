import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:gibical/app/common/app_color.dart';
import 'package:gibical/app/common/app_icon.dart';
import 'package:gibical/app/common/font_style.dart';
import 'package:gibical/app/pages/home/logic.dart';
import 'package:gibical/app/pages/profile/logic.dart';
import 'package:gibical/app/pages/transactions/view.dart';
import 'package:gibical/app/pages/wallet/logic.dart';
import 'package:sizer/sizer.dart';

import '../wrapper/logic.dart';


class WalletScreen extends StatelessWidget {

  ProfileControllers logic = Get
      .find<HomeLogic>()
      .profileController;

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
            if(logic.isStripeConnected)      Padding(
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
                    height: 5.h,
                  ),
                  if(logic.isStripeConnected)       Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          width: 100.w,
                          height: 40.h,
                          child: SvgPicture.asset(AppIcon.cardIcon)
                      ),
                      Container(
                        height: 40.h,
                        width: 56.w,

                        decoration: BoxDecoration(
                            color: Color(0xff4E4E61),
                            borderRadius: BorderRadius.circular(15.sp)
                        ),
                      ),


                      Positioned(
                        bottom: 3.5.h,
                        child: SvgPicture.asset(AppIcon.chipIcon),
                      ),

                      Container(
                        height: 40.h,
                        width: 56.w,
                        child: PageView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ClipRRect(

                                    child: Image.asset(
                                        "assets/images/stripeLogo.jpg",
                                        height: 60),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  SizedBox(
                                    height: 10.h,

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child:  Text('${logic.model.firstName??""} ${processName(logic.model.lastName??"")}',
                                        style: FontStyleApp.bodyMedium
                                            .copyWith(
                                            color: Color(0xffCCCCFF)
                                        ),),
                                    ),
                                  ),

                                  Text('wallet_3'.tr,
                                    style: FontStyleApp.titleSmall.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                    ),),
                                ],
                              );
                            }),
                      )


                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  if(!logic.isStripeConnected)    InkWell(
                    onTap: (){
                      logic.getStripeConnect();
                    },
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
                  SizedBox(
                    height: 4.h,
                  ),
                  if(logic.isStripeConnected)    InkWell(onTap: (){
                    logic.getStripeGateWay();
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
                ],
              ),
            )
        );
      });
    });
  }
}
