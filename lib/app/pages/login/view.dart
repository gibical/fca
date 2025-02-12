import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/OAuthService.dart';
import 'package:mediaverse/app/pages/login/logic.dart';
import 'package:mediaverse/app/pages/login/widgets/country_code_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_register_button_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/app/widgets/logo_app_widget.dart';
import 'package:mediaverse/gen/model/enums/login_enum.dart';
import 'package:sizer/sizer.dart';

import '../signup/widgets/custom_text_field_form_register_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginController logic = Get.put(LoginController((Get.arguments as LoginEnum)));

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
                        child: _getMainWidgetByState(context)
                    ),
                    SizedBox(
                      height: 2.h,
                    ),

                    ///Deleted We Dont have a sign up form
                    // GestureDetector(
                    //   //go to login screen
                    //   onTap: () {},
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'login_18'.tr,
                    //         style: textTheme.bodySmall,
                    //       ),
                    //       SizedBox(
                    //         width: 1.w,
                    //       ),
                    //       Text(
                    //         'login_18'.tr,
                    //         style: textTheme.bodySmall!
                    //             .copyWith(color: AppColor.primaryLightColor),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() {
                      return CustomRegisterButtonWidget(onTap: () {
                        logic.requestLogin();
                        //signInWithGoogle();
                        //_googleLogIn();
                      },
                          title: 'login_9'.tr,
                          isloading: logic.isloading.value);
                    }),
                    SizedBox(
                      height: 3.h,
                    ),
                    if(F.appFlavor !=
                        Flavor.ravi) GoogleCustomRegisterButtonWidget(
                        onTap: () {
                          //  logic.requestLogin();
                          //signInWithGoogle();
                          _googleLogIn();
                        }, title: 'login_9_1'.tr, isloading: false),
                    SizedBox(height: 3.h,),
                    if(F.appFlavor != Flavor.ravi) Obx(() {
                      return FocusDetector(
                        onFocusGained: (){
                          logic.twiiterButtonVisiable();
                        },
                        child: TwitterCustomRegisterButtonWidget(onTap: () {
                          logic.getTwitterLogin();
                        }, title: 'login_9_2'.tr, isloading: logic
                            .isloadingTwitter.value),
                      );
                    }),
                    SizedBox(
                      height: 3.h,
                    ),
                    if(F.appFlavor != Flavor.ravi) Obx(() {
                      return FocusDetector(
                        onFocusGained: (){

                        },
                        child: LoginCustomRegisterButtonWidget(onTap: () {
                          logic.initiateLogin(context);
                        }, title: "${'login_9_3'.tr} ${F.title}", isloading: logic
                            .isloadingCustomLogin.value),
                      );
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
            Text('login_1_2'.tr,
                style: FontStyleApp.bodyMedium
                    .copyWith(color: AppColor.whiteColor)),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: CountryCodeWidget(context, logic),
                hintText: 'login_2'.tr,
                editingController: logic.eTextEditingControllerPhone,
                context: context),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldRegisterWidget(
              titleText: "login_4".tr,
              hintText: 'login_3'.tr,isPassword: true,
              textEditingController: logic.eTextEditingControllerPassword,
              context: context, needful: false,),

            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      logic.loginEnum = LoginEnum.username;
                      logic.update();
                    },
                    child: Text(
                      ("login_5".tr) + "    /     ",
                      style: TextStyle(
                          color: "#83839C".toColor(), fontSize: 10.sp),
                    )),
                InkWell(
                    onTap: () {
                      logic.loginEnum = LoginEnum.SMS;
                      logic.update();
                    },
                    child: Text(
                      "login_20".tr,
                      style: TextStyle(
                          color: "#83839C".toColor(), fontSize: 10.sp),
                    )),
              ],
            ),


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
            CustomTextFieldRegisterWidget(
                titleText: "login_15".tr,
                hintText: 'login_16'.tr,
                textEditingController: logic.eTextEditingControllerUsername,
                context: context, needful: true,),

            CustomTextFieldRegisterWidget(
                titleText: "login_4".tr,
                hintText: 'login_3'.tr,isPassword: true,
                textEditingController: logic.eTextEditingControllerPassword,
                context: context, needful: false,),
            SizedBox(
              height: 3.h,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      logic.loginEnum = LoginEnum.phone;
                      logic.update();
                    },
                    child: Text(
                      ("login_12".tr) + "    /     ",
                      style: TextStyle(
                          color: "#83839C".toColor(), fontSize: 10.sp),
                    )),
                InkWell(
                    onTap: () {
                      logic.loginEnum = LoginEnum.SMS;
                      logic.update();
                    },
                    child: Text(
                      "login_20".tr,
                      style: TextStyle(
                          color: "#83839C".toColor(), fontSize: 10.sp),
                    )),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),


          ],
        );

      case LoginEnum.SMS:
      // TODO: Handle this case.
        return Column(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('login_1_1'.tr,
                style: FontStyleApp.bodyMedium
                    .copyWith(color: AppColor.whiteColor)),
            SizedBox(
              height: 3.h,
            ),
            CustomTextFieldLogin(
                prefix: CountryCodeWidget(context, logic),
                hintText: 'login_2'.tr,
                editingController: logic.eTextEditingControllerPhone,
                context: context),

            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      logic.loginEnum = LoginEnum.username;
                      logic.update();
                    },
                    child: Text(
                      ("login_5".tr) + "    /     ",
                      style: TextStyle(
                          color: "#83839C".toColor(), fontSize: 10.sp),
                    )),
                InkWell(
                    onTap: () {
                      logic.loginEnum = LoginEnum.phone;
                      logic.update();
                    },
                    child: Text(
                      "login_12".tr.substring("login_12".tr.indexOf("p")),
                      style: TextStyle(
                          color: "#83839C".toColor(), fontSize: 10.sp),
                    )),
              ],
            ),


            SizedBox(
              height: 2.h,
            ),

          ],
        );
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(

      );
      final GoogleSignInAuthentication googleAuth = await googleUser!
          .authentication;

      String? token = googleAuth
          .accessToken; // Save the token to send to your backend

      print("Google ID Token: $token");
      logic.sendIDTokenToServer(token ?? "");
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  void _googleLogIn() async {
    signInWithGoogle();
   // oAuthFunction();
  }

}

class Authentication {
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(
            credential);

        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        print('Authentication.signInWithGoogle catch = ${e}');
        // Handle error
      }
    }
    return null;
  }
}