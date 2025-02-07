import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/programs_schedule_empty_state.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/widgets/appbar_btn.dart';

class AddOrEditDestionationBottomSheet extends StatefulWidget {
  bool isEdit;
  Destinations? destinations;
   AddOrEditDestionationBottomSheet(this.isEdit,{super.key,this.destinations});

  @override
  State<AddOrEditDestionationBottomSheet> createState() =>
      _AddOrEditDestionationBottomSheetState();
}

class _AddOrEditDestionationBottomSheetState
    extends State<AddOrEditDestionationBottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _streamKeyEditingController = TextEditingController();
  TextEditingController _streamUrlEditingController = TextEditingController();
  MyChannelController logic = Get.find<MyChannelController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((callback){
      print('_AddOrEditDestionationBottomSheetState.initState = ${widget.destinations!.toJson()}');
      if(widget.isEdit){
        _nameEditingController.text = widget.destinations!.name??"";

        setState(() {

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        color: AppColor.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
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
                    "my_channel_43".tr,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(width: 10.w,)
                ],
              ),
              SizedBox(height: 2.h,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.h),
                width: 100.w,
                height: 6.h,
                decoration: BoxDecoration(
                    color: "0f0f26".toColor(),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _nameEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                    hintText: "add_channel_3".tr,
                  ),
                ),
              ),
              Opacity(
                opacity: widget.isEdit?0.6:1,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  width: 100.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                      color: "0f0f26".toColor(),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    enabled: !widget.isEdit,

                    controller: _streamKeyEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                      hintText: "${"my_channel_45".tr} ${widget.isEdit?"(*****)":""}",
                    ),
                  ),
                ),
              ),
              Opacity(
                opacity: widget.isEdit?0.6:1,

                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  width: 100.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                      color: "0f0f26".toColor(),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    enabled: !widget.isEdit,
                    controller: _streamUrlEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: "#9C9CB8".toColor()),
                      hintText: "${"my_channel_46".tr} ${widget.isEdit?"(*****)":""}",
                    ),
                  ),
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
                child: Obx(() {
                  return MaterialButton(
                    onPressed: () {
                      logic.addDestionation(
                          _nameEditingController, _streamUrlEditingController,
                          _streamKeyEditingController,widget.isEdit,widget.destinations);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500)),
                    child: logic.isloadingAddDestionation.value
                        ? Lottie.asset(
                        "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                        height: 10.h)
                        : Text(widget.isEdit?"my_channel_20".tr:"my_channel_32".tr,
                      style: TextStyle(fontWeight: FontWeight.w500),),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
