import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/check_box_cookies_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/country_code_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_register_button_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/app/widgets/logo_app_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.h,
            ),
            LogoAppWidget(),
            SizedBox(
              height: 10.h,
            ),
            Text('Insert your number for sending the code' , style: FontStyleApp.bodyMedium.copyWith(
              color: AppColor.whiteColor
            )),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(prefix: CountryCodeWidget(), hintText: '700555123'),
            SizedBox(
              height: 3.h,
            ),
            CheckBoxWidget(),
            SizedBox(
              height: 5.h,
            ),
            CustomRegisterButtonWidget(onTap: (){}, title: 'send code'),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
