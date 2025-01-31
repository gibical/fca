import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/logic.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:sizer/sizer.dart';
import 'package:toastification/toastification.dart';

import '../../../common/app_color.dart';
import '../../home/widgets/sort_select_bottom_sheet.dart';

class DurationTypeBottomSheet extends StatefulWidget {
  const DurationTypeBottomSheet({super.key});

  @override
  State<DurationTypeBottomSheet> createState() =>
      _SerachFilterBottomsheetWidgetState();
}

class _SerachFilterBottomsheetWidgetState
    extends State<DurationTypeBottomSheet> {
  PlusLogic logic = Get.find<PlusLogic>();

  int slectedDuration = 0 ;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 32.h,
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
                Text("add_asset_14".tr),
                Container(width: 5.w,)
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: logic.durationList.length,
                itemBuilder: (s,i){
                  return CustomCheckbox(isChecked:slectedDuration==i, onChanged: (){
                    slectedDuration=i;
                    setState(() {

                    });
                  }, title: logic.durationList.elementAt(i));
                },
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
    Get.back(result: logic.durationList.elementAt(slectedDuration));
  }
}
