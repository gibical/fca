import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/utils/data_state.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class ReportBottomSheet extends StatelessWidget {


  DetailController detailController;

  ReportBottomSheet(this.detailController);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        init: detailController,
        builder: (logic) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),

          ),
          color: "1a1a48".toColor()
        ),
        height: 40.h,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                   Text("details_14".tr),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    child:  Text(
                      "details_2".tr,
                      style: TextStyle(
                        color:
                        Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 6.h,
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      10),
                  color: Colors.black54),
              child: Row(
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                   Text(
                    "details_6".tr,
                    style: TextStyle(
                        color:
                        Colors.white54),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                    height: 28,
                    width: 1.5,
                    color: AppColor
                        .whiteColor
                        .withOpacity(0.2),
                  ),
                   Expanded(
                    child: TextField(
                      controller: logic.reportEditingController,
                      decoration:
                      InputDecoration(
                        border:
                        OutlineInputBorder(
                          borderSide:
                          BorderSide
                              .none,
                        ),
                        hintText:
                        "details_15".tr,
                        hintStyle:
                        TextStyle(
                          color: Colors
                              .white60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 6.h,
            ),


            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 5.h,
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 5.h,
                shape:
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                        100)),
                onPressed: () async {
                  Get.back();
                  detailController.reportPost();


                },
                color: "5979fe".toColor(),
                child:  Text("details_6".tr),
              ),
            )
          ],
        ),
      );
    });
  }


}


class ReportBottomSheet2 extends StatelessWidget {
  final DetailController detailController;

  ReportBottomSheet2(this.detailController);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Obx(() {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            color: "#0F0F26".toColor(),
          ),
          height: 85.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                                'assets/mediaverse/icons/arrow.svg'),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 24),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView.builder(

                        padding: EdgeInsets.only(bottom: 20.h),
                        itemCount: detailController.reportOptions.length,
                        itemBuilder: (context, index) {
                          final isSelected = detailController.selectedReportOption?.value == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    setState(() {
                                      detailController.  selectedReportOption!.value = index;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? '2563EB'.toColor()
                                                : '9C9CB8'.toColor(),
                                            width: isSelected ? 5.5 : 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        detailController.reportOptions[index],
                                        style: TextStyle(color: isSelected ?Colors.white:Colors.white60),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: TextField(
                                      controller: detailController.reportEditingController,
                                      style: TextStyle(
                                        decorationColor: Colors.transparent,
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,


                                        hintText: 'Description',
                                        fillColor: '#17172E'.toColor(),
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      '0F0F26'.toColor(),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: '0F0F26'.toColor(),
                      blurRadius: 50,
                      spreadRadius: 30,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Material(
                        color: '2563EB'.toColor(),
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          splashColor: Colors.white.withOpacity(0.03),
                          onTap: () {
                            detailController.reportPost();
                            Get.back();
                          },
                          child: Center(
                            child: Obx((){
                              if(detailController.loadingReportDataSate.value.status == Status.loading){
                       
                                return  Transform.scale(
                                  scale: .5,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: Colors.white.withOpacity(0.5),
                                  ),
                                );
                              }else{
                                return Text('Submit');
                              }
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },);
  }
}
class CommentReportBottomSheet extends StatelessWidget {
  final DetailController detailController;
  final id;


  CommentReportBottomSheet(this.detailController,this.id);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Obx(() {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            color: "#0F0F26".toColor(),
          ),
          height: 85.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                                'assets/mediaverse/icons/arrow.svg'),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 24),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Expanded(
                      child: ListView.builder(

                        padding: EdgeInsets.only(bottom: 20.h),
                        itemCount: detailController.reportOptions.length,
                        itemBuilder: (context, index) {
                          final isSelected = detailController.selectedReportOption?.value == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    setState(() {
                                      detailController.  selectedReportOption!.value = index;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? '2563EB'.toColor()
                                                : '9C9CB8'.toColor(),
                                            width: isSelected ? 5.5 : 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        detailController.reportOptions[index],
                                        style: TextStyle(color: isSelected ?Colors.white:Colors.white60),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: TextField(
                                      controller: detailController.reportEditingController,
                                      style: TextStyle(
                                        decorationColor: Colors.transparent,
                                        decoration: TextDecoration.none,
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,


                                        hintText: 'Description',
                                        fillColor: '#17172E'.toColor(),
                                        contentPadding:
                                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      '0F0F26'.toColor(),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: '0F0F26'.toColor(),
                      blurRadius: 50,
                      spreadRadius: 30,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Material(
                        color: '2563EB'.toColor(),
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          splashColor: Colors.white.withOpacity(0.03),
                          onTap: () {
                            detailController.reportComment(id,detailController.selectedReportOption,detailController.reportEditingController);
                            Get.back();
                          },
                          child: Center(
                            child: Obx((){
                              if(detailController.loadingReportDataSate.value.status == Status.loading){

                                return  Transform.scale(
                                  scale: .5,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: Colors.white.withOpacity(0.5),
                                  ),
                                );
                              }else{
                                return Text('Submit');
                              }
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },);
  }
}

