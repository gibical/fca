import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../login/widgets/custom_text_field.dart';
import '../otp/widgets/code_otp_widget.dart';
import '../signup/widgets/custom_text_field_form_register_widget.dart';
import 'logic.dart';

class ChangePasswordPage extends StatelessWidget {
  final logic = Get.put(ChangePasswordLogic());
  final state = Get
      .find<ChangePasswordLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,

      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
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
                        Text("Account", style: TextStyle(color: Colors.white),),
                        Container(
                          width: 16.w,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),

                  CustomTextFieldRegisterWidget(
                      context: context,
                      textEditingController: logic.passwordController,

                      titleText: 'Password',showCursor: true,
                      hintText: 'Insert password',
                      needful: false),
                  CustomTextFieldRegisterWidget(
                      context: context,
                      textEditingController: logic.repeatPasswordController,

                      titleText: 'Repeat Password',showCursor: true,
                      hintText: 'Insert password',
                      needful: false),

                  Obx(() {
                    return Visibility(
                      visible: logic.isShowCode.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 6.h,),
                          Text('We send the code to Phone'),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomTextFieldLogin(prefix: CodeOTPWidget(context),
                            hintText: 'Insert your OTP code',
                            context: context,

                            editingController: logic.eTextEditingControllerOTP,
                          ),

                        ],
                      ),
                    );
                  })
                ],
              ),
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
                        logic.changePassword();
                      },
                      child: logic.isloading.value ? Lottie.asset(
                          "assets/json/Y8IBRQ38bK.json", height: 10.h) : Text(
                        "Save", style: TextStyle(color: Colors.white),),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
