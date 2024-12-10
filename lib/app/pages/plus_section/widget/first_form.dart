import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus_section/logic.dart';
import 'package:mediaverse/app/pages/plus_section/widget/secned_form.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';
import 'custom_plan_text_filed.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus_section/logic.dart';
import 'package:mediaverse/app/pages/plus_section/widget/secned_form.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';
import 'custom_plan_text_filed.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus_section/logic.dart';
import 'package:mediaverse/app/pages/plus_section/widget/secned_form.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../signup/widgets/custom_text_field_form_register_widget.dart';
import 'custom_plan_text_filed.dart';

class FirstForm extends StatefulWidget {
  PlusSectionLogic logic;

  FirstForm(this.logic);


  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold( //
        backgroundColor: AppColor.blueDarkColor,

        body: Center(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.5.w),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                width: 16.w,
                              ),
                              Text("plus_1".tr,
                                style: TextStyle(color: Colors.white),),
                              Container(
                                width: 16.w,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("plus_2".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              CustomTextFieldPlusWidget(
                                  context: context,
                                  textEditingController: widget.logic
                                      .titleController,

                                  titleText: 'plus_3'.tr,
                                  hintText: 'plus_4'.tr,
                                  isLarge: false,
                                  isFocus: true,
                                  onTap: () {
                                    _scrollToBottom();
                                  },
                                  needful: false),
                            ],
                          ),
                        ),
                        if(widget.logic.mediaMode!=MediaMode.image)SizedBox(height: 4.h,),
                        if(widget.logic.mediaMode!=MediaMode.image)Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("signup_10_1".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: GetBuilder<PlusSectionLogic>(
                                  init: widget.logic,
                                  builder: (logic) {
                                return CustomShowAndPickCountry(
                                    signlogic: widget.logic,
                                    countries: widget.logic.countreisModel,
                                    countryModel: widget.logic.countryModel,
                                    //
                                    models: widget.logic.countreisString,
                                    context: context,
                                    textEditingController: widget.logic
                                        .languageController,

                                    titleText: 'signup_10_1'.tr,
                                    hintText: 'signup_10_1'.tr,
                                    needful: false);
                              }),
                            ),


                          ],
                        ),
                        SizedBox(height: 4.h,),
                        if(widget.logic.videoOutPut.isNotEmpty &&
                            widget.logic.videoOutPut.contains("mp4")) Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),

                          child: GetBuilder<PlusSectionLogic>(
                              init: widget.logic,
                              builder: (logic) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("plus_8".tr,
                                      style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold),),

                                    CustomTDropDownPlusWidget(
                                        models: Constant.generes,
                                        context: context,
                                        textEditingController: widget.logic
                                            .genreController,
                                        titleText: 'plus_9'.tr,
                                        hintText: 'plus_10'.tr,
                                        needful: false),
                                  ],
                                );
                              }),
                        ),
                        if(widget.logic.videoOutPut.isNotEmpty &&
                            widget.logic.videoOutPut.contains("mp4")) SizedBox(
                          height: 4.h,),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("plus_11".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              CustomTextFieldPlusWidget(
                                  context: context,
                                  textEditingController: widget.logic
                                      .captionController,
                                  titleText: 'plus_3'.tr,
                                  hintText: 'plus_11'.tr,
                                  isLarge: true,
                                  needful: false,
                                  isFocus: true,
                                  onTap: () {
                                    _scrollToBottom();
                                  }


                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 4.h,),
                        Align(
                          child: Visibility(
                            visible: widget.logic.getVisibilaty(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(

                                  child: Container(
                                    width: 10.w,
                                    height: 10.w,
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (
                                        widget.logic.titleController.text
                                            .isNotEmpty &&

                                            widget.logic.captionController.text
                                                .isNotEmpty
                                        ) {
                                          Get.to(SecendForm(),
                                              arguments: [widget.logic]);
                                        } else {
                                          Constant.showMessege("plus_12".tr);
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              100)
                                      ),
                                      child: Stack(
                                        children: [
                                          SizedBox.expand(child: Image.asset(
                                              "assets/${F
                                                  .assetTitle}/images/save_bg.png")),
                                          Align(
                                            child: SvgPicture.asset("assets/${F
                                                .assetTitle}/images/save.svg"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  visible: widget.logic.getVisibilaty(),
                                ),
                                SizedBox(height: 1.h,),
                                Text("plus_13".tr, style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),

                        Align(
                          child: Visibility(
                            visible: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Visibility(

                                  child: Container(
                                    width: 10.w,
                                    height: 10.w,
                                    child: MaterialButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              100)
                                      ),
                                      child: Stack(
                                        children: [
                                          SizedBox.expand(child: Image.asset(
                                              "assets/${F
                                                  .assetTitle}/images/save_bg.png")),
                                          Align(
                                            child: Icon(Icons.cancel_outlined,
                                              color: Colors.white,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  visible: widget.logic.getVisibilaty(),
                                ),
                                SizedBox(height: 1.h,),
                                Text("Cancel".tr, style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h,)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}





