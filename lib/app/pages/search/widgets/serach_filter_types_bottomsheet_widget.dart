import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/search/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../home/widgets/sort_select_bottom_sheet.dart';

class SerachFilterTypesottomSheetWidget extends StatefulWidget {
  const SerachFilterTypesottomSheetWidget({super.key});

  @override
  State<SerachFilterTypesottomSheetWidget> createState() => _SerachFilterBottomsheetWidgetState();
}

class _SerachFilterBottomsheetWidgetState extends State<SerachFilterTypesottomSheetWidget> {
  SearchLogic logic= Get.find<SearchLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 33.h,
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
              IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.close)),
              Text("search_10".tr),
              GestureDetector(
                onTap: (){

                  logic.selecetedPlan=0;
                  logic.update();
                  Get.back();

                },
                child: Text("search_9".tr,style: TextStyle(
                    color: AppColor.primaryLightColor,fontSize: 8.sp
                ),),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
