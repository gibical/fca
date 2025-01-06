import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/auth/widgets/login_button_widget.dart';
import 'package:sizer/sizer.dart';

import 'logic.dart';
import 'state.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final AuthLogic logic = Get.put(AuthLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            Text(
              "${"auth_1".tr}${F.title}!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "${"auth_2".tr}${F.title}!",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 9.sp,
                  color: '#9C9CB8'.toColor()),
            ),
            SizedBox(
              height: 4.h,
            ),
            LoginButtonWidget(
              backgroundColor: "2563EB".toColor(),
              placeHolder: Text(
                "${"auth_3".tr}${F.title}",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 9.sp),
              ),
              isloading: logic.state.isloadingOAuth,
              onpressed: () {

                logic.initiateLogin(context);
              },
            ),
            SizedBox(
              height: 2.h,),
            Container(
              width: 100.w,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: "#0F0F26".toColor(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      "auth_4".tr,
                      style: TextStyle(color: "#9C9CB8".toColor()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: "#0F0F26".toColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(
              height: 2.h,
            ),
            LoginButtonWidget(
              backgroundColor: "0F0F26".toColor(),
              placeHolder: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/mediaverse/icons/auth_1.png"),
                  SizedBox(width: 2.w,),
                  Text(
                    "${"auth_5".tr}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500, fontSize: 12.sp),
                  ),
                ],
              ),
              isloading: logic.state.isloadingGoogle,
              onpressed: () {

                logic.signInWithGoogle();
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            LoginButtonWidget(
              backgroundColor: "0F0F26".toColor(),
              placeHolder: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/mediaverse/icons/auth_2.png",height: 3.h,width: 3.h,),
                  SizedBox(width: 2.w,),
                  Text(
                    "${"auth_12".tr}",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500, fontSize: 12.sp),
                  ),
                ],
              ),
              isloading: logic.state.isloadingX,
              onFocusGained: (){
                logic.getTwitterAccessToken();
              },
              onpressed: () {

                logic.getTwitterLogin();
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'auth_8'.tr,
                style:  TextStyle(
                  color: "83839C".toColor(),
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text:  " ${'auth_9'.tr} ",
                    style:  TextStyle(
                      color: "2563EB".toColor(),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {

                        print('Terms of Service clicked');
                      },
                  ),
                   TextSpan(
                    text: " ${'auth_10'.tr} ",
                  ),
                  TextSpan(
                    text: 'auth_11'.tr,
                    style:  TextStyle(
                      color:  "2563EB".toColor(),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {

                        print('Privacy Policy clicked');
                      },
                  ),
                ],
              ),)


          ],
        ),
      )),
    );
  }
}
