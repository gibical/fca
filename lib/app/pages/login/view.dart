import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/logic.dart';
import 'package:mediaverse/app/pages/login/widgets/country_code_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_register_button_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/app/widgets/logo_app_widget.dart';
import 'package:mediaverse/gen/model/enums/login_enum.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginController logic = Get.put(LoginController());

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
            body: SingleChildScrollView(
              child: Container(
                width: 100.w
                ,
                child: Column(

                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    LogoAppWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (Widget child,
                            Animation<double> animation) {
                          final inAnimation =
                          Tween<Offset>(
                              begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation);
                          final outAnimation =
                          Tween<Offset>(
                              begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation);

                          if (child.key == ValueKey("elapsed")) {
                            return ClipRect(
                              child: SlideTransition(
                                position: inAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: child,
                                ),
                              ),
                            );
                          } else {
                            return ClipRect(
                              child: SlideTransition(
                                position: outAnimation,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: child,
                                ),
                              ),
                            );
                          }
                        },
                        child: _getMainWidgetByState(context)),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      //go to login screen
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'login_18'.tr,
                            style: textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            'login_18'.tr,
                            style: textTheme.bodySmall!
                                .copyWith(color: AppColor.primaryLightColor),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() {
                      return CustomRegisterButtonWidget(onTap: () {
                        logic.requestLogin();
                      },
                          title: 'login_9'.tr,
                          isloading: logic.isloading.value);
                    }),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _getMainWidgetByState(context) {
    switch (logic.loginEnum) {
      case LoginEnum.phone:
      // TODO: Handle this case.
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('login_1'.tr,
                style: FontStyleApp.bodyMedium
                    .copyWith(color: AppColor.whiteColor)),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: CountryCodeWidget(context),
                hintText: 'login_2'.tr,
                editingController: logic.eTextEditingControllerPhone,
                context: context),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "login_4".tr,
                      style:
                      TextStyle(color: "747491".toColor(), fontSize: 11.sp),
                    ),
                    Container(
                      height: 28,
                      width: 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      color: AppColor.whiteColor.withOpacity(0.2),
                    ),
                  ],
                ),
                hintText: 'login_3'.tr,
                editingController: logic.eTextEditingControllerPassword,
                context: context),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
                onTap: () {
                  logic.loginEnum = LoginEnum.username;
                  logic.update();
                },
                child: Text(
                  "login_5".tr,
                  style: TextStyle(color: "#83839C".toColor(), fontSize: 8.sp),
                )),
            SizedBox(
              height: 2.h,
            ),
          InkWell(
                onTap: () {
                  logic.loginEnum = LoginEnum.SMS;
                  logic.update();
                },
                child: Text(
                  "login_20".tr,
                  style: TextStyle(color: "#83839C".toColor(), fontSize: 8.sp),
                )),
            SizedBox(
              height: 2.h,
            ),

          ],
        );
      case LoginEnum.username:
      // TODO: Handle this case.
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('login_1'.tr,
                style: FontStyleApp.bodyMedium
                    .copyWith(color: AppColor.whiteColor)),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "login_15".tr,
                      style:
                      TextStyle(color: "747491".toColor(), fontSize: 8.sp),
                    ),
                    Container(
                      height: 28,
                      width: 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      color: AppColor.whiteColor.withOpacity(0.2),
                    ),
                  ],
                ),
                hintText: 'login_16'.tr,
                editingController: logic.eTextEditingControllerUsername,
                context: context),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "login_4".tr,
                      style:
                      TextStyle(color: "747491".toColor(), fontSize: 11.sp),
                    ),
                    Container(
                      height: 28,
                      width: 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      color: AppColor.whiteColor.withOpacity(0.2),
                    ),
                  ],
                ),
                hintText: 'login_3'.tr,
                editingController: logic.eTextEditingControllerPassword,
                context: context),
            SizedBox(
              height: 3.h,
            ),

            InkWell(
                onTap: () {
                  logic.loginEnum = LoginEnum.phone;
                  logic.update();
                },
                child: Text(
                  "login_17".tr,
                  style: TextStyle(color: "#83839C".toColor(), fontSize: 8.sp),
                )),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
                onTap: () {
                  logic.loginEnum = LoginEnum.SMS;
                  logic.update();
                },
                child: Text(
                  "login_20".tr,
                  style: TextStyle(color: "#83839C".toColor(), fontSize: 8.sp),
                )),


          ],
        );

      case LoginEnum.SMS:
        // TODO: Handle this case.
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('login_1'.tr,
                style: FontStyleApp.bodyMedium
                    .copyWith(color: AppColor.whiteColor)),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: CountryCodeWidget(context),
                hintText: 'login_2'.tr,
                editingController: logic.eTextEditingControllerPhone,
                context: context),

            SizedBox(
              height: 3.h,
            ),
            InkWell(
                onTap: () {
                  logic.loginEnum = LoginEnum.username;
                  logic.update();
                },
                child: Text(
                  "login_5".tr,
                  style: TextStyle(color: "#83839C".toColor(), fontSize: 8.sp),
                )),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
                onTap: () {
                  logic.loginEnum = LoginEnum.phone;
                  logic.update();
                },
                child: Text(
                  "login_17".tr,
                  style: TextStyle(color: "#83839C".toColor(), fontSize: 8.sp),
                )),
            SizedBox(
              height: 2.h,
            ),

          ],
        );

    }
  }
}
