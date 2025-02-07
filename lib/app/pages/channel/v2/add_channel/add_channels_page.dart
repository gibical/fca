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

import '../../../detail/widgets/custom_switch.dart';

class AddChannelsPage extends StatelessWidget {

  bool  isEdit =Get.arguments[0];


  @override
  Widget build(BuildContext context) {
    AddChannelController logic = Get.put(AddChannelController(isEdit,model: Get.arguments[1]));

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: Container(
            width: 100.w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ChannelsTitleWidget(isEdit?"add_channel_1_1".tr:"add_channel_1".tr),
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
                          child: fieldEditAssetWidget(
                            title: 'Country',
                            onTap: () {
                              _runCustomSelectBottomEditeAssetSheet(
                                title: 'Country',
                                models: logic.countreisString,
                                value: logic.countryEditingController,
                              );
                            },
                            value: logic.countryEditingController,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: fieldEditAssetWidget(
                            title: 'Language',
                            onTap: () {
                              _runCustomSelectBottomEditeAssetSheet(
                                title: 'Select a language',
                                models: Constant.reversedLanguageMap.values.toList(),
                                value: logic.languageEditingController,
                              );
                            },
                            value: logic.languageEditingController,
                          ),
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
                              scale: 1,
                              child: Obx(() => CustomSwitchWidget(
                                value:  logic.isPriaveContant.value,
                                onChanged: (value) {
                                  logic.isPriaveContant.value = value;
                                },
                              )),
                            ),

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
                              scale: 1,
                              child: Obx(() => CustomSwitchWidget(
                                value:  logic.isRecordable.value,
                                onChanged: (value) {
                                  logic.isRecordable.value = value;
                                },
                              )),
                            ),


                          ],
                        )),
                  ),
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
            ),
          )),
    );
  }
  Widget fieldEditAssetWidget(
      {required String title,
        required Function() onTap,
        required TextEditingController? value}) {
    return Material(
      color: '#0F0F26'.toColor(),
      borderRadius: BorderRadius.circular(8.sp),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.sp),
        splashColor: Colors.white.withOpacity(0.02),
        onTap: onTap,
        child: TextField(
          enabled: false,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.5,
          ),
          controller: value,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              hintText: title,
              hintStyle: TextStyle(fontSize: 13.5, color: '9C9CB8'.toColor()),
              suffixIcon: Transform.scale(
                  scale: 0.5,
                  child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg')),
              disabledBorder: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(title , style: TextStyle(
        //         color: '#9C9CB8'.toColor()
        //     ),),
        //
        //     SvgPicture.asset('assets/mediaverse/icons/arrow.svg')
        //   ],
        // ),
      ),
    );
  }
  void _runCustomSelectBottomEditeAssetSheet({
    required List<dynamic> models,
    required String title,
    required TextEditingController? value,
    TextEditingController? priceController,
    bool isSearchBox = true,
    bool isLicenceType = false,
  }) {
    List<dynamic> filteredModels = List.from(models);
    final TextEditingController searchController = TextEditingController();

    Get.bottomSheet(
      elevation: 0,
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: 100.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: "#0F0F26".toColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(
                                  'assets/mediaverse/icons/arrow.svg'),
                            ),
                          ),
                          Spacer(),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 24),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      if (isSearchBox)
                        TextField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              filteredModels = models
                                  .where((item) => item.toString()
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                                  .toList();
                            });
                          },
                          style: TextStyle(
                            decorationColor: Colors.transparent,
                            decoration: TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                            fillColor: '#17172E'.toColor(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                          ),
                        ),
                      SizedBox(height: isSearchBox ? 2.h : 0),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 75),
                          itemCount: filteredModels.length,
                          itemBuilder: (context, index) {
                            final item = filteredModels[index];
                            final isSelected = value?.text == item;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  value?.text = item;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 3.h,
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        if (isLicenceType)
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: isSelected
                                                    ? '2563EB'.toColor()
                                                    : '9C9CB8'.toColor(),
                                                width: isSelected ? 5.5 : 1,
                                              ),
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Checkbox(
                                              value: isSelected,
                                              activeColor: Colors.white,
                                              onChanged: (_) {},
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(6),
                                                side: BorderSide(
                                                  color: '9C9CB8'.toColor(),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : '9C9CB8'.toColor(),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (item == "editprof_14".tr && isSelected)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextField(
                                        textDirection: TextDirection.ltr,
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          hintText: '00.00',
                                          hintTextDirection: TextDirection.ltr,
                                          hintStyle: TextStyle(
                                              color: '9C9CB8'.toColor()),
                                          fillColor: '#17172E'.toColor(),
                                          filled: true,
                                          suffixIcon: IconButton(
                                            onPressed: null,
                                            icon: Text(
                                              'EUR',
                                              style: TextStyle(
                                                  color: '9C9CB8'.toColor()),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.sp),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        '0F0F26'.toColor(),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: '0F0F26'.toColor(),
                        blurRadius: 50,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Material(
                          color: '2563EB'.toColor(),
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            splashColor: Colors.white.withOpacity(0.03),
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Text('Confirm'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
