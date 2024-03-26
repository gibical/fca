import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/logic.dart';
import 'package:mediaverse/app/pages/login/widgets/country_code_widget.dart';
import 'package:mediaverse/app/pages/otp/widgets/code_otp_widget.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../widgets/logo_app_widget.dart';
import '../login/widgets/custom_register_button_widget.dart';
import '../login/widgets/custom_text_field.dart';

class OTPScreen extends StatelessWidget {

  LoginController logic = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return GetBuilder<LoginController>(
        init: logic,
        builder: (logic) {
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
            Text('We send the code to ${logic.code.dialCode}${logic.eTextEditingControllerPhone.text}'),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(prefix: CodeOTPWidget(context),
              hintText: 'Insert your OTP code',
              context: context,

              editingController: logic.eTextEditingControllerOTP,),


            SizedBox(
              height: 1.8.h,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28, left: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (logic.timeLeft.value > 0) {

                      } else {
                        logic.requestLogin();
                      }
                    },
                    child: Obx(() {
                      if (logic.timeLeft.value > 0) {
                        return Text(
                            "OTP expires in: ${logic.timeLeft.value} seconds",
                            style: textTheme.bodyMedium?.copyWith(
                                color: AppColor.primaryLightColor
                            ));
                      } else {
                        return Text(
                            "Send again", style: textTheme.bodyMedium?.copyWith(
                            color: AppColor.primaryLightColor
                        ));
                      }
                    }),
                  )
                  ,
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text('Wrong number?',
                        style: textTheme.bodyMedium
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Obx(() {
              return CustomRegisterButtonWidget(onTap: () {
                logic.getOTPSumbit();
              },
                  title: 'Log in',
                  isloading: logic.isloading.value);
            }),
            SizedBox(
              height: 2.5.h,
            ),
          ],
        ),
      );
    });
  }
}
