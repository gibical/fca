import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

class DeleteProgramsDialog extends StatelessWidget {
  Programs program;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            child: Container(
              width: 90.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.all(3.w),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("my_channel_35".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.sp),),
                  SizedBox(height: 2.h,),
                  Text("my_channel_36".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8.sp,color: "#9C9CB8".toColor()),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        Get.back();
                      }, child: Text("my_channel_37".tr,style: TextStyle(color: Colors.white),)),
                      TextButton(onPressed: (){
                        Get.find<MyChannelController>().deleteProgram(program);
                        Get.back();
                      }, child: Text("my_channel_38".tr,style: TextStyle(color: "#FF5630".toColor()),)),
                    ],
                  )
                ],
              ) ,
            ),
          ),
        ],
      ),
    );
  }

  DeleteProgramsDialog(this.program);
}
