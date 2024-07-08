import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:gibical/app/common/app_extension.dart';
import 'package:gibical/gen/model/json/FromJsonGetExternalAccount.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/font_style.dart';
import '../massage/single_view.dart';
import 'logic.dart';

class ShareAccountPage extends StatelessWidget {
  final logic = Get.put(ShareAccountLogic());
  final state = Get.find<ShareAccountLogic>();
  bool isSendedByCondactor =
      (Get.arguments != null && Get.arguments[0] == "onTapChannelManagement");

  bool upcomingWidget = Get.arguments != null;

  @override
  Widget build(BuildContext context) {
    print('ShareAccountPage.build = ${isSendedByCondactor}');
    return Obx(() {
      if (logic.isloading.value) {
        return Scaffold(
          backgroundColor: AppColor.blueDarkColor,
          body: Container(
            child: Center(
              child: Lottie.asset("assets/json/Y8IBRQ38bK.json", height: 10.h),
            ),
          ),
        );
      } else {
        return GetBuilder<ShareAccountLogic>(
            init: logic,
            builder: (logics) {
              var list = logics.list;
              try {
                print('ShareAccountPage.build = ${upcomingWidget}');
                if (upcomingWidget) {
                  String filter = Get.arguments[1];

                  list = logics.list
                      .where(
                          (element) => element.type.toString().contains(filter))
                      .toList();
                }
              } catch (e) {
                // TODO
              }
              return Scaffold(
                backgroundColor: AppColor.blueDarkColor,
                appBar: AppBar(
                  toolbarHeight: 80,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: SvgPicture.asset(AppIcon.backIcon)),
                  title: Text(
                    'share_27'.tr,
                    style: FontStyleApp.titleMedium
                        .copyWith(color: AppColor.whiteColor),
                  ),
                ),
                body:
                     Stack(
                        children: [
              list.isEmpty
              ?    Container(
                              padding: EdgeInsets.zero,
                              child: Center(child: Text("messege_3".tr))):  SizedBox.expand(
                            child: CustomScrollView(
                              slivers: [
                                SliverList.builder(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return MassageItemWidget(
                                          list.elementAt(index));
                                    }),
                              ],
                            ),
                          ),
                          if(!isSendedByCondactor)Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                width: 100.w,
                                height: 9.h,
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
                                    )),
                                child: Stack(
                                  children: [
                                    Align(
                                      child: Container(
                                        width: 80.w,
                                        height: 5.h,
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          color: "6f6e8e".toColor(),
                                          radius: Radius.circular(12),
                                          strokeWidth: 2,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                onPressed: () {
                                                  logic.showAccountType();
                                                },
                                                padding: EdgeInsets.zero,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "share_28".tr,
                                                        style: TextStyle(
                                                            color: "6f6e8e"
                                                                .toColor(),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color:
                                                            "6f6e8e".toColor(),
                                                        size: 11.sp,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
              );
            });
      }
    });
  }

  Padding MassageItemWidget(ExternalAccountModel elementAt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isSendedByCondactor
            ? () {
                Get.find<ShareAccountLogic>().setSelectedChannel(elementAt);

                Get.back();
              }
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Container(
          height: 8.5.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xff4E4E61).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.sp),
              border: Border(
                left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                bottom:
                    BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.4),
              )),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${elementAt.title}',
                            style: FontStyleApp.bodyMedium
                                .copyWith(color: Colors.white),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Text(
                        elementAt.createdAt ?? "",
                        style: FontStyleApp.bodyMedium.copyWith(
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isSendedByCondactor)
                IconButton(
                    onPressed: () {
                      logic.list.remove(elementAt);
                      logic.update();
                      logic.deleteModel(elementAt);
                    },
                    icon: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
