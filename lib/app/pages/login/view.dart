import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/country_code_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_register_button_widget.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/app/widgets/logo_app_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
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
          CustomTextFieldLogin(prefix: CountryCodeWidget(context), hintText: '700555123' , context: context),
          SizedBox(
            height: 3.h,
          ),

            Spacer(),
          GestureDetector(
            //go to login screen
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
          SizedBox(
            height: 2.5.h,
          ),
          CustomRegisterButtonWidget(onTap: (){}, title: 'send code'),
          SizedBox(
            height: 3.h,
          ),

        ],
      ),
    );
  }
}
