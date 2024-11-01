import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
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
