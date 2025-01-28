import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/select_video_asset_bottomsheet.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../../../common/app_color.dart';
import '../../../../../common/widgets/appbar_btn.dart';
import '../../../../home/widgets/sort_select_bottom_sheet.dart';
import '../logic.dart';

class AddProgramBottonsheet extends StatefulWidget {
  bool isEdit;

  Programs? programModel;

  AddProgramBottonsheet(this.isEdit, {this.programModel});

  @override
  State<AddProgramBottonsheet> createState() => _AddProgramBottonsheetState();
}

class _AddProgramBottonsheetState extends State<AddProgramBottonsheet> {
  SourceType? sourceType;
  MyChannelController logic = Get.find<MyChannelController>();

  ContentModel? model;
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _sourceEditingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((callback){
      if(widget.isEdit){
        _nameEditingController.text = widget.programModel!.name??"";
        if(widget.programModel!.source.toString().contains("rtmp")) {
          _sourceEditingController.text ="my_channel_15".tr;
          sourceType = SourceType.stream;
        };
        if(widget.programModel!.source.toString().contains("file")){
          _sourceEditingController.text =widget.programModel!.value??"";
          sourceType = SourceType.asset;

        }


        setState(() {

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          height: 100.h,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .viewPadding
                        .top + 4.h,
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
                        "my_channel_10".tr,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        width: 10.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
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
                  SizedBox(
                    height: 1.h,
                  ),
                  MaterialButton(
                    onPressed: () {
              //
                     if(!widget.isEdit) _selectAssetType();
                    },
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        width: 100.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            color:widget.isEdit?"9c9cb8".toColor(): "0f0f26".toColor(),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: _sourceEditingController.text.length > 4
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _sourceEditingController.text,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: widget.isEdit?Colors.white:"#9C9CB8".toColor()),
                            ),
                            SvgPicture.asset(
                                "assets/all/icons/add_channel_3.svg",
                                color: widget.isEdit?Colors.white:"#9C9CB8".toColor())
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "my_channel_11".tr,
                              style: TextStyle(color: "#9C9CB8".toColor()),
                            ),
                            SvgPicture.asset(
                                "assets/all/icons/add_channel_3.svg",
                                color: "#9C9CB8".toColor())
                          ],
                        )),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:                   Container(
                  width: 100.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(500)),
                  child: MaterialButton(
                    onPressed: () {
                      logic.addProgram(_nameEditingController,
                          _sourceEditingController, model, sourceType,
                          widget.isEdit, widget.programModel);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500)),
                    child: Obx(() {
                      return Center(
                          child: logic.isLoadingCreateProgram.value ? Lottie
                              .asset(
                              "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                              height: 5.h) : Text(
                            "my_channel_13".tr,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ));
                    }),
                  ),
                )
                ,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendToVideoAssetSelectPage() async {
    //
    ContentModel? contentModel = await Get.bottomSheet(
        SelectVideoAssetBottomsheet(),
        isScrollControlled: true);
    sourceType = SourceType.asset;
    Get.back(result: [sourceType, contentModel]);
  }

  void _selectAssetType() async {
    dynamic result = await Get.bottomSheet(Container(
      width: 100.w,
      height: 24.h,
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close)),
              Text("my_channel_11".tr),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "",
                  style: TextStyle(
                      color: AppColor.primaryLightColor, fontSize: 8.sp),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckbox(
                  isChecked: sourceType == SourceType.asset,
                  onChanged: () {
                    _sendToVideoAssetSelectPage();
                  },
                  title: "my_channel_14".tr),
              SvgPicture.asset(
                "assets/all/icons/add_channel_3.svg",
                color: sourceType == SourceType.asset
                    ? Colors.white
                    : "#9C9CB8".toColor(),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              CustomCheckbox(
                  isChecked: sourceType == SourceType.stream,
                  onChanged: () {
                    sourceType = SourceType.stream;
                    Get.back(result: [sourceType, null]);
                  },
                  title: "my_channel_15".tr),
            ],
          ),
        ],
      ),
    ));
    if (result[0] != null) {
      sourceType = result[0];
      if (result[1] != null) {
        model = (result[1] as ContentModel);
        _sourceEditingController.text = model!.name ?? "";
      } else {
        _sourceEditingController.text = "my_channel_15".tr;
      }
    }
    print('_AddProgramBottonsheetState._selectAssetType  = ${result} - ${_sourceEditingController}');
    setState(() {});
  }
}

enum SourceType { asset, stream }
