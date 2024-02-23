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
  const FirstForm({super.key});

  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  PlusSectionLogic logic = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,

      body: Center(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                              
                              
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
                              
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              
                          children: [
                            IconButton(onPressed: () {
                              Get.back();
                            },
                                icon: Icon(Icons.arrow_back, color: "666680"
                                    .toColor(),)),
                            Text("Save \$ publish", style: TextStyle(color: Colors.white),),
                            Container(
                              width: 16.w,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                              
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title",style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),),
                          CustomTextFieldPlusWidget(
                              context: context,
                              textEditingController: logic.titleController,
                              
                              titleText: 'Title',
                              hintText: 'Insert your title',isLarge: true,
                              needful: false),
                        ],
                      ),
                  SizedBox(height: 4.h,),
                  Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Language",style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),),
                          CustomTDropDownPlusWidget(
                            models:Constant.languages,
                              context: context,
                              textEditingController: logic.languageController,
                  
                              titleText: 'Select language',
                              hintText: 'Choose Language',
                              needful: false),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                  
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Write a Caption",style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          CustomTextFieldPlusWidget(
                              context: context,
                              textEditingController: logic.captionController,
                  
                              titleText: 'Title',
                              hintText: 'Insert your Caption',isLarge: true,
                              needful: false),
                        ],
                      ),

                      SizedBox(height: 4.h,),
                      Align(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              child: MaterialButton(
                                onPressed: (){
                                  if(
                                  logic.titleController.text.isNotEmpty&&
                                  logic.languageController.text.isNotEmpty&&
                                  logic.captionController.text.isNotEmpty
                                  ){
                                    Get.to(SecendForm(),arguments: [logic]);
                                  }else{
                                    Constant.showMessege("Please fill out the form first");
                                  }
                                },
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)
                                ),
                                child: Stack(
                                  children: [
                                    SizedBox.expand(child: Image.asset("assets/images/save_bg.png")),
                                    Align(
                                      child: SvgPicture.asset("assets/images/save.svg"),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h,),
                            Text("Save",style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold
                            ),)
                          ],
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
    );

  }
}
