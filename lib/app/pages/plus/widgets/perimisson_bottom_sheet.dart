import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/appbar_btn.dart';

class PerimissonBottomSheet extends StatelessWidget {
  PlusLogic logic;

  PerimissonBottomSheet(this.logic);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 4.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarBTNWidgetAll(
                      iconName: 'remove',
                      onTap: () {
                        Get.back();
                      }),
                  Text(
                   "add_asset_1".tr,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 10.w,
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(child: GestureDetector(
                onTap: (){

                  logic.requestPermissions();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("add_asset_2".tr,style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold,
                      fontSize: 11.sp

                    ),),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      child: Text("add_asset_3".tr,style: TextStyle(
                        color:"#9C9CB8".toColor(),fontWeight: FontWeight.bold,
                          fontSize: 10.sp

                      ),textAlign: TextAlign.center,),
                    ),
                    Text("add_asset_4".tr,style: TextStyle(
                        color: AppColor.primaryLightColor,fontWeight: FontWeight.bold,
                        fontSize: 9.sp

                    ),),
                  ],
                ),
              ))

            ],
          ),
        ),
      ),
    );
  }
}
