import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_config.dart';
import '../login/widgets/custom_text_field.dart';
import '../plus_section/widget/custom_plan_text_filed.dart';
import 'logic.dart';

class EditProfilePage extends StatelessWidget {

  DetailController detailController = Get.arguments[0];


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EditProfileLogic(detailController));
    final state = logic.state;

    return GetBuilder<EditProfileLogic>(
        init: logic,
        builder: (logic) {
      return Scaffold(
        backgroundColor: AppColor.primaryDarkColor,
        body: SafeArea(
          child: Stack(
            children: [
              Container(

                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: 16,
                      left: 16, right: 16
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Edit Asset", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 3.h,),
                      CustomTextFieldLogin(
                          isFalsePadding: true,
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Asset name".tr,
                                style:
                                TextStyle(
                                    color: "747491".toColor(), fontSize: 11.sp),
                              ),
                              Container(
                                height: 28,
                                width: 1.5,
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                color: AppColor.whiteColor.withOpacity(0.2),
                              ),
                            ],
                          ),
                          hintText: "",
                          editingController: logic.assetsEditingController,
                          context: context),
                      SizedBox(height: 4.h,),
                      CustomTextFieldLogin(
                          isFalsePadding: true,
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Asset Description".tr,
                                style:
                                TextStyle(
                                    color: "747491".toColor(), fontSize: 8.sp),
                              ),
                              Container(
                                height: 28,
                                width: 1.5,
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                color: AppColor.whiteColor.withOpacity(0.2),
                              ),
                            ],
                          ),
                          hintText: "",
                          editingController: logic
                              .assetsDescreptionEditingController,
                          context: context),
                      SizedBox(height: 4.h,),
                      Text("Is editable for others",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      CustomTDropDownPlusWidget(
                          models: [
                            "Yes",
                            "No"
                          ],
                          context: context,
                          textEditingController: logic
                              .isEditEditingController,

                          titleText: 'Check Forkability status',
                          hintText: 'Choose Language',
                          needful: false),

                      SizedBox(height: 4.h,),
                      Text("Choose Your Plan",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      CustomTDropDownPlusWidget(
                          context: context,
                          textEditingController: logic.planController,

                          titleText: 'Choose a plan',
                          hintText: 'Insert your title',
                          needful: false,
                          models: [
                            "Free", "Ownership", "Subscription"
                          ]),
                      if(logic.planController.text.contains(
                          "Ownership") || logic.planController.text.contains(
                          "Subscription")) SizedBox(height: 4.h,),

                      if(logic.planController.text.contains(
                          "Ownership") || logic.planController.text.contains(
                          "Subscription")) Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Price", style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          CustomTextFieldPlusWidget(
                              context: context,
                              textEditingController: logic.priceController,


                              titleText: 'Title',
                              hintText: 'Insert your Price',
                              needful: false),
                        ],
                      ),
                      if(logic.planController.text.contains(
                          "Subscription")) SizedBox(height: 4.h,),

                      if(logic.planController.text.contains(
                          "Subscription")) Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Subscription Period",
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          CustomTextFieldPlusWidget(
                              context: context,
                              textEditingController: logic
                                  .subscrptionController,


                              titleText: 'Title',
                              hintText: 'Insert Period',
                              needful: false),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      if(logic.type == PostType.video) Text("Select Genre",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),),
                      if(logic.type ==
                          PostType.video) CustomTDropDownPlusWidget(
                          context: context,
                          textEditingController: logic.planController,

                          titleText: 'Select Genre',
                          hintText: 'Insert your title',
                          needful: false,
                          models: [
                            "Free", "Ownership", "Subscription"
                          ]),
                      if(logic.type == PostType.video) SizedBox(height: 3.h,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Language", style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          CustomTDropDownPlusWidget(
                              models: Constant.languages,
                              context: context,
                              textEditingController: logic.languageController,

                              titleText: 'Select language',
                              hintText: 'Choose Language',
                              needful: false),
                        ],
                      ),
                      SizedBox(height: 3.h,),
                      if(logic.type == PostType.video) CustomTextFieldLogin(
                          isFalsePadding: true,
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "IMDB score".tr,
                                style:
                                TextStyle(
                                    color: "747491".toColor(), fontSize: 11.sp),
                              ),
                              Container(
                                height: 28,
                                width: 1.5,
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                color: AppColor.whiteColor.withOpacity(0.2),
                              ),
                            ],
                          ),
                          hintText: "",
                          editingController: logic.imdbScooreController,
                          context: context), SizedBox(height: 3.h,),
                      if(logic.type == PostType.video) CustomTextFieldLogin(
                          isFalsePadding: true,
                          prefix: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Production year".tr,
                                style:
                                TextStyle(
                                    color: "747491".toColor(), fontSize: 11.sp),
                              ),
                              Container(
                                height: 28,
                                width: 1.5,
                                margin: EdgeInsets.symmetric(horizontal: 3.w),
                                color: AppColor.whiteColor.withOpacity(0.2),
                              ),
                            ],
                          ),
                          hintText: "",
                          editingController: logic.imdbYeaerController,
                          context: context),
                      SizedBox(height: 30.h,)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                      color: "191b47".toColor(),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.sp),
                        topLeft: Radius.circular(15.sp),
                      ),
                      border: Border(
                          top: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 0.6),
                          left: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 0.8),

                          right: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                              width: 0.1)
                      )
                  ),

                  padding: EdgeInsets.all(16),
                  child: Column(

                    children: [
                      Container(
                          width: 100.w,
                          height: 6.h,
                          decoration: BoxDecoration(

                            color: AppColor.primaryLightColor,
                            borderRadius: BorderRadius.circular(100.sp),
                            border: Border(
                                top: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.6),
                                left: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.8),

                                right: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.1)
                            ),

                          ),

                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1000)
                            ),
                            onPressed: () {

                              logic.sendMainRequest();

                            },

                            child: Center(
                              child:logic.isloading.value ? Lottie.asset(
                                  "assets/json/Y8IBRQ38bK.json", height: 10.h) : Text("Update",
                                style: TextStyle(color: Colors.white),),
                            ),
                          )
                      ),

                      SizedBox(height: 3.h,),
                      Container(
                          width: 100.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: Color(0xff4E4E61).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100.sp),
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 0.6),
                                  left: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 0.8),

                                  right: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 0.1)
                              )
                          ),

                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1000)
                            ),
                            onPressed: () {

                            },
                            child: Center(
                              child: Text("Discard Changes",
                                style: TextStyle(color: "83839C".toColor()),),
                            ),
                          )
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
