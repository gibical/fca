import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:mediaverse/app/pages/share_account/widgets/program_bottom_sheet.dart';
import 'package:mediaverse/app/pages/stream/logic.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/FromJsonGetChannels.dart';
import '../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../../gen/model/json/walletV2/FromJsonGetPrograms.dart';
import '../../../common/app_config.dart';
import '../../../common/app_route.dart';
import '../../profile/view.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';

class ProgramShowBottomSheet extends StatefulWidget {
  ChannelsModel model;

  ProgramShowBottomSheet(this.model, {super.key});

  @override
  State<ProgramShowBottomSheet> createState() => _ProgramShowBottomSheetState();
}

class _ProgramShowBottomSheetState extends State<ProgramShowBottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();

  var isShowinmediaverse = true.obs;
  var isSelectFromAsset = true.obs;
  var streamRecord = true.obs;
  var streamStartAuto = true.obs;


  @override
  Widget build(BuildContext context) {//
    return Container(
      width: 100.w,

      height: 55.h,
      decoration: BoxDecoration(
          color: AppColor.primaryLightColor,
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

          SizedBox(height: 2.h,),
            IgnorePointer(
            child: CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'Name '.tr,
                hintText: ''.tr,
                textEditingController: TextEditingController(text: widget.model.name??""),
                needful: true),
          ),
          IgnorePointer(
            child: CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'Country '.tr,
                hintText: 'Insert Your Program Here'.tr,
                textEditingController: TextEditingController(text: widget.model.country??""),
                needful: true),
          ),
          IgnorePointer(
            child: CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'Language '.tr,
                hintText: ''.tr,
                textEditingController: TextEditingController(text: widget.model.language??""),
                needful: true),
          ),
          IgnorePointer(
            child: CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'Is Recordable '.tr,
                hintText: ''.tr,
                textEditingController: TextEditingController(text:(widget.model.isRecordable!?"true":"false")),
                needful: true),
          ),
          IgnorePointer(
            child: CustomTextFieldRegisterWidget(
                context: Get.context!,
                titleText: 'Is Private '.tr,
                hintText: ''.tr,
                textEditingController: TextEditingController(text:(widget.model.isPrivate!?"true":"false")),
                needful: true),
          ),


          Container(
            width: 100.w,
            height: 7.h,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.primaryDarkColor,

                    ),
                    borderRadius: BorderRadius.circular(7)
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)
                    ),
                    onPressed: (){

                      Get.back();
                      Get.bottomSheet(ProgramBottomSheet(Get.find<ShareAccountLogic>(),isEditMode: true,model: widget.model,));
                    },
                    child: Center(
                      child: Text("Edit",style: TextStyle(color: AppColor.primaryDarkColor),),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 30.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,

                      ),
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)
                    ),
                    onPressed: (){

                      Get.find<ShareAccountLogic>().deleteProgram(widget.model.id);
                    },
                    child: Center(
                      child: Text("Delete",style: TextStyle(color: Colors.red),),
                    ),
                  ),
                ),

              ],
            ),
          )

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

  void onChannelClick() async{
    await Get.toNamed(PageRoutes.SHAREACCOUNT, arguments: [
      "onTapChannelManagement",
      "asd"
    ]);
    setState(() {
      
    });
  }
}
