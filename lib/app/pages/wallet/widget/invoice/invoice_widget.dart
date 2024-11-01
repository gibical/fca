import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/font_style.dart';
import '../../../profile/logic.dart';
import '../../../transactions/view.dart';
import '../../../wrapper/logic.dart';

class InvoiceWidget extends StatelessWidget {
  ProfileControllers logic;

  InvoiceWidget(this.logic);

  @override
  Widget build(BuildContext context) {
    String processName(String title) {
      String processedTitle =
          title.length > 10 ? '${title.substring(0, 10)} ...' : title;

      return processedTitle;
    }

    return GetBuilder<ProfileControllers>(
        init: logic,
        builder: (logic) {
          return Obx(() {
            return (logic.isloading.value || logic.isloadingWallet.value)
                ? Scaffold(
                    backgroundColor: AppColor.blueDarkColor,
                    body: Container(
                      child: Center(
                        child: Lottie.asset("assets/json/Y8IBRQ38bK.json",
                            height: 10.h),
                      ),
                    ),
                  )
                : Scaffold(
                    body: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: Visibility(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 3.h,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: logic.invoiceModel
                                          .asMap()
                                          .entries
                                          .map((s) {
                                        return Container(
                                          width: 100.w,
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(15.sp),
                                              border: Border.all(
                                                  color: AppColor.grayLightColor
                                                      .withOpacity(0.1))),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 10),
                                          padding: EdgeInsets.all(5.w),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Type: " +
                                                          "${s.value.relationType.toString()}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11.sp),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "Amount: " +
                                                          "${(double.parse(s.value.amount.toString()) / 100).toString()} €",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11.sp),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                              Column(

                                                children: [
                                                  if (!s.value.status
                                                      .toString()
                                                      .contains("open"))
                                                    Text(
                                                      "Action :" + "Paied",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                  if (s.value.status
                                                      .toString()
                                                      .contains("open"))
                                                    Row(children: [
                                                      Text(
                                                        "Action :  ",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5)),
                                                      ),
                                                      Container(
                                                        width: 16.w,
                                                        height: 3.h,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppColor
                                                                    .primaryDarkColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: MaterialButton(
                                                          onPressed: () {
                                                            logic.getInvoiceBylink(s.value.id.toString());
                                                          },
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: Center(
                                                            child: Text(
                                                              "Pay",
                                                              style: TextStyle(
                                                                  color: AppColor
                                                                      .primaryDarkColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                      ),
                                                    ]),
                                                  Text(
                                                    "Date : " +
                                                        DateTime.parse(s
                                                                .value.createdAt
                                                                .toString())
                                                            .toLocal()
                                                            .toFormattedDateString(),
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.5)),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                            visible: logic.invoiceModel.isNotEmpty,
                          ),
                        ),
                        Visibility(
                          child: Column(
                            children: [
                              Text(
                                "This list is Empty",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                              Container(
                                  width: 60.w,
                                  height: 25.h,
                                  child:
                                      Lottie.asset("assets/json/empty.json")),
                            ],
                          ),
                          visible: logic.invoiceModel.isEmpty,
                        ),
                        SizedBox(
                          height: 39.h,
                        ),
                      ],
                    ),
                  ));
          });
        });
  }
}
