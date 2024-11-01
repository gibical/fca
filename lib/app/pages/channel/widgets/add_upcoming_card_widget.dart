import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:sizer/sizer.dart';

import '../../share_account/logic.dart';

class AddUpcomingCardWidget extends StatefulWidget {
  const AddUpcomingCardWidget({super.key});

  @override
  State<AddUpcomingCardWidget> createState() => _AddUpcomingCardWidgetState();
}

class _AddUpcomingCardWidgetState extends State<AddUpcomingCardWidget> {
  final _logic = Get.find<ShareAccountLogic>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
            side: BorderSide(color: Colors.white.withOpacity(0.4), width: 0.7)),
        height: 6.h,
        minWidth: double.infinity,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
              backgroundColor: Colors.black54,
              enableDrag: false,
              onClosing: () {},
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("channel_6".tr),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child:  Text(
                                "channel_7".tr,
                                style: TextStyle(
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 6.h,
                        width: 85.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 1.w,
                            ),
                             Text(
                              "channel_8".tr,
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Container(
                              height: 28,
                              width: 1.5,
                              color: AppColor.whiteColor.withOpacity(0.2),
                            ),
                             Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "channel_9".tr,
                                  hintStyle: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          _logic.changeType.value = !_logic.changeType.value;
                        },
                        child: Container(
                          height: 6.h,
                          width: 85.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black54),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 1.w,
                              ),
                               Text(
                                "channel_10".tr,
                                style: TextStyle(color: Colors.white54),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Container(
                                height: 28,
                                width: 1.5,
                                color: AppColor.whiteColor.withOpacity(0.2),
                              ),
                              Obx(
                                () => Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Row(
                                      children: [
                                        Text(_logic.typeString.value),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(() {
                        if (_logic.changeType.value) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: .5.h),
                                  child: SizedBox(
                                    height: 6.h,
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onTap: () {
                                        _logic.typeString.value = "Google";
                                        _logic.changeType.value = false;
                                      },
                                      tileColor: Colors.black54,
                                      title:  Text("channel_11".tr),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: .5.h),
                                  child: SizedBox(
                                    height: 6.h,
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onTap: () {
                                        _logic.typeString.value = "Twitter";
                                        _logic.changeType.value = false;
                                      },
                                      tileColor: Colors.black54,
                                      title:  Text("channel_12".tr),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: .5.h),
                                  child: SizedBox(
                                    height: 6.h,
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onTap: () {
                                        _logic.typeString.value = "Facebook";
                                        _logic.changeType.value = false;
                                      },
                                      tileColor: Colors.black54,
                                      title:  Text("channel_13".tr),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: .5.h),
                                  child: SizedBox(
                                    height: 6.h,
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onTap: () {
                                        _logic.typeString.value = "Steam";
                                        _logic.changeType.value = false;
                                      },
                                      tileColor: Colors.black54,
                                      title:  Text("channel_14".tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 1.h,
                          );
                        }
                      }),
                      Obx(() {
                        if (_logic.typeString.value == "Steam") {
                          return Column(
                            children: [
                              SizedBox(
                                height: .5.h,
                              ),
                              Container(
                                height: 6.h,
                                width: 85.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black54),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                     Text(
                                      "channel_15".tr,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Container(
                                      height: 28,
                                      width: 1.5,
                                      color:
                                          AppColor.whiteColor.withOpacity(0.2),
                                    ),
                                     Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: "channel_16".tr,
                                          hintStyle: TextStyle(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: .5.h,
                              ),
                              Container(
                                height: 6.h,
                                width: 85.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black54),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                     Text(
                                      "channel_17".tr,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Container(
                                      height: 28,
                                      width: 1.5,
                                      color:
                                          AppColor.whiteColor.withOpacity(0.2),
                                    ),
                                     Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: "channel_18".tr,
                                          hintStyle: TextStyle(
                                            color: Colors.white60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: .5.h,
                              ),
                            ],
                          );
                        } else {
                          return SizedBox(
                            height: 1.h,
                          );
                        }
                      }),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 7.w,
                          right: 7.w,
                          bottom: 5.h,
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 5.h,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          onPressed: () async {
                            if (_logic.typeString.value == "Google") {
                              GoogleSignIn _googleSignIn = GoogleSignIn(
                              clientId: "56751096814-kqu8g4r487t8g4gm47d4png65i87u179.apps.googleusercontent.com"
                              );

                              try {
                                await _googleSignIn.signIn();
                              } catch (error, stackTrace) {
                                print("Error signing in with Google: $error");
                                print(stackTrace);
                              }
                            }
                          },
                          color: Colors.black54,
                          child:  Text("channel_19".tr),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'channel_20'.tr,
              style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.grayLightColor.withOpacity(0.5),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Icon(Icons.add,
                color: AppColor.grayLightColor.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}
