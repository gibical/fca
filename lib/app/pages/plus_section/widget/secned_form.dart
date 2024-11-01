import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus_section/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_route.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';
import 'custom_plan_text_filed.dart';

class SecendForm extends StatefulWidget {
  const SecendForm({super.key});

  @override
  State<SecendForm> createState() => _SecendFormState();
}

class _SecendFormState extends State<SecendForm> {
  PlusSectionLogic logic = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlusSectionLogic>(
        init: logic,
        builder: (logic) {
      return WillPopScope(
        onWillPop: ()async=>false,
        child: Scaffold(
          backgroundColor: AppColor.blueDarkColor,

          body: Center(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 7.5.w),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Container(
                                  width: 16.w,
                                ),
                                Text("plus_14".tr,
                                  style: TextStyle(color: Colors.white),),
                                Container(
                                  width: 16.w,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),

                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("plus_15".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              CustomTDropDownPlusWidget(
                                  context: context,
                                  textEditingController: logic.planController,

                                  titleText: 'plus_16'.tr,
                                  hintText: 'plus_17'.tr,
                                  needful: false,
                                  models: [
                                    "plus_18".tr, "plus_19".tr, "plus_20".tr
                                  ]),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("plus_21".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              CustomTDropDownPlusWidget(
                                  models: [
                                    "plus_22".tr,
                                    "plus_23".tr,
                                  ],
                                  context: context,
                                  textEditingController: logic
                                      .editibaleController,

                                  titleText: 'plus_24'.tr,
                                  hintText: 'plus_25'.tr,
                                  needful: false),
                            ],
                          ),
                          if(logic.planController.text.contains(
                              "Ownership")||logic.planController.text.contains(
                              "Subscription")) SizedBox(height: 4.h,),

                          if(logic.planController.text.contains(
                              "Ownership")||logic.planController.text.contains(
                              "Subscription")) Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("plus_26".tr, style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                              CustomTextFieldPlusWidget(
                                  context: context,
                                  textEditingController: logic.priceController,



                                  titleText: 'plus_27'.tr,
                                  suffix: Text("€",style: TextStyle(color: Colors.white,fontSize: 13.sp),),
                                  hintText: 'plus_28'.tr,
                                  needful: false),
                            ],
                          ),
                          if(logic.planController.text.contains(
                              "Subscription")) SizedBox(height: 4.h,),

                          if(logic.planController.text.contains(
                              "Subscription")) Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("editprof_19".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              CustomTDropDownPlusWidget(
                                  models: [

                                    "plus_29".tr,
                                    "plus_30".tr,
                                    "plus_31".tr,
                                    "plus_32".tr,
                                  ],
                                  context: context,
                                  textEditingController: logic
                                      .subscrptionController,

                                  titleText: 'plus_33'.tr,
                                  hintText: 'plus_34'.tr,
                                  needful: false),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 6.h,
                                  margin: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: "597AFF".toColor(),
                                      borderRadius: BorderRadius.circular(5000)
                                  ),
                                  child: Obx(() {
                                    return MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5000)
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        print('_SecendFormState.build = ${logic.videoOutPut}');
                                            logic.sendMainRequest();
                                      },
                                      child: logic.isloading.value ? Lottie.asset(
                                          "assets/json/Y8IBRQ38bK.json", height: 10.h) : Text(
                                        "plus_35".tr, style: TextStyle(color: Colors.white),),
                                    );
                                  }),
                                ),
                                Container(
                                  width: 100.w,
                                  height: 6.h,
                                  margin: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: "597AFF".toColor()),
                                      borderRadius: BorderRadius.circular(5000)
                                  ),
                                  child: Obx(() {
                                    return MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5000)
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Get.offAllNamed(PageRoutes.WRAPPER);
                                      },
                                      child: logic.isloading.value ? Lottie.asset(
                                          "assets/json/Y8IBRQ38bK.json", height: 10.h) : Text(
                                        "Cancel".tr, style: TextStyle(color: Colors.white),),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h,)
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
