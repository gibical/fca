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

class EditProfilePage extends StatefulWidget {

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  DetailController detailController = Get.arguments[0];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(EditProfileLogic(detailController,detailController.id));
    final state = logic.state;
    dynamic details;
    switch(Get.arguments[1] as PostType){


      case PostType.image:
        // TODO: Handle this case.
        details =detailController.imageDetails;

      case PostType.video:
        // TODO: Handle this case.
        details =detailController.videoDetails;

      case PostType.audio:
        // TODO: Handle this case.
        details =detailController.musicDetails;

      case PostType.text:
        // TODO: Handle this case.
        details =detailController.textDetails;

    }

    logic.startPageFunction(details);
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      body: GetBuilder<EditProfileLogic>(
          init: logic,
          builder: (logic) {
            if (logic.isloading1.value) {
              return Center(child: CircularProgressIndicator());
            }
            return SafeArea(
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
                          Row(
                            children: [
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: "000033".toColor()
                                ),
                                margin: EdgeInsets.all(16),
                                child: MaterialButton(
                                    padding: EdgeInsets.all(8),
                                    onPressed: (){

                                      Get.back();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5000)
                                    ),
                                    child: Icon(Icons.arrow_back,color: Colors.white,)),

                              ),
                              Text("editprof_1".tr, style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
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
                                    "editprof_2".tr,
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
                          if((Get.arguments[1] as PostType)!=PostType.text)CustomTextFieldLogin(
                              isFalsePadding: true,
                              prefix: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "editprof_3".tr,
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
                          if((Get.arguments[1] as PostType)==PostType.text) CustomTextFieldPlusWidget(
                              context: context,
                              textEditingController:  logic
                                  .assetsDescreptionEditingController,
                              titleText: 'editprof_4'.tr,
                              hintText: 'editprof_5'.tr,isLarge: true,
                              needful: false,
                              isFocus: true,
                              onTap: (){
                              }


                          ),
                          SizedBox(height: 4.h,),
                          Text("editprof_6".tr,
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          CustomTDropDownPlusWidget(
                              models: [
                                "editprof_7".tr,
                                "editprof_8".tr
                              ],
                              context: context,
                              textEditingController: logic
                                  .isEditEditingController,

                              titleText: 'editprof_9'.tr,
                              hintText: 'editprof_10'.tr,
                              needful: false),

                          SizedBox(height: 4.h,),
                          Text("editprof_11".tr,
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          CustomTDropDownPlusWidget(
                              context: context,
                              textEditingController: logic.planController,

                              titleText: 'editprof_11'.tr,
                              hintText: 'editprof_12'.tr,
                              needful: false,
                              models: [
                                "editprof_13".tr,  "editprof_14".tr, "editprof_15".tr
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
                              Text("editprof_16".tr, style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                              CustomTextFieldPlusWidget(
                                  context: context,suffix:  Container(


                                child: Text("€",style: TextStyle(color: Colors.white,fontSize: 13.sp),),
                              ),
                                  textEditingController: logic.priceController,


                                  titleText: 'editprof_17'.tr,
                                  hintText: 'editprof_18'.tr,
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
                              Text("editprof_19".tr,
                                style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold),),
                              CustomTDropDownPlusWidget(
                                  models: [

                                    "editprof_20".tr,
                                    "editprof_21".tr,
                                    "editprof_22".tr,
                                    "editprof_23".tr,
                                  ],
                                  context: context,
                                  textEditingController: logic
                                      .subscrptionController,

                                  titleText: 'editprof_24'.tr,
                                  hintText: 'editprof_25'.tr,
                                  needful: false),
                            ],
                          ),
                          SizedBox(height: 4.h,),
                          if(logic.type == PostType.video) Text("editprof_27".tr,
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          if(logic.type ==
                              PostType.video) CustomTDropDownPlusWidget(
                              context: context,
                              textEditingController: logic.genreController,

                              titleText: 'editprof_27'.tr,
                              hintText: 'editprof_28'.tr,
                              needful: false,
                              models: [
                                "editprof_29".tr,
                                "editprof_30".tr,
                                "editprof_31".tr,
                                "editprof_32".tr,
                                "editprof_33".tr,
                                "editprof_34".tr,
                                "editprof_35".tr,
                                "editprof_36".tr,
                              ]),
                          if(logic.type == PostType.video) SizedBox(height: 3.h,),
                          if(logic.type == PostType.video)Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("editprof_37".tr, style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold),),
                              CustomTDropDownPlusWidget(
                                  models: Constant.languages,
                                  context: context,
                                  textEditingController: logic.languageController,

                                  titleText: 'editprof_38'.tr,
                                  hintText: 'editprof_39'.tr,
                                  needful: false),
                            ],
                          ),
                          if(logic.type == PostType.video)  SizedBox(height: 3.h,),
                          if(logic.type == PostType.video) CustomTextFieldLogin(
                              isFalsePadding: true,
                              prefix: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "editprof_40".tr,
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
                                    "editprof_41".tr,
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
                          SizedBox(height: 4.h,),

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
                                      "assets/json/Y8IBRQ38bK.json", height: 10.h) : Text("editprof_42".tr,
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

                                  Get.back();
                                },
                                child: Center(
                                  child: Text("editprof_43".tr,
                                    style: TextStyle(color: "83839C".toColor()),),
                                ),
                              )
                          ),

                          SizedBox(height: 30.h,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
      }),
    );
  }
}
