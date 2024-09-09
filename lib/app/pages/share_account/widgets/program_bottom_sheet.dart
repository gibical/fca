import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibical/app/common/app_color.dart';
import 'package:gibical/app/common/app_extension.dart';
import 'package:gibical/app/pages/share_account/logic.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import '../../profile/view.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';

class ProgramBottomSheet extends StatefulWidget {
  ShareAccountLogic shareAccountLogic;

  ProgramBottomSheet(this.shareAccountLogic, {super.key});

  @override
  State<ProgramBottomSheet> createState() => _ProgramBottomSheetState();
}

class _ProgramBottomSheetState extends State<ProgramBottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();

  var isShowinGibical = true.obs;
  var isSelectFromAsset = true.obs;
  var streamRecord = true.obs;
  var streamStartAuto = true.obs;


  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10
            ),
            child: Text("share_16".tr, style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold
            ),),
          ),
          CustomTextFieldRegisterWidget(
              context: Get.context!,
              titleText: 'Name '.tr,
              hintText: 'Insert Your Program Here'.tr,
              textEditingController: TextEditingController(),
              needful: true),
          Container(
            height: 75,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.toNamed(PageRoutes.SHAREACCOUNT, arguments: [
                  "onTapChannelManagement",
                  "asd"
                ]);
              },
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: IgnorePointer(

                      child: CustomTextFieldRegisterWidget(
                          context: Get.context!,
                          titleText: 'Stream Destinations '.tr,
                          hintText: widget.shareAccountLogic.selectedAssetName
                              .value.isNotEmpty
                              ? widget.shareAccountLogic
                              .selectedAssetName.value
                              : 'Select Stream accounts'.tr,
                          textEditingController: _nameEditingController,
                          //
                          needful: true),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Icon(Icons.arrow_drop_down)),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Text("Live Show in Gibical".tr),
                Obx(() {
                  return CupertinoSwitch(
                    value: isShowinGibical.value,
                    onChanged: (value) {
                      isShowinGibical.value = value;
                    },
                  );
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Text("Stream From Asset".tr),
                Obx(() {
                  return CupertinoSwitch(
                    value: isSelectFromAsset.value,
                    onChanged: (value) {
                      isSelectFromAsset.value = value;
                    },
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 2.h,),
          Obx(() {
            return Visibility(
              visible: isSelectFromAsset.value,
              child: Center(
                child: Container(
                  height: 6.h,
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 25),
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
                          widget.shareAccountLogic.selectedAssetName.value
                              .isNotEmpty ? widget.shareAccountLogic
                              .selectedAssetName.value : "share_3".tr,
                          style: TextStyle(color: Colors.white54),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: !isSelectFromAsset.value,
              child: Center(
                child:Column(
                  children: [

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text("Stream From Asset".tr),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Radio(value: true, groupValue: streamRecord.value, onChanged: (s){
                               streamRecord.value = s!;
                               setState(() {

                               });
                             }),
                             Text("Yes"),
                           ],
                         ),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Radio(value: false, groupValue: streamRecord.value, onChanged: (s){
                               streamRecord.value = s!;
                               setState(() {

                               });
                             }),
                             Text("No"),
                           ],
                         ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text("Stream Start: Automatic".tr),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Radio(value: true, groupValue: streamStartAuto.value, onChanged: (s){
                               streamStartAuto.value = s!;
                               setState(() {

                               });
                             }),
                             Text("Yes"),
                           ],
                         ),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Radio(value: false, groupValue: streamStartAuto.value, onChanged: (s){
                               streamStartAuto.value = s!;
                               setState(() {

                               });
                             }),
                             Text("No"),
                           ],
                         ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 2.h,),
          Padding(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 5.h,
            ),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 5.h,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () async {

              },
              color: AppColor.primaryLightColor,
              child: Obx(() {
                return Center(child: widget.shareAccountLogic.isLoadingSendMain.value
                    ? Lottie.asset(
                    "assets/json/Y8IBRQ38bK.json", height: 3.h)
                    : Text("Create Program"));
              }),
            ),
          ),

        ],
      ),
    );
  }

  void _goToProfile() async {
    await Get.to(
        ProfileScreen(),
        arguments: 'onTapChannelManagement');
    setState(() {

    });
  }
}
