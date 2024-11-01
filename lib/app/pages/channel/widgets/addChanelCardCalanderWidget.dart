import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/login/widgets/custom_text_field.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetAllAsstes.dart';
import 'package:sizer/sizer.dart';

import '../../share_account/logic.dart';

class AddChannelCalanderCardWidget extends StatefulWidget {
  const AddChannelCalanderCardWidget({super.key});

  @override
  State<AddChannelCalanderCardWidget> createState() =>
      _AddChannelCardWidgetState();
}

class _AddChannelCardWidgetState extends State<AddChannelCalanderCardWidget> {
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
                return Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text("channel_21".tr),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child:  Text(
                              "channel_22".tr,
                              style: TextStyle(
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 7.w),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.4),
                                width: 0.7)),
                        height: 6.h,
                        minWidth: double.infinity,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'channel_23'.tr,
                              style: FontStyleApp.bodyMedium.copyWith(
                                color:
                                    AppColor.grayLightColor.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(Icons.add,
                                color:
                                    AppColor.grayLightColor.withOpacity(0.5),
                                size: 20),
                          ],
                        ),
                      ),
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
                            "channel_24".tr,
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
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child:  Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "channel_25".tr,
                                  style: TextStyle(color: Colors.white54),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white54,
                                ),
                              ],
                            ),
                          )),
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
                              "channel_26".tr,
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
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 2.w),
                                child:  Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "channel_25".tr,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white54,
                                    ),
                                  ],
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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: TextField(
                          minLines: 3,
                          maxLines: 3,
                          decoration: InputDecoration(
                            fillColor: AppColor.whiteColor.withOpacity(0.2),
                            filled: true,
                            hintText: "channel_27".tr,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        onPressed: () {},
                        color: Colors.black54,
                        child:  Text("channel_28".tr),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'channel_29'.tr,
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
