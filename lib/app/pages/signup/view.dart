

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
    final textTheme = Theme.of(context).textTheme;
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
                titleText: 'Full Name',
                hintText: 'Insert your full name',
                needful: true),
            CustomTextFieldRegisterWidget(
                context: context,
                titleText: 'Email',
                hintText: 'Insert your email',
                needful: true),
            CustomTextFieldRegisterWidget(
                context: context,
                titleText: 'Password',
                hintText: 'Insert your password',
                needful: true),
            CustomTextFieldRegisterWidget(
                context: context,
                titleText: 'Repeat Password',
                hintText: 'Repeat your password',
                needful: true),
            CustomTextFieldRegisterWidget(
                context: context,
                titleText: 'City',
                hintText: 'Insert your city',
                needful: false),
            CustomTextFieldRegisterWidget(
                context: context,
                titleText: 'Adress',
                hintText: 'Insert your adress',
                needful: false),
            SizedBox(height: 1.5.h,),
            GestureDetector(
              onTap: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?' , style: textTheme.bodySmall,),
                  SizedBox(width: 1.w,),
                  Text('Log in' , style: textTheme.bodySmall!.copyWith(
                      color: AppColor.primaryLightColor
                  ),)
                ],
              ),
            ),
            SizedBox(height: 1.5.h,),

            CustomRegisterButtonWidget(title: 'Save', onTap: (){} ,color: AppColor.primaryLightColor, isloading: false),

            SizedBox(height: 3.5.h,),

          ],
        ),
      ),
    );
  }
}
