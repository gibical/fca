import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/font_style.dart';
import '../../profile/view.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';

class AddUpComingClassWidget extends StatefulWidget {
  const AddUpComingClassWidget({super.key});

  @override
  State<AddUpComingClassWidget> createState() => _AddUpComingClassWidgetState();
}

class _AddUpComingClassWidgetState extends State<AddUpComingClassWidget> {
  ShareAccountLogic _logic = Get.find<ShareAccountLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShareAccountLogic>(
        init: _logic,
        builder: (logic) {
          return Container(
            width: 100.w,

            height: 60.h,
            decoration: BoxDecoration(
                color: "3b3a5a".toColor(),
                border: Border(
                  left: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1),
                  bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 0.4),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )
            ),
            child: SingleChildScrollView(
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
                         Text("share_1".tr),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:  Text(
                            "share_2".tr,
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
                    child: MaterialButton(
                      onPressed: () {
                        Get.to(
                            ProfileScreen(),
                            arguments: 'onTapChannelManagement');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline_outlined,
                              color: Colors.white54),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            _logic.selectedAssetName.value.isNotEmpty ? _logic
                                .selectedAssetName.value : "share_3".tr,
                            style: TextStyle(color: Colors.white54),
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h,),

                  MaterialButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    onPressed: () {
                      Get.toNamed(PageRoutes.SHAREACCOUNT, arguments: [
                        "onTapChannelManagement",
                        _getTypeBYChangeType(_logic.typeString.value)
                      ]);
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
                            "share_4".tr,
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
                              child: Row(
                                children: [
                                  Text(logic.selectedAccoount == null
                                      ? "share_5".tr
                                      : logic.selectedAccoount!.name ?? ""),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h,),


                  MaterialButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    onPressed: () {
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
                            "share_6".tr,
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Container(
                            height: 28,
                            width: 1.5,
                            color: AppColor.whiteColor.withOpacity(0.2),
                          ),
                          Obx(
                                () =>
                                Expanded(
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
                                    _logic.typeString.value = "Archive";
                                    _logic.changeType.value = false;
                                    _logic.selectedAccoount==null;
                                    _logic.update();
                                  },
                                  tileColor: Colors.black54,
                                  title:  Text("share_7".tr),
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
                                    _logic.typeString.value = "Share";
                                    _logic.changeType.value = false;
                                    _logic.selectedAccoount==null;

                                    _logic.update();
                                  },
                                  tileColor: Colors.black54,
                                  title:  Text("share_8".tr),
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
                                    _logic.typeString.value = "Stream";
                                    _logic.changeType.value = false;
                                    _logic.selectedAccoount==null;

                                    _logic.update();
                                  },
                                  tileColor: Colors.black54,
                                  title:  Text("share_9".tr),
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
                  Container(
                    height: 16.h,
                    width: 85.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black54),
                    padding: EdgeInsets.all(2.w),
                    child: TextField(
                      controller: _logic.addUpcomingdes,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "share_10".tr
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),


                  if( _logic.typeString.value == "Share") Container(
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
                          "share_15".tr,
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
                        Expanded(child: TextField(

                          controller: _logic.addUpcomingTitle,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  if( _logic.typeString.value == "Share") MaterialButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    onPressed: () {
                      _logic.changeType2.value = !_logic.changeType2.value;
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
                            "share_11".tr,
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            width: 3.w,
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
                              child: Row(
                                children: [
                                  Text(_logic.addUpcomingprivacy.text),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                  )
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
                  Obx(() {
                    if (_logic.changeType2.value &&
                        _logic.typeString.value == "Share") {
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
                                    _logic.addUpcomingprivacy.text = "Public";
                                    _logic.changeType2.value = false;
                                    _logic.update();
                                  },
                                  tileColor: Colors.black54,
                                  title: Text("share_12".tr),
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
                                    _logic.addUpcomingprivacy.text = "Private";
                                    _logic.changeType2.value = false;
                                    _logic.update();
                                  },
                                  tileColor: Colors.black54,
                                  title:  Text("share_14".tr),
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
                        logic.sendMainRequeast();
                      },
                      color: Colors.black54,
                      child: Obx(() {
                        return Center(child: logic.isLoadingSendMain.value
                            ? Lottie.asset(
                            "assets/json/Y8IBRQ38bK.json", height: 3.h)
                            : Text("share_13".tr));
                      }),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _getTypeBYChangeType(String value) {
    switch (value) {
      case "Archive":
        return "1";
      case "Share":
        return "1";
      case "Stream":
        return "4";
    }
  }
}
