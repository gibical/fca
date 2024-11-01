import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../channel/widgets/card_channel_widget.dart';

class YoutubeShareBottomSheet extends StatefulWidget {
  bool youtubeMode;

  DetailController detailController;

  YoutubeShareBottomSheet(this.detailController, this.youtubeMode);

  @override
  State<YoutubeShareBottomSheet> createState() =>
      _YoutubeShareBottomSheetState();
}

class _YoutubeShareBottomSheetState extends State<YoutubeShareBottomSheet> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.detailController.fetchChannels();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        init: widget.detailController,
        builder: (logic) {
          print('_YoutubeShareBottomSheetState.build = ${logic.externalAccountlist.length}');
          return SingleChildScrollView(
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
                      Text(!widget.youtubeMode
                          ? "details_23".tr
                          : "details_24".tr),
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
                if(widget.youtubeMode) Column(
                  children: [
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
                            "details_25".tr,
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
                              controller: logic.titleEditingController,
                              decoration:
                              InputDecoration(
                                border:
                                OutlineInputBorder(
                                  borderSide:
                                  BorderSide
                                      .none,
                                ),
                                hintText:
                                "details_26".tr,
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
                            "details_27".tr,
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
                              controller: logic.desEditingController,
                              decoration:
                              InputDecoration(
                                border:
                                OutlineInputBorder(
                                  borderSide:
                                  BorderSide
                                      .none,
                                ),
                                hintText:
                                "details_28".tr,
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
                      height: 1.h,
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text("details_29".tr),
                          Obx(() {
                            return CupertinoSwitch(
                              value: logic.isPrivateContent.value,
                              onChanged: (value) {
                                logic.isPrivateContent.value = value;
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),


                Builder(
                    builder: (context) {
                      bool _isEnabled = logic.isSeletedNow;
                      return Opacity(opacity: _isEnabled ? 1 : 0.5,
                        child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 16,
                              vertical: 8),
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: _isEnabled ? "1C1C23"
                                  .toColor()
                                  .withOpacity(0.75) : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: "597AFF".toColor(),

                              )
                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              logic.isSeletedNow = true;
                              logic.update();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text("details_30".tr, style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),);
                    }
                ),
                Builder(
                    builder: (context) {
                      bool _isEnabled = !logic.isSeletedNow;
                      return Opacity(opacity: _isEnabled ? 1 : 0.5,
                        child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 16,
                              vertical: 8),
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: _isEnabled ? "1C1C23"
                                  .toColor()
                                  .withOpacity(0.75) : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: "597AFF".toColor(),

                              )
                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              logic.isSeletedNow = false;
                              logic.update();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text("details_31".tr, style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),);
                    }
                ),
                if(!logic.isSeletedNow) Builder(
                    builder: (context) {
                      bool _isEnabled = true;
                      return Opacity(opacity: _isEnabled ? 1 : 0.5,
                        child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 16,
                              vertical: 8),
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: "26262e".toColor(),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showDialogPicker(context, logic);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                logic.isSeletedDate ? "${logic.dateTime
                                    .year}-${logic.dateTime.month}-${logic
                                    .dateTime.day}" : "details_32".tr,
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                            ),
                          ),
                        ),);
                    }
                ),
                if(!logic.isSeletedNow) Builder(
                    builder: (context) {
                      bool _isEnabled = true;
                      return Opacity(opacity: _isEnabled ? 1 : 0.5,
                        child: Container(
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 16,
                              vertical: 8),
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: "26262e".toColor(),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showDialogTimePicker(context, logic);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(logic.isSeletedDate
                                  ? "${logic.dateTime.hour}-${logic.dateTime
                                  .minute}"
                                  : "details_33".tr, style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),);
                    }
                ),
                SizedBox(
                  height: 3.h,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      children: [
                        Text(logic.isLoadingChannel.value
                            ? "details_34".tr
                            : (
                            widget.detailController.externalAccountlist.isEmpty
                                ? "details_35".tr
                                : "details_36".tr)),
                        logic.isLoadingChannel.value
                            ? Lottie.asset(
                            "assets/json/Y8IBRQ38bK.json", height: 4.h)
                            : Container()
                      ],
                    );
                  }),
                ),

                SizedBox(
                  height: 1.h,
                ),
                Column(
                  children: widget.detailController.externalAccountlist
                    //  .where((element) => element.type.toString().contains("1"))
                      .toList()
                      .asMap()
                      .entries
                      .map((e) {
                    var model = widget.detailController.externalAccountlist
                        .elementAt(e.key);

                    return CardChannelWidget2(//
                        title: (model.title ?? "").toString(),
                        date: (model.createdAt ?? ""),
                        isEnable: logic.enableChannel == e.key,
                        onTap: () {
                          logic.enableChannel = e.key;
                          logic.update();
                        });
                  }).toList(),
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
                      widget.detailController.onSendYouTubeRequest(
                          widget.youtubeMode);
                    },
                    color: Colors.black54,
                    child:  Text("details_38".tr),
                  ),
                )
              ],
            ),
          );
        });
  }

  void showDialogPicker(BuildContext context, DetailController controller) {
    var selectedDate = showDatePicker(
      context: context,
      helpText: 'details_37'.tr,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                // primary: MyColors.primary,
                primary: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                onPrimary: AppColor.primaryDarkColor,
                surface: "02063d".toColor(),
                onSurface: Colors.white,
              ),
              //.dialogBackgroundColor:Colors.blue[900],
            ),
            child: child!,
          ),
        );
      },
    );
    selectedDate.then((value) {
      controller.dateTime = value!;
      controller.isSeletedDate = true;
      controller.update();
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void showDialogTimePicker(BuildContext context, DetailController controller) {
    var selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                // primary: MyColors.primary,
                primary: Theme
                    .of(context)
                    .colorScheme
                    .primary,
                onPrimary: AppColor.primaryDarkColor,
                surface: "02063d".toColor(),
                onSurface: Colors.white,
              ),
              //.dialogBackgroundColor:Colors.blue[900],
            ),
            child: child!,
          ),
        );
      },
    );
    selectedTime.then((value) {
      controller.dateTime = controller.dateTime.copyWith(
        hour: value?.hour,
        minute: value?.minute,
      );
      controller.isSeletedDate = true;
      controller.update();
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
