import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:mediaverse/app/pages/search/widgets/serach_filter_plans_bottomsheet_widget.dart';
import 'package:mediaverse/app/pages/search/widgets/serach_filter_types_bottomsheet_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class SerachFilterBottomSheetWidget extends StatefulWidget {
  const SerachFilterBottomSheetWidget({super.key});

  @override
  State<SerachFilterBottomSheetWidget> createState() =>
      _SerachFilterBottomsheetWidgetState();
}

class _SerachFilterBottomsheetWidgetState
    extends State<SerachFilterBottomSheetWidget> {
  SearchLogic logic = Get.find<SearchLogic>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchLogic>(
      init: logic,
        builder: (logic) {
          return Container(
            width: 100.w,
            height: 31.h,
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),

            ),
            padding: EdgeInsets.all(16),
            child: Column(


              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                    Text("search_4".tr),
                    GestureDetector(
                      onTap: () {
                        logic.selecetedPlan=0;
                        logic.selecetedType=0;
                        logic.searchAssets();//
                        Get.back();
                      },
                      child: Text("search_9".tr, style: TextStyle(
                          color: AppColor.primaryLightColor, fontSize: 8.sp
                      ),),
                    ),
                  ],
                ),

                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Get.bottomSheet(SerachFilterPlansBottomSheetWidget());
                    },
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      children: [
                        Text("search_5".tr,
                          style: TextStyle(fontWeight: FontWeight.w500,),),
                        Spacer(),
                        Text(logic.plans.elementAt(logic.selecetedPlan),
                          style: TextStyle(fontSize: 10.sp, color: "#9C9CB8"
                              .toColor()),),
                        SizedBox(width: 3.w,),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Icon(
                            Icons.arrow_forward_ios, color: CupertinoColors.white,
                            size: 10.sp,),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 1.h,),
                Container(
                  child: MaterialButton(
                    onPressed: () {
                      Get.bottomSheet(SerachFilterTypesottomSheetWidget());

                    },
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      children: [
                        Text("search_10".tr,
                          style: TextStyle(fontWeight: FontWeight.w500,),),
                        Spacer(),
                        Text(logic.types.elementAt(logic.selecetedType),
                          style: TextStyle(fontSize: 10.sp, color: "#9C9CB8"
                              .toColor()),),
                        SizedBox(width: 3.w,),
                        Icon(
                          Icons.arrow_forward_ios, color: CupertinoColors.white,
                          size: 10.sp,)

                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  height: 6.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: AppColor.primaryLightColor
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),

                    ), onPressed: () {

                      logic.searchAssets();
                      Get.back();
                  },

                    child: Center(
                      child: Text("search_17".tr),
                    ),
                  ),
                )

              ],
            ),
          );
        });
  }
}
