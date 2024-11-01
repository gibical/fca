import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/walletV2/FromJsonGetPrograms.dart';
import '../../../common/app_route.dart';
import '../../profile/view.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';

class ProgramBottomSheet extends StatefulWidget {
  ShareAccountLogic shareAccountLogic;

  ProgramModel? model;
  bool? isEditMode=false;

  ProgramBottomSheet(this.shareAccountLogic,  {super.key,this.model, this.isEditMode,});

  @override
  State<ProgramBottomSheet> createState() => _ProgramBottomSheetState();
}

class _ProgramBottomSheetState extends State<ProgramBottomSheet> {
  TextEditingController _nameEditingController = TextEditingController();

  var isShowinmediaverse = true.obs;
  var isSelectFromAsset = true.obs;
  var streamRecord = true.obs;
  var streamStartAuto = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEditMode!=null&&widget.isEditMode!){
      _nameEditingController = TextEditingController(text: widget.model!.name??"");
      try {
        widget.shareAccountLogic.selectShareModeid = widget.model!.destinations![0]['id'];
        widget.shareAccountLogic.selectShareModelName = widget.model!.destinations![0]['name'];
      } catch (e) {
        // TODO
      }
      try {
        widget.shareAccountLogic.selectedAssetName = widget.model!.destinations![0]['details']['inputs'][0]['value'];
      }  catch (e) {
        // TODO
      }

    }
  }

  @override
  Widget build(BuildContext context) {//
    print('_ProgramBottomSheetState.build = ${widget.shareAccountLogic.selectShareMode}');
    return Container(
      width: 100.w,

      height: 40.h,
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
              height: 75,
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
        
                  onChannelClick();
                },
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: IgnorePointer(
        
                        child: CustomTextFieldRegisterWidget(
                            context: Get.context!,
                            titleText: 'Stream Destinations '.tr,
                            hintText: widget.shareAccountLogic.selectShareMode!=null
                                ? "Selected Destination: ${widget.shareAccountLogic.destintionList.length}"
                                : 'Select Stream accounts'.tr,
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
            Opacity(
              opacity: 0.3,
              child: IgnorePointer(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text("Live Show in mediaverse".tr),
                      Obx(() {
                        return CupertinoSwitch(
                          value: isShowinmediaverse.value,
                          onChanged: (value) {
                            isShowinmediaverse.value = value;
                          },
                        );
                      }),
                    ],
                  ),
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
        
                  widget.shareAccountLogic.sendRequestAddProgram(_nameEditingController.text, isSelectFromAsset.value,(widget.isEditMode!=null&&widget.isEditMode!),widget.model);
                },
                color: AppColor.primaryLightColor,
                child: Obx(() {
                  return Center(child: widget.shareAccountLogic.iscreateProgramloading.value
                      ? Lottie.asset(
                      "assets/json/Y8IBRQ38bK.json", height: 3.h)
                      : Text("Create Program"));
                }),
              ),
            ),
        
          ],
        ),
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
