import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/add_channel/logic.dart';
import 'package:mediaverse/app/pages/channel/v2/widgets/channels_title_widget.dart';
import 'package:sizer/sizer.dart';

class AddChannelsPage extends StatelessWidget {


  AddChannelController logic = Get.put(AddChannelController(Get.arguments[0],model: Get.arguments[1]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: Container(
            width: 100.w,
            child: Column(
              children: [
                ChannelsTitleWidget("add_channel_1".tr),
                Container(
                  width: 50.w,
                  height: 50.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Obx(() {
                          return Visibility(
                            visible: (!logic.isLoadingUploadFile.value&&!( (Get.arguments[0])&&(logic.model!.thumbnails.toString().length>20))),
                            child: SizedBox.expand(
                              child: logic.isShowImageFromPath.value
                                  ? Image.file(
                                File(logic.filePath ?? ""),
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                  "assets/all/images/tumnial.png"), //
                            ),
                          );
                        }),
                  if(( (Get.arguments[0])&&(logic.model!.thumbnails.toString().length>20)))SizedBox.expand(
                    child:  Image.network(
                       logic.model!.thumbnails['226x226']), //
                  ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 27.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                                color: "0f0f26".toColor(),
                                borderRadius: BorderRadius.circular(500)),
                            margin: EdgeInsets.all(2.w),
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                logic.pickAndUploadFile();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      "assets/all/icons/add_channel_1.svg"),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "add_channel_2".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 7.5.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Visibility(
                            visible: logic.isLoadingUploadFile.value,
                            child: Align(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Text("add_channel_12".tr)
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.h),
                  width: 100.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                      color: "0f0f26".toColor(),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: logic.nameEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                      hintText: "add_channel_3".tr,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.h),
                  width: 100.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                      color: "0f0f26".toColor(),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: logic.desEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                      hintText: "add_channel_4".tr,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: GetBuilder<AddChannelController>(
                            init: logic,
                            builder: (logic) {
                              return Container(
                                  width: 100.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      color: "0f0f26".toColor(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MaterialButton(
                                    onPressed: () {
                                      logic.pickCountry();
                                    },
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: Row(
                                      children: [
                                        if (logic.selectedCountryModel == null)
                                          SvgPicture.asset(
                                              "assets/all/icons/add_channel_2.svg"),
                                        if (logic.selectedCountryModel != null)
                                          Container(
                                            child: CountryFlag.fromCountryCode(
                                              logic.selectedCountryModel!.iso
                                                  .toString(),
                                              width: 30,
                                              height: 15,
                                            ),
                                          ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        if (logic.selectedCountryModel == null)
                                          Text(
                                            "add_channel_5".tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.sp,
                                                color: "9c9cb8".toColor()),
                                          ),
                                        if (logic.selectedCountryModel != null)
                                          Expanded(
                                            child: Text(
                                              logic.selectedCountryModel!.name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 9.sp,
                                                  color: "9c9cb8".toColor()),
                                              maxLines: 2,
                                            ),
                                          ),
                                        Spacer(),
                                        SvgPicture.asset(
                                            "assets/all/icons/add_channel_3.svg"),
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: GetBuilder<AddChannelController>(
                            init: logic,
                            builder: (logic) {
                              return Container(
                                  width: 100.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                      color: "0f0f26".toColor(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MaterialButton(
                                    onPressed: () {
                                      logic.pickLanguage();
                                    },
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: Row(
                                      children: [
                                        if (logic.languageModel == null) Text(
                                          "add_channel_6".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.sp,
                                              color: "9c9cb8".toColor()),
                                        ),
                                        if (logic.languageModel != null) Text(
                                          Constant.reversedLanguageMap[logic
                                              .languageModel],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.sp,
                                              color: "9c9cb8".toColor()),
                                        ),
                                        Spacer(),
                                        SvgPicture.asset(
                                            "assets/all/icons/add_channel_3.svg"),
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.h),
                  child: Container(
                      width: 100.w,
                      height: 3.h,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                            "add_channel_7".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: "9c9cb8".toColor()),
                          ),
                          Spacer(),
                          Transform.scale(
                            scale: 0.7,
                            child: Obx(() {
                              return Switch(
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: "9c9cb8".toColor(),
                                  value: logic.isPriaveContant.value,
                                  onChanged: (s) {
                                    logic.isPriaveContant.value = s;
                                  });
                            }),
                          )
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.h),
                  child: Container(
                      width: 100.w,
                      height: 3.h,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                            "add_channel_8".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: "9c9cb8".toColor()),
                          ),
                          Spacer(),
                          Transform.scale(
                            scale: 0.7,
                            child: Obx(() {
                              return Switch(
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: "9c9cb8".toColor(),
                                  value: logic.isRecordable.value,
                                  onChanged: (s) {
                                    logic.isRecordable.value = s;
                                  });
                            }),
                          )
                        ],
                      )),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(16),
                  height: 6.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: AppColor.primaryLightColor
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),

                    ), onPressed: () {
                    logic.saveChannels();
                  },

                    child: Obx(() {
                      return Center(
                        child: logic.isLoading.value ? Lottie.asset(
                            "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                            height: 5.h) : Text("add_channel_9".tr),
                      );
                    }),
                  ),
                )

              ],
            ),
          )),
    );
  }
}
