import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/widgets/appbar_btn.dart';
import 'package:mediaverse/app/pages/plus/widgets/plus_audio_recording.dart';
import 'package:mediaverse/app/pages/plus/widgets/plus_camera_screen.dart';
import 'package:mediaverse/app/pages/plus/widgets/plus_text_asset.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_route.dart';

class SelectDestinationBottomSheet extends StatefulWidget {
  const SelectDestinationBottomSheet({super.key});

  @override
  State<SelectDestinationBottomSheet> createState() => _SelectDestinationBottomSheetState();
}

class _SelectDestinationBottomSheetState extends State<SelectDestinationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 100.w,
        height: 35.h,
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),

        ),
        padding: EdgeInsets.all(16),
        child: Column(


          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("add_asset_24".tr),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close)),
              ],
            ),

            Container(
              width: 100.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: "17172e".toColor(),
                borderRadius: BorderRadius.circular(15)
              ),
              child: MaterialButton(
                onPressed: (){
                  Get.toNamed(PageRoutes.ADDCHANNEL,arguments: [false,null]);

                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: AppColor.primaryLightColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: SvgPicture.asset('assets/all/icons/bottom_nav_sub_1.svg'),
                        ),
                      ),
                      SizedBox(height: 1.h,),
                      Text("add_asset_25".tr,style: TextStyle(
                        color: Colors.white,fontSize: 8.sp
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: "17172e".toColor(),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: MaterialButton(
                    onPressed: (){

                      Get.to(()=>PlusCameraScreen(false),preventDuplicates: false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: AppColor.primaryLightColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/all/icons/bottom_nav_sub_2.svg'),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Text("add_asset_26".tr,style: TextStyle(
                            color: Colors.white,fontSize: 8.sp
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: "17172e".toColor(),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: MaterialButton(
                    onPressed: (){

                      Get.to(()=>PlusCameraScreen(true),preventDuplicates: false);

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: AppColor.primaryLightColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/all/icons/bottom_nav_sub_3.svg'),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Text("add_asset_27".tr,style: TextStyle(
                            color: Colors.white,fontSize: 8.sp
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: "17172e".toColor(),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: MaterialButton(
                    onPressed: (){

                      Get.to(()=>PlusAudioRecordingPage(),preventDuplicates: false);

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: AppColor.primaryLightColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/all/icons/bottom_nav_sub_4.svg'),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Text("add_asset_28".tr,style: TextStyle(
                            color: Colors.white,fontSize: 8.sp
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: "17172e".toColor(),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: MaterialButton(
                    onPressed: (){

                      Get.to(()=>PlusTextGenrationPage(),preventDuplicates: false);

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: AppColor.primaryLightColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: SvgPicture.asset('assets/all/icons/bottom_nav_sub_5.svg'),
                            ),
                          ),
                          SizedBox(height: 1.h,),
                          Text("add_asset_29".tr,style: TextStyle(
                            color: Colors.white,fontSize: 8.sp
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
