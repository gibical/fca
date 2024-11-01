import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_register_button_widget.dart';
import 'package:mediaverse/app/pages/signup/logic.dart';
import 'package:mediaverse/app/pages/signup/widgets/custom_text_field_form_register_widget.dart';
import 'package:mediaverse/app/widgets/logo_app_widget.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_config.dart';
import '../plus_section/widget/custom_plan_text_filed.dart';


class SignupScreen extends StatelessWidget {

  SignUpController logic = Get.put(SignUpController());


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder<SignUpController>(
          init: logic,
          builder: (logic) {
            return Scaffold(
              backgroundColor: AppColor.primaryDarkColor,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    LogoAppWidget(),

                    SizedBox(
                      height: 4.5.h,
                    ),
                    Text('signup_1'.tr),
                    SizedBox(
                      height: 5.h,
                    ),

                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'signup_2'.tr,
                        hintText: 'signup_3'.tr,
                        textEditingController: logic.firstNameController,

                        needful: true),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'signup_4'.tr,
                        hintText: 'signup_5'.tr,
                        textEditingController: logic.lastNameController,
                        needful: true),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'signup_6'.tr,
                        hintText: 'signup_7'.tr,
                        textEditingController: logic.passwordNameController,
                        needful: true),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'signup_8'.tr,
                        hintText: 'signup_9'.tr,
                        textEditingController: logic.usernameNameController,
                        needful: true),
                    Container(
                      margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: CustomTDropDownPlusWidget(
                          models: logic.countreisString,
                          context: context,
                          textEditingController: logic.languageController,
                      
                          titleText: 'signup_10_1'.tr,
                          hintText: 'signup_10_1'.tr,
                          needful: false),
                    ),
                    SizedBox(height: 1.5.h,),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('signup_10'.tr, style: textTheme.bodySmall,),
                          SizedBox(width: 1.w,),
                          InkWell(
                            onTap: () {
                              Get.toNamed(PageRoutes.LOGIN);
                            },
                            child: Text(
                              'signup_11'.tr, style: textTheme.bodySmall!.copyWith(
                                color: AppColor.primaryLightColor
                            ),),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.5.h,),


                    Obx(() {
                      return CustomRegisterButtonWidget(title: 'signup_12'.tr,
                          onTap: () {
                            logic.signUpRequest();
                          },
                          color: AppColor.primaryLightColor,
                          isloading: logic.isloading.value);
                    }),

                    SizedBox(height: 3.5.h,),

                  ],
                ),
              ),
            );
          }),
    );
  }
}
