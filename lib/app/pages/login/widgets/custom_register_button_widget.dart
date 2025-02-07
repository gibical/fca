import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';


Widget CustomRegisterButtonWidget({required String title  , required Function() onTap , color,required bool isloading}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child:isloading?Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json"): Text(
          title,
          style: FontStyleApp.bodyLarge.copyWith(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w300,
          )
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp)
            ),
            backgroundColor: color != null ? color : Color(0xff4E4E61).withOpacity(0.5)

        ),
      ),
    ),
  );
}
Widget CustomRegisterButtonWidgetBlue({required String title  , required Function() onTap , color,required bool isloading}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child:isloading?Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json"): Text(
          title,
          style: FontStyleApp.bodyLarge.copyWith(
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w300,
          )
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp)
            ),
            backgroundColor: color != null ? color : AppColor.primaryLightColor

        ),
      ),
    ),
  );
}
Widget GoogleCustomRegisterButtonWidget({required String title  , required Function() onTap , color,required bool isloading}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child:isloading?Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json"): Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/${F.assetTitle}/images/googlesignin.png",height: 2.4.h,),
            SizedBox(width: 3.w,),
            Text(
                title,
                style: FontStyleApp.bodyLarge.copyWith(
                  color: AppColor.primaryDarkColor,
                  fontWeight: FontWeight.w500,
                )
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp)
            ),
            backgroundColor:Colors.white

        ),
      ),
    ),
  );
}
Widget TwitterCustomRegisterButtonWidget({required String title  , required Function() onTap , color,required bool isloading}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child:isloading?Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json"): Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset("assets/${F.assetTitle}/images/twitter.png",height: 2.4.h,),
            SizedBox(width: 3.w,),
            Text(
                title,
                style: FontStyleApp.bodyLarge.copyWith(
                  color: AppColor.primaryDarkColor,
                  fontWeight: FontWeight.w500,
                )
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp)
            ),
            backgroundColor:AppColor.primaryLightColor

        ),
      ),
    ),
  );
}
Widget LoginCustomRegisterButtonWidget({required String title  , required Function() onTap , color,required bool isloading}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25 , right: 25),
    child: SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child:isloading?Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json"): Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
                title,
                style: FontStyleApp.bodyLarge.copyWith(
                  color: AppColor.primaryDarkColor,
                  fontWeight: FontWeight.w500,
                )
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.sp)
            ),
            backgroundColor:AppColor.primaryLightColor

        ),
      ),
    ),
  );
}
