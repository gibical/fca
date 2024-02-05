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
                    Text('Insert your data for beter service'),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'First Name',
                        hintText: 'Insert your First name',
                        textEditingController: logic.firstNameController,

                        needful: true),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'Last Name',
                        hintText: 'Insert your Last Name',
                        textEditingController: logic.lastNameController,
                        needful: true),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'Password',
                        hintText: 'Insert your password',
                        textEditingController: logic.passwordNameController,
                        needful: true),
                    CustomTextFieldRegisterWidget(
                        context: context,
                        titleText: 'Username',
                        hintText: 'Insert your username',
                        textEditingController: logic.usernameNameController,
                        needful: true),

                    SizedBox(height: 1.5.h,),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Have an account?', style: textTheme.bodySmall,),
                          SizedBox(width: 1.w,),
                          InkWell(
                            onTap: () {
                              Get.toNamed(PageRoutes.LOGIN);
                            },
                            child: Text(
                              'Log in', style: textTheme.bodySmall!.copyWith(
                                color: AppColor.primaryLightColor
                            ),),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.5.h,),

                    Obx(() {
                      return CustomRegisterButtonWidget(title: 'Save',
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
