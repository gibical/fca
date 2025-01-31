import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/logic.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../channel/v2/widgets/channels_title_widget.dart';

class PlusTextGenrationPage extends StatefulWidget {
  const PlusTextGenrationPage({super.key});

  @override
  State<PlusTextGenrationPage> createState() => _PlusTextGenrationPageState();
}

class _PlusTextGenrationPageState extends State<PlusTextGenrationPage> {
  String tag = "new-text-${DateTime.now()}";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PlusLogic logic = Get.put(PlusLogic(PostType.text, tag), tag: tag);

    return GetBuilder<PlusLogic>(
        init: logic,
        tag: tag,
        builder: (logic) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: SafeArea(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChannelsTitleWidget("add_asset_30".tr),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: "0f0f26".toColor(),
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    padding: EdgeInsets.all(16),
                                    child: TextField(
                                      controller: logic
                                          .mainTextEditingController,
                                      maxLines: 500,
                                      onChanged: (s) {
                                        setState(() {

                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "add_asset_31".tr,
                                          hintStyle:
                                          TextStyle(color: "9C9CB8".toColor())),
                                    ),
                                  )),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "add_asset_21".tr,
                                style: TextStyle(
                                    color: "#9C9CB8".toColor(),
                                    fontSize: 10.sp),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Obx(() {
                                return Opacity(
                                  opacity: logic.filePath
                                      .toString()
                                      .length > 10
                                      ? 0.3
                                      : 1,
                                  child: Container(
                                    width: logic.isShowFileFromPath.value
                                        ? 60.w
                                        : 30.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                        color: "0f0f26".toColor(),
                                        borderRadius: BorderRadius.circular(
                                            500)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        logic.pickFileWithPermissionCheck();
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              500)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/all/icons/upload.svg"),
                                          SizedBox(
                                            width: 1.5.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              logic.isShowFileFromPath.value
                                                  ? logic.selectedFile!
                                                  .path
                                                  .split("/")
                                                  .last
                                                  : "add_asset_22".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        Obx(() {
                          return Container(
                            margin: EdgeInsets.all(16),
                            height: 6.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color: (logic.mainTextEditingController.text
                                    .trim()
                                    .isNotEmpty ||
                                    logic.isShowFileFromPath.value)
                                    ? AppColor.primaryLightColor
                                    : "9c9cb8".toColor()),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(500),
                              ),
                              onPressed: () {
                                logic.createTextAndUploadFile();
                              },
                              child: Obx(() {
                                return Center(
                                  child: logic.isloadingText.value
                                      ? Lottie.asset(
                                      "assets/${F
                                          .assetTitle}/json/Y8IBRQ38bK.json",
                                      height: 5.h)
                                      : Text("add_asset_23".tr),
                                );
                              }),
                            ),
                          );
                        })
                      ]),
                )),
          );
        });
  }
}
