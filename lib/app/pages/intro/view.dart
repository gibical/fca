import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../widgets/logo_app_widget.dart';
import '../login/widgets/custom_register_button_widget.dart';
import 'logic.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(IntroLogic());
    final state = Get.find<IntroLogic>().state;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset("assets/images/introBG.png"),
            ),
            Container(
              width: 100.w
              ,
              child: Column(

                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  LogoAppWidget(),
                  Spacer(),
                  CustomRegisterButtonWidgetBlue(onTap: () {
                    Get.offNamed(PageRoutes.LOGIN);
                  },
                      title: 'intro_3'.tr,
                      isloading:false),
                  SizedBox(height: 3.h,),
                  CustomRegisterButtonWidget(onTap: () {
                    Get.offNamed(PageRoutes.LOGIN);

                  },
                      title: 'intro_4'.tr,
                      isloading:false),
                  SizedBox(height: 1.h,),
                  GestureDetector(
                    //go to login screen
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'intro_1'.tr,
                          style: Theme
                              .of(context)
                              .textTheme.bodySmall,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          'intro_2'.tr,
                          style: Theme
                              .of(context)
                              .textTheme.bodySmall!
                              .copyWith(color: AppColor.primaryLightColor),
                        ),
                        SizedBox(height: 4.h,)
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
