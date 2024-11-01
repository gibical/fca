import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/stream/widget/camera_stream.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/font_style.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';
import '../logic.dart';

class ScreenStreamWidget extends StatefulWidget {
  const ScreenStreamWidget({super.key});

  @override
  State<ScreenStreamWidget> createState() => _ScreenStreamWidgetState();
}

class _ScreenStreamWidgetState extends State<ScreenStreamWidget> {
  final _streamController = Get.find<StreamViewController>(tag: "main");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamViewController>(
        init: _streamController,
        tag: "main",

        builder: (logic) {
      return Scaffold(
        backgroundColor: AppColor.blueDarkColor,

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 6.h,),
              Container(
                margin: EdgeInsets.all(16),
                child: Text("Please attention this :", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.sp),),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text("""
         Close Unnecessary Tabs: Prevent distractions and protect your privacy by closing irrelevant tabs or apps.
         
         Disable Notifications: Turn off system notifications to avoid interruptions.
         
         Check Screen Resolution: Ensure your screen resolution is suitable for viewers.
         
         Choose the Right Screen: Select the correct window or app to share, especially if multiple monitors are connected.
         
         Privacy Awareness: Be cautious of any sensitive information visible on the screen.""",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp),),
              ),
              InkWell(
                onTap: (){
                  logic.goToChannelScreen();
                },
                child: IgnorePointer(
                  child: CustomTextFieldRegisterWidget(
                      context: Get.context!,
                      titleText: 'Program'.tr,
                      hintText: _streamController.programModel == null
                          ? "Insert Program Here"
                          : _streamController.programModel!.name.toString(),
                      textEditingController: TextEditingController(),
                      needful: true),
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: _streamController.isScreenRecordingTimeVisible.value,
                  child: Align(
                    alignment: Alignment.center,
                    child: SafeArea(
                      child: Container(
                        width: 20.w,
                        height: 4.h,

                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(400)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset("assets/${F.assetTitle}/images/record.svg"),
                            Text(
                              _streamController. screenRecordingTime.value,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),

              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: InkWell(
                  onTap: () {
                   if (!logic.isScreenRecordingTimeVisible.value) {
                     logic.startScreenStreaming();
                   }else{
                     logic.stopScreenStreaming();

                   }
                  },
                  child: Container(

                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 23.w),
                      height: 7.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/${F.assetTitle}/icons/iphone.svg", height: 16,
                              color: Colors.grey),
                          SizedBox(width: 2.w,),
                          Text(
                            'Start Stream'.tr,
                            style: FontStyleApp.bodyLarge.copyWith(
                                color: Colors.grey
                            ),),


                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          )
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
