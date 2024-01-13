

import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_register_button_widget.dart';
import 'package:mediaverse/app/pages/signup/widgets/custom_text_field_form_register_widget.dart';
import 'package:mediaverse/app/widgets/logo_app_widget.dart';
import 'package:sizer/sizer.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
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
                  titleText: 'Full Name',
                  hintText: 'Insert your full name',
                  needful: true),
              CustomTextFieldRegisterWidget(
                  titleText: 'Email',
                  hintText: 'Insert your email',
                  needful: true),
              CustomTextFieldRegisterWidget(
                  titleText: 'Password',
                  hintText: 'Insert your password',
                  needful: true),
              CustomTextFieldRegisterWidget(
                  titleText: 'Repeat Password',
                  hintText: 'Repeat your password',
                  needful: true),
              CustomTextFieldRegisterWidget(
                  titleText: 'City',
                  hintText: 'Insert your city',
                  needful: false),
              CustomTextFieldRegisterWidget(
                  titleText: 'Adress',
                  hintText: 'Insert your adress',
                  needful: false),
              SizedBox(height: 2.h,),

              CustomRegisterButtonWidget(title: 'Save', onTap: (){}),
              SizedBox(height: 3.5.h,),
              Text('Skip' , style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.whiteColor
              )),
              SizedBox(height: 8.5.h,),
            ],
          ),
        ),
      ),
    );
  }
}
