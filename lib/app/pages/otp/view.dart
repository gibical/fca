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

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          LogoAppWidget(),
          SizedBox(
            height: 7.h,
          ),
          Text('We send the code to +33700555123'),
          SizedBox(
            height: 3.h,
          ),
          CustomTextFieldLogin(prefix: CodeOTPWidget(context), hintText: 'Insert your OTP code' , context: context),


          SizedBox(
            height: 1.8.h,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 28 , left: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Send again' ,
                    style: textTheme.bodyMedium?.copyWith(
                        color: AppColor.primaryLightColor
                    )
                ),
                Text('Wrong number?' ,
                    style: textTheme.bodyMedium
                )
              ],
            ),
          ),
           Spacer(),
          CustomRegisterButtonWidget(onTap: (){}, title: 'Log in'),
          SizedBox(
            height: 2.5.h,
          ),
        ],
      ),
    );
  }
}
