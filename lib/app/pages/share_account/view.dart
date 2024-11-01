import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/gen/model/json/walletV2/FromJsonGetDestination.dart';
import 'package:mediaverse/gen/model/json/walletV2/FromJsonGetExternalAccount.dart';
import 'package:mediaverse/gen/model/json/walletV2/FromJsonGetPrograms.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetExternalAccount.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../../common/app_icon.dart';
import '../../common/font_style.dart';
import '../massage/single_view.dart';
import 'logic.dart';

class ShareAccountPage extends StatefulWidget {

  @override
  State<ShareAccountPage> createState() => _ShareAccountPageState();
}

class _ShareAccountPageState extends State<ShareAccountPage>      with SingleTickerProviderStateMixin {
  final ShareAccountLogic logic = Get.put(ShareAccountLogic());
  late TabController _tabController;
  int _selectedTabIndex = 0;


  bool isSendedByCondactor =
  (Get.arguments != null && Get.arguments[0] == "onTapChannelManagement");

  bool upcomingWidget = Get.arguments != null;//

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        toolbarHeight: 40,
        centerTitle: true,
        title: Container(
          margin: EdgeInsets.only(right: 10.w),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 20),
                child: Text(
                  'share_27'.tr,
                  style: FontStyleApp.titleMedium.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60.sp),
                  bottomLeft: Radius.circular(60.sp),
                ),
              ),
              height: 60,
              child: TabBar(
                tabAlignment: TabAlignment.center,
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                enableFeedback: false,
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.primaryLightColor,
                unselectedLabelColor: Colors.grey,
                labelColor: AppColor.primaryLightColor,
                dividerColor: Colors.transparent,
                tabs: [
                  _buildTab(context, 0, 'Stream'.tr),
                  _buildTab(context, 1, 'Share'.tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  getAcoountStream(),
                  getAcoountShare(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, int tabIndex, String label) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(label,style: TextStyle(fontSize: 14.sp),)],
      ),
    );
  }

  Widget getAcoountStream(){
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

              var list = logics.destinationModelList;
              print('ShareAccountPage.build 1 = ${isSendedByCondactor} - ${ list.length}');
              try {
                print('ShareAccountPage.build = ${upcomingWidget}');
                // if (upcomingWidget) {
                //   String filter = Get.arguments[1];
                //
                //   list = logics.destinationModelList
                //       .where(
                //           (element) => element.name.toString().contains(filter))
                //       .toList();
                // }
              } catch (e) {
                // TODO
              }
              return Scaffold(
                backgroundColor: AppColor.blueDarkColor,
                body:
                Container(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Stack(
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
                                  print('ShareAccountPage.build 2 = ${isSendedByCondactor} - ${ list.length}');

                                  return MassageItemWidgetDestination(
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
                                              logic.showRTSPform();
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
                      ),
                      if(isSendedByCondactor)Align(
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
                                             Get.back();
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
                                                    "Add to Destination".tr,
                                                    style: TextStyle(fontSize: 13.sp,
                                                        color: "6f6e8e"
                                                            .toColor(),
                                                    ),
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
                      ),

                    ],
                  ),
                ),
              );
            });
      }
    });
  }
  Widget getAcoountShare(){
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
              var list = logics.externalList;
              try {
                print('ShareAccountPage.build = ${upcomingWidget}');
                // if (upcomingWidget) {
                //   String filter = Get.arguments[1];
                //
                //   list = logics.externalList
                //       .where(
                //           (element) => element.title.toString().contains(filter))//
                //       .toList();
                // }
              } catch (e) {
                // TODO
              }
              return Scaffold(
                backgroundColor: AppColor.blueDarkColor,
                body:
                Container(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Stack(
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
                                  return MassageItemWidgetShare(
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
                      ),


                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  Padding MassageItemWidget(ProgramModel elementAt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isSendedByCondactor
            ? () {
          print('_ShareAccountPageState.MassageItemWidget = 1');

          Get.find<ShareAccountLogic>().setSelectedChannel(elementAt);
                Get.find<ShareAccountLogic>().selectShareMode = SelectShareMode.stream;
                Get.find<ShareAccountLogic>().selectShareModelName = elementAt.name??"";
                Get.find<ShareAccountLogic>().selectShareModeid = elementAt.id??"";

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
                            '${elementAt.name}',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type: Youtube",
                            style: FontStyleApp.bodyMedium.copyWith(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            "Connected: on",//
                            style: FontStyleApp.bodyMedium.copyWith(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                        ],
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
  Padding MassageItemWidgetShare(ExternalModel elementAt) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isSendedByCondactor
            ? () {

          Get.find<ShareAccountLogic>().setSelectedShareChannel(elementAt);
                Get.find<ShareAccountLogic>().selectShareMode = SelectShareMode.share;

          Get.find<ShareAccountLogic>().selectShareModelName = elementAt.title??"";
          Get.find<ShareAccountLogic>().selectShareModeid = elementAt.id??"";
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type: Youtube",
                            style: FontStyleApp.bodyMedium.copyWith(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            "Connected: on",//
                            style: FontStyleApp.bodyMedium.copyWith(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ),
                        ],
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
                      logic.deleteShareModel(elementAt);
                    },
                    icon: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
  Padding MassageItemWidgetDestination(DestinationModel elementAt) {
    bool _isSelected = logic.getactiveDestinationModel(elementAt);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.6.h),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isSendedByCondactor
            ? () {



          Get.find<ShareAccountLogic>().setSelectedDestiniation(elementAt);
          Get.find<ShareAccountLogic>().selectShareMode = SelectShareMode.stream;
          Get.find<ShareAccountLogic>().selectShareModelName = elementAt.name??"";
          Get.find<ShareAccountLogic>().selectShareModeid = elementAt.id??"";
               //  Get.back();
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
              border:_isSelected?Border.all(color: Colors.white): Border(
                left: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
                bottom:
                    BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.4),
              )),
          child: Row(
            children: [
              Expanded(
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
                                  '${elementAt.name}',
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type: Youtube",
                                  style: FontStyleApp.bodyMedium.copyWith(
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                ),
                               
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ( _isSelected)?Checkbox(value: true, onChanged: (s){}):Container(),
                        Text(
                          "Connected: on",//
                          style: FontStyleApp.bodyMedium.copyWith(
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 4.w,)
                  ],
                ),
              ),
              if (!isSendedByCondactor)
                IconButton(
                    onPressed: () {
                      logic.list.remove(elementAt);
                      logic.update();
                      logic.deleteDestinationModel(elementAt);
                    },
                    icon: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
