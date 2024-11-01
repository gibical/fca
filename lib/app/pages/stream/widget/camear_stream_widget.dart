import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/stream/widget/camera_stream.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/font_style.dart';
import '../../wrapper/logic.dart';
import '../logic.dart';

class CameraStreamWidget extends StatefulWidget {
  const CameraStreamWidget({super.key});

  @override
  State<CameraStreamWidget> createState() => _CameraStreamWidgetState();
}

class _CameraStreamWidgetState extends State<CameraStreamWidget> {
  final _logic = Get.find<WrapperController>().streamViewController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamViewController>(
        init: _logic,
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
         Check Your Lighting: Ensure your face is well-lit to improve video quality.
         
         Position the Camera: Keep the camera at eye level for a natural view.
         
         Stable Internet Connection: A strong connection ensures smooth streaming.
         
         Privacy Check: Double-check your surroundings for any personal items that shouldn't be visible.
         
         Camera Permissions: Ensure the app has the necessary camera permissions.""",
                  textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp),),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: InkWell(
                  onTap: () {
                    Get.to(CameraExampleHome());
                  },
                  child: Container(

                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 23.w),
                      height: 7.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/${F.assetTitle}/icons/camera.svg", height: 16,
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
