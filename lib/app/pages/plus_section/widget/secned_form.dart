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
      return Scaffold(
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
                              IconButton(onPressed: () {
                                Get.back();
                              },
                                  icon: Icon(Icons.arrow_back, color: "666680"
                                      .toColor(),)),
                              Text("Save \$ publish",
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
                            Text("Choose Your Plan",
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                            CustomTDropDownPlusWidget(
                                context: context,
                                textEditingController: logic.planController,

                                titleText: 'Choose a plan',
                                hintText: 'Insert your title',
                                needful: false,
                                models: [
                                  "Free", "Ownership", "Subscription"
                                ]),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Is editable for others",
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                            CustomTDropDownPlusWidget(
                                models: [
                                  "Yes",
                                  "No"
                                ],
                                context: context,
                                textEditingController: logic
                                    .editibaleController,

                                titleText: 'Check Editable status',
                                hintText: 'Choose Editable status',
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
                            Text("Price", style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold),),
                            CustomTextFieldPlusWidget(
                                context: context,
                                textEditingController: logic.priceController,



                                titleText: 'Title',
                                hintText: 'Insert your Price',
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
                            Text("Subscription Period",
                              style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                            CustomTDropDownPlusWidget(
                                models: [
                                  "1 Day",
                                  "3 Days",
                                  "1 Week",
                                  "1 Month"
                                ],
                                context: context,
                                textEditingController: logic
                                    .subscrptionController,

                                titleText: 'Check Forkability status',
                                hintText: 'Insert Periood',
                                needful: false),
                          ],
                        ),
                        SizedBox(height: 4.h,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
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
                                  "Save and Publish", style: TextStyle(color: Colors.white),),
                              );
                            }),
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
      );
    });
  }
}
