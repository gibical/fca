import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/country_code_widget.dart';
import 'package:mediaverse/app/pages/otp/widgets/code_otp_widget.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../widgets/logo_app_widget.dart';
import '../login/widgets/custom_register_button_widget.dart';
import '../login/widgets/custom_text_field.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

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
            Text('We send the code to +33700555123'),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(prefix: CodeOTPWidget(), hintText: 'Insert your OTP code'),


            SizedBox(
              height: 1.8.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28 , left: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Send again' ,
                    style: FontStyleApp.bodyLarge.copyWith(
                      color: AppColor.primaryLightColor,
                      decoration: TextDecoration.underline,
                    )
                  ),
                  Text('Wrong number?' ,
                    style: FontStyleApp.bodyLarge.copyWith(
                      color: AppColor.whiteColor,
                      decoration: TextDecoration.underline,
                    )
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomRegisterButtonWidget(onTap: (){}, title: 'Log in'),
           SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
