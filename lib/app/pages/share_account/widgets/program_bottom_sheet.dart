import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/walletV2/FromJsonGetPrograms.dart';
import '../../../common/app_route.dart';
import '../../plus_section/widget/custom_plan_text_filed.dart';
import '../../profile/view.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';

class ProgramBottomSheet extends StatefulWidget {
  ShareAccountLogic shareAccountLogic;

  ChannelsModel? model;
  bool? isEditMode = false;

  ProgramBottomSheet(this.shareAccountLogic,
      {super.key, this.model, this.isEditMode,});

  @override
  State<ProgramBottomSheet> createState() => _ProgramBottomSheetState();
}

class _ProgramBottomSheetState extends State<ProgramBottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();

  var isRecordable = true.obs;
  var isPrivate = true.obs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditMode != null && widget.isEditMode!) {

      try {
        _nameEditingController =
            TextEditingController(text: widget.model!.name ?? "");
        isRecordable.value = widget.model!.isRecordable!.toString().contains("1");
        isPrivate.value = widget.model!.isPrivate!.toString().contains("1");
        widget.shareAccountLogic.countryModel = widget.shareAccountLogic.countreisModel.firstWhere((test)=>test.iso.toString().contains(widget.model!.country!));
        widget.shareAccountLogic.languageModel =widget.model!.language!;
      } catch (e) {
        // TODO
      }
      try {

      } catch (e) {
        // TODO
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    print('_ProgramBottomSheetState.build = ${widget.shareAccountLogic
        .selectShareMode}');
    return GetBuilder<ShareAccountLogic>(
        init: widget.shareAccountLogic,
        builder: (logic) {
      return Container(
        width: 100.w,

        height: 46.h,
        decoration: BoxDecoration(
            color: AppColor.primaryDarkColor,
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
                  textEditingController: _nameEditingController,
                  needful: true),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Text("Is Recordable".tr),
                    Obx(() {
                      return CupertinoSwitch(
                        value: isRecordable.value,
                        onChanged: (value) {
                          isRecordable.value = value;
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
                    Text("Is Private".tr),
                    Obx(() {
                      return CupertinoSwitch(
                        value: isPrivate.value,
                        onChanged: (value) {
                          isPrivate.value = value;
                        },
                      );
                    }),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: CustomShowAndPickCountry(
                    signlogic: widget.shareAccountLogic,
                    countries: widget.shareAccountLogic.countreisModel,
                    countryModel: widget.shareAccountLogic.countryModel,
                    //
                    models: widget.shareAccountLogic.countreisString,
                    context: context,
                    textEditingController: widget.shareAccountLogic
                        .languageController,

                    titleText: 'signup_10_1'.tr,
                    hintText: 'signup_10_1'.tr,
                    needful: false),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: CustomShowAndPickLanguage(
                    signlogic: widget.shareAccountLogic,
                    countries: Constant.reversedLanguageMap,
                    languageModel: widget.shareAccountLogic.languageModel,
                    //
                    models: widget.shareAccountLogic.countreisString,
                    context: context,
                    textEditingController: widget.shareAccountLogic
                        .languageController,

                    titleText: 'signup_10_1'.tr,
                    hintText: 'signup_10_1'.tr,
                    needful: false),
              ),
              SizedBox(height: 1.h,),

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
                    widget.shareAccountLogic.sendRequestAddProgram(
                        _nameEditingController.text,isRecordable.value,
                        isPrivate.value,
                        widget.isEditMode??false,widget.model!.id!);
                  },
                  color: AppColor.primaryLightColor,
                  child: Obx(() {
                    return Center(child: widget.shareAccountLogic
                        .iscreateProgramloading.value
                        ? Lottie.asset(
                        "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                        height: 3.h)
                        : Text("Submit"));
                  }),
                ),
              ),

            ],
          ),
        ),
      );
    });
  }

  void _goToProfile() async {
    await Get.to(
        ProfileScreen(),
        arguments: 'onTapChannelManagement');
    setState(() {

    });
  }

  void onChannelClick() async {
    await Get.toNamed(PageRoutes.SHAREACCOUNT, arguments: [
      "onTapChannelManagement",
      "asd"
    ]);
    setState(() {

    });
  }
}
