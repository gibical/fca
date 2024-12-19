import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/channel/tab/single_channel_logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/font_style.dart';
import '../../plus_section/widget/custom_plan_text_filed.dart';
import '../../profile/view.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';

class AddProgramToChannelPage extends StatefulWidget {
  bool isEdit;

  AddProgramToChannelPage({this.isEdit = false, this.programmodel});

  Programs? programmodel;

  @override
  State<AddProgramToChannelPage> createState() =>
      _AddProgramToChannelPageState();
}

class _AddProgramToChannelPageState extends State<AddProgramToChannelPage> {
  SingleChannelLogic channelLogic = Get.arguments[0];

  TextEditingController newProgramNameController = TextEditingController();
  TextEditingController newProgramTypeController = TextEditingController();
  TextEditingController newProgramValueController = TextEditingController();

  String selectedAssetName = "";
  String? selectedFileID;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((callback) {
      if (widget.isEdit) {
        newProgramNameController.text = widget.programmodel!.name ?? "";
        newProgramTypeController.text = widget.programmodel!.source ?? "";


        print('_AddProgramToChannelPageState.initState = ${widget.programmodel!.toJson()}');
        try {
          newProgramValueController.text = widget.programmodel!.value ?? "";

          selectedAssetName = newProgramValueController.text;
          selectedFileID = newProgramValueController.text; //
        } catch (e) {
          // TODO
        }


        _getLiveStatus();
      }
      newProgramTypeController.addListener(() {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        '_AddProgramToChannelPageState.build = ${newProgramTypeController
            .text}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        toolbarHeight: 120,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 10.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 20),
                child: Text(
                  'channel_40'.tr + " ${channelLogic.channelsModel.name}",
                  style: FontStyleApp.titleMedium.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          CustomTextFieldRegisterWidget(
              context: context,
              titleText: 'channel_41'.tr,
              hintText: 'channel_41'.tr,
              textEditingController: newProgramNameController,
              needful: true),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: CustomTDropDownPlusWidget(
                context: context,
                textEditingController: newProgramTypeController,
                titleText: 'channel_42'.tr,
                hintText: 'channel_42'.tr,
                needful: false,
                models: [
                  "channel_44".tr,
                  "channel_45".tr,
                  "channel_46".tr,
                  "channel_47".tr,
                  "channel_48".tr,
                  "channel_49".tr,
                ]),
          ),
          Visibility(
            visible: (newProgramTypeController.text.contains("link")),
            child: CustomTextFieldRegisterWidget(
                context: context,
                titleText: 'channel_43'.tr,
                hintText: 'channel_43'.tr,
                textEditingController: newProgramValueController,
                //
                needful: true),
          ),
          Visibility(
            visible: (newProgramTypeController.text.contains("file")),
            child: Container(
              height: 6.h,
              width: 85.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black54),
              child: MaterialButton(
                onPressed: () {
                  _goToProfile();
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
                      selectedAssetName.isNotEmpty
                          ? selectedAssetName
                          : "share_3".tr,
                      style: TextStyle(color: Colors.white54),
                    )
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(widget.isEdit) Container(
                  width: 100.w,
                  height: 6.h,
                  margin: EdgeInsets.all(16),

                  child: Row(
                    children: [
                      Expanded(
                        child: Opacity(
                          opacity: _isStarted ? 1 : 0.3,
                          child: IgnorePointer(
                            ignoring: !_isStarted,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.red,

                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Icon(Icons.stop, color: Colors.red,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w,),
                      Expanded(
                        child: Opacity(
                          opacity: !_isStarted ? 1 : 0.3,
                          child: IgnorePointer(
                            ignoring: _isStarted,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,

                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: MaterialButton(
                                onPressed: () {

                                  _onTapStartProgram();
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Obx(() {
                                  return Center(
                                    child: channelLogic.isloadingNewProgram
                                        .value
                                        ? CircularProgressIndicator()
                                        : Icon(
                                      Icons.play_arrow, color: Colors.green,),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  height: 6.h,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Obx(() {
                    return MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5000)),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        channelLogic.sendNewProgramReqyest(
                            newProgramNameController,
                            newProgramTypeController,
                            newProgramValueController,
                            selectedFileID,
                            widget.isEdit,
                            widget.programmodel);
                      },
                      child: channelLogic.isloadingNewProgram.value
                          ? Lottie.asset(
                          "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                          height: 10.h)
                          : Text(
                        "setting_13".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  void _goToProfile() async {
    var model = await Get.to(ProfileScreen(), arguments: 'onTapNewProgram');//
    selectedAssetName = jsonDecode(model[0])['media']['name'];
    selectedFileID = jsonDecode(model[0])['file_id'];
    setState(() {});
  }

  void _onTapStartProgram() async{
   DateTime? date = await channelLogic.startProgram(
        widget.programmodel!);
   if(date!=null){
     widget.programmodel!.lastEvent!=date.toIso8601String();
     _getLiveStatus();
   }
  }

  void _getLiveStatus() {
    _isStarted =
        widget.programmodel!.lastEvent.toString().toLowerCase().contains(
            "started");
    setState(() {

    });
  }
}
