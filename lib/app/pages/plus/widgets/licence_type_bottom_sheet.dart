import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/logic.dart';
import 'package:mediaverse/app/pages/plus/widgets/duration_type_bottom_sheet.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';

import '../../../common/app_color.dart';
import '../../home/widgets/sort_select_bottom_sheet.dart';

class LicenceTypeBottomSheet extends StatefulWidget {
  const LicenceTypeBottomSheet({super.key});

  @override
  State<LicenceTypeBottomSheet> createState() =>
      _SerachFilterBottomsheetWidgetState();
}

class _SerachFilterBottomsheetWidgetState
    extends State<LicenceTypeBottomSheet> {
  PlusLogic logic = Get.find<PlusLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),

      ),
      padding: EdgeInsets.all(16),
      child: GetBuilder<PlusLogic>(
          init: logic,
          builder: (logic) {
        return Column(


          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                Text("add_asset_18".tr),
                Container(width: 5.w,)
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomCheckbox(
                  isChecked: logic.licence == PlusLicence.free, onChanged: () {
                logic.licence = PlusLicence.free;
                logic.update();
                Get.back();
              }, title: logic.getLicenceText( PlusLicence.free)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomCheckbox(
                  isChecked: logic.licence == PlusLicence.ownership,
                  onChanged: () {
                    logic.licence = PlusLicence.ownership;
                    logic.update();
                  },
                  title: logic.getLicenceText(PlusLicence.ownership)),
            ),
            Visibility(
              visible:  logic.licence == PlusLicence.ownership,
              child: Container(
                margin: EdgeInsets.symmetric( vertical: 1.h),
                width: 100.w,
                height: 6.h,
                decoration: BoxDecoration(
                    color: "0f0f26".toColor(),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: logic.priceEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                          hintText: "00.00".tr,
                        ),
                      ),
                    ),
                    Text("add_asset_13".tr)
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomCheckbox(
                  isChecked: logic.licence == PlusLicence.subscreibe,
                  onChanged: () {
                    logic.licence = PlusLicence.subscreibe;
                    logic.update();
                  },
                  title: logic.getLicenceText(PlusLicence.subscreibe)),
            ),
            Visibility(
              visible:  logic.licence == PlusLicence.subscreibe,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric( vertical: 1.h),
                      width: 100.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: "0f0f26".toColor(),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: logic.priceEditingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                                hintText: "00.00".tr,
                              ),
                            ),
                          ),
                          Text("add_asset_13".tr)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  Container(
                    margin: EdgeInsets.symmetric( vertical: 1.h),
                    width: 35.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: "0f0f26".toColor(),
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      onPressed: (){

                       _selectDuration();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child:TextField(
                        enabled: false,
                        controller: logic.durationEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                          suffixIcon: Icon(Icons.arrow_forward_ios)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 100.w,
              height: 5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                  color: AppColor.primaryLightColor,
                  borderRadius: BorderRadius.circular(500)
              ),
              child: MaterialButton(
                onPressed: () {

                 _saveConfirmButton();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500)),
                child: Center(
                    child: Text("add_asset_19".tr,
                      style: TextStyle(fontWeight: FontWeight.w500),)),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _saveConfirmButton() {
    if(logic.licence==PlusLicence.ownership){
      if(logic.priceEditingController.text.trim().isEmpty){
        toastification.show(
          type: ToastificationType.info,
          style: ToastificationStyle.fillColored,
          title: Text("plus_12".tr),
          alignment: Alignment.topLeft,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Color(0xff0f0f26),
          backgroundColor: Color(0xffffffff),
          foregroundColor: Color(0xffffffff),
          boxShadow: lowModeShadow,
          dragToClose: true,
        );
        return ;
      }
    }
    if(logic.licence==PlusLicence.subscreibe){
      if(logic.priceEditingController.text.trim().isEmpty||
          logic.durationEditingController.text.trim().isEmpty){
        toastification.show(
          type: ToastificationType.info,
          style: ToastificationStyle.fillColored,
          title: Text("plus_12".tr),
          alignment: Alignment.topLeft,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Color(0xff0f0f26),
          backgroundColor: Color(0xffffffff),
          foregroundColor: Color(0xffffffff),
          boxShadow: lowModeShadow,
          dragToClose: true,
        );
        return ;
      }
    }
    Get.back();
  }

  void _selectDuration()async {
   var selected = await  Get.bottomSheet(DurationTypeBottomSheet(),);

   logic.durationEditingController.text = selected;

   print('_SerachFilterBottomsheetWidgetState._selectDuration = ${
   logic.durationEditingController.text
   }');
  }
}
