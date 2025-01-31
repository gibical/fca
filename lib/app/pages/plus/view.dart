import 'dart:io';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/widgets/licence_type_bottom_sheet.dart';
import 'package:mediaverse/app/pages/plus/widgets/perimisson_bottom_sheet.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../channel/v2/widgets/channels_title_widget.dart';
import 'logic.dart';
import 'state.dart';

class PlusPage extends StatefulWidget {
  PlusPage({Key? key}) : super(key: key);

  @override
  State<PlusPage> createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusPage> {
  final PlusLogic logic = Get.arguments[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlusLogic>(
        init: logic,
        tag: logic.tag,
        builder: (logic) {
          bool _isShowTum = (!logic.isLoadingUploadFile.value &&
              !(logic.isShowImageFromPath.value));

          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: SafeArea(
                child: Container(
                  width: 100.w,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ChannelsTitleWidget(_getTitle()),
                        Obx(() {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: (logic.uploadFilePercent.value).w,
                              height: 3,
                              color: AppColor.primaryLightColor,
                            ),
                          );
                        }),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 50.w,
                          height: 50.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [

                                if(logic.isShowImageFromPath.value
                                )SizedBox.expand(
                                  child: Image.file(
                                    File(logic.filePath ?? ""),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                Visibility(
                  visible: _isShowTum,
                  child: SizedBox.expand(
                    child:
                    Image.asset(
                        "assets/all/images/tumnial.png"),
                    //
                  ),),
                                if (logic.postype == PostType.audio &&
                                    !_isShowTum &&
                                    !logic.isShowImageFromPath.value)SizedBox
                                    .expand(child: Container(
                                  decoration: BoxDecoration(
                                      color: "17172e".toColor()

                                  ),
                                  child: Center(
                                      child:
                                      SvgPicture.asset(
                                          "assets/all/icons/audio.svg")),
                                )),
                                if (logic.postype == PostType.text &&
                                    !_isShowTum &&
                                    !logic.isShowImageFromPath.value)SizedBox
                                    .expand(child: Container(
                                  decoration: BoxDecoration(
                                      color: "17172e".toColor()

                                  ),
                                  child: Center(
                                      child:
                                      SvgPicture.asset(
                                          "assets/all/icons/text.svg")),
                                )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: 27.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                        color: "0f0f26".toColor(),
                                        borderRadius: BorderRadius.circular(
                                            500)),
                                    margin: EdgeInsets.all(2.w),
                                    child: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        logic.pickAndUploadFile();
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              500)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 1.h),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 1.h),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 1.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: GetBuilder<PlusLogic>(
                                    init: logic,
                                    tag: logic.tag,
                                    builder: (logic) {
                                      return Container(
                                          width: 100.w,
                                          height: 6.h,
                                          decoration: BoxDecoration(
                                              color: "0f0f26".toColor(),
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  10)),
                                          child: MaterialButton(
                                            onPressed: () {
                                              logic.pickCountry();
                                            },
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10)),
                                            child: Row(
                                              children: [
                                                if (logic
                                                    .selectedCountryModel ==
                                                    null)
                                                  SvgPicture.asset(
                                                      "assets/all/icons/add_channel_2.svg"),
                                                if (logic
                                                    .selectedCountryModel !=
                                                    null)
                                                  Container(
                                                    child: CountryFlag
                                                        .fromCountryCode(
                                                      logic
                                                          .selectedCountryModel!
                                                          .iso
                                                          .toString(),
                                                      width: 30,
                                                      height: 15,
                                                    ),
                                                  ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                if (logic
                                                    .selectedCountryModel ==
                                                    null)
                                                  Text(
                                                    "add_channel_5".tr,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10.sp,
                                                        color: "9c9cb8"
                                                            .toColor()),
                                                  ),
                                                if (logic
                                                    .selectedCountryModel !=
                                                    null)
                                                  Expanded(
                                                    child: Text(
                                                      logic
                                                          .selectedCountryModel!
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: 9.sp,
                                                          color: "9c9cb8"
                                                              .toColor()),
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
                                child: GetBuilder<PlusLogic>(
                                    init: logic,
                                    tag: logic.tag,

                                    builder: (logic) {
                                      return Container(
                                          width: 100.w,
                                          height: 6.h,
                                          decoration: BoxDecoration(
                                              color: "0f0f26".toColor(),
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  10)),
                                          child: MaterialButton(
                                            onPressed: () {
                                              logic.pickLanguage();
                                            },
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    10)),
                                            child: Row(
                                              children: [
                                                if (logic.languageModel == null)
                                                  Text(
                                                    "add_channel_6".tr,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10.sp,
                                                        color: "9c9cb8"
                                                            .toColor()),
                                                  ),
                                                if (logic.languageModel != null)
                                                  Text(
                                                    Constant
                                                        .reversedLanguageMap[
                                                    logic.languageModel],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .w500,
                                                        fontSize: 10.sp,
                                                        color: "9c9cb8"
                                                            .toColor()),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 1.h),
                          child: Container(
                              width: 100.w,
                              height: 3.h,
                              decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(
                                  10)),
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
                                          inactiveTrackColor: "9c9cb8"
                                              .toColor(),
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 1.h),
                          width: 100.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: "0f0f26".toColor(),
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              Get.bottomSheet(LicenceTypeBottomSheet());
                            },
                            child: TextField(
                              enabled: false,
                              controller: TextEditingController(
                                  text: logic.getLicenceText(logic.licence)),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: AppColor.primaryLightColor),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            onPressed: () {
                              logic.sendMainRequest();
                            },
                            child: Obx(() {
                              return Center(
                                child: logic.isloading.value
                                    ? Lottie.asset(
                                    "assets/${F
                                        .assetTitle}/json/Y8IBRQ38bK.json",
                                    height: 5.h)
                                    : Text("add_channel_9".tr),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  void _runCustomSelectBottomEditeAssetSheet({
    required List<String> models,
    required String title,
    required TextEditingController? value,
    TextEditingController? priceController,
    bool isSearchBox = true,
    bool isLicenceType = false,
  }) {
    List<String> filteredModels = List.from(models);
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
                                  .where((item) =>
                                  item
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

  String _getTitle() {
    switch (logic.postype) {
      case PostType.image:
      // TODO: Handle this case.
        return "add_asset_1_1".tr;
      case PostType.video:
        return "add_asset_1_0".tr;
      case PostType.audio:
        return "add_asset_1_2".tr;
      case PostType.text:
        return "add_asset_1_3".tr;
      case PostType.channel:
        return "add_asset_1_0".tr;
    }
  }
}
