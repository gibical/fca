import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/profile/view.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/profile/logic.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/font_style.dart';
import '../home/logic.dart';
import '../plus_section/widget/custom_plan_text_filed.dart';
import '../signup/widgets/custom_text_field_form_register_widget.dart';

class GeneralInformationPage extends StatefulWidget {

  @override
  State<GeneralInformationPage> createState() => _GeneralInformationPageState();
}

class _GeneralInformationPageState extends State<GeneralInformationPage> {
  ProfileControllers logic = Get.find<HomeLogic>().profileController;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      firstName = TextEditingController(text: logic.model.firstName ?? "");
      lastName = TextEditingController(text: logic.model.lastName ?? "");
      email = TextEditingController(text: logic.model.email ?? "");
      setState(() {

      });
    });
  }

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
                        Text("setting_1".tr, style: TextStyle(color: Colors.white),),
                        Container(
                          width: 16.w,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),

                  CustomTextFieldRegisterWidget(
                      context: context,
                      textEditingController: firstName,

                      titleText: 'setting_7'.tr,
                      hintText: 'setting_8'.tr,
                      needful: false),
                  CustomTextFieldRegisterWidget(
                      context: context,
                      textEditingController: lastName,

                      titleText: 'setting_9'.tr,
                      hintText: 'setting_10'.tr,
                      needful: false),
                  CustomTextFieldRegisterWidget(
                      context: context,
                      textEditingController: email,

                      titleText: 'setting_11'.tr,
                      hintText: 'setting_12'.tr,
                      needful: false),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: CustomTDropDownPlusWidget(
                        models: logic.countreisString,
                        context: context,
                        textEditingController: logic.languageController,

                        titleText: 'Countries'.tr,
                        hintText: 'Countries'.tr,
                        needful: false),
                  )
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
                        logic.sendEditRequest(
                          firstName.text,
                          lastName.text,
                          email.text,
                        );
                      },
                      child: logic.isloadingEdit.value ? Lottie.asset(
                          "assets/json/Y8IBRQ38bK.json", height: 10.h) : Text(
                        "setting_13".tr, style: TextStyle(color: Colors.white),),
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



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
