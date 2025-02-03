import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsLive.dart';
import 'package:sizer/sizer.dart';

import '../../../../tab/ChannalLiveController.dart';
import '../../../../widgets/ChannelVideoLiveWidget.dart';
import '../live_empty_state.dart';

class ChannelLiveTab extends StatefulWidget {
  const ChannelLiveTab({super.key});

  @override
  State<ChannelLiveTab> createState() => _ChannelLiveTabState();
}

class _ChannelLiveTabState extends State<ChannelLiveTab> {
  MyChannelController logic = Get.find<MyChannelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 3.h),
        child: (logic.livemodels.isEmpty && logic.lastEvent.isEmpty)
            ? LiveEmptyState()
            : Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                //  color: Colors.red,
                child: GetBuilder<MyChannelController>(
                    init: logic,
                    builder: (logics) {
                      return Stack(
                        children: [
                          Container(
                            child: GetBuilder<
                                ChannelMainVideoLiveController>(
                              builder: (channelMainVideoLiveController) {
                                if (logic.isChannelLiveStarted.isFalse) {
                                  return Container(
                                    height: 20.h, child: Center(
                                    child: Text(
                                        "Live is Not Available Right Now"),
                                  ),);
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ChannelMainVideoLiveWidget(
                                        logic.mainChannelModel.url ?? ""),
                                Text(
                                "${logics.mainChannelModel.program!.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp),),

                                  ],
                                );
                              },
                              tag:
                              "live-${logic.mainChannelModel.id}",
                              init:
                              ChannelMainVideoLiveController(
                                  logic.mainChannelModel.url ??
                                      ""),
                            ),
                            key: logic.mainLiveKey,
                          )
                        ],
                      );
                    }),
                key: ValueKey(
                    "${DateTime
                        .now()
                        .millisecondsSinceEpoch}"),
              ),

              /*Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 100.w,
                            height: 20.h,
                            child: Stack(
                              children: [
                                SizedBox.expand(child: Image.asset("assets/all/images/live_sample.png",fit: BoxFit.cover,)),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.all(3.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("8:24:02"),
                                        Container(
                                          width: 10.w,

                                          height: 2.h,
                                          decoration: BoxDecoration(
                                            color: "#B71D18".toColor(),
                                            borderRadius: BorderRadius.circular(2)
                                          ),
                                          child: Center(
                                            child: Text("Live",style: TextStyle(fontSize: 8.sp),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                        SizedBox(height: 1.h,),
                        Text("Bring Nature to Life, Live!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp),)
                      ],
                    ),*/

              SizedBox(height: 3.h,),
              Text("my_channel_6".tr, style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13.sp),),
              Text("my_channel_7".tr, style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 9.sp,
                  color: "#9C9CB8".toColor()),),
              SizedBox(height: 2.h,),

              Expanded(child: GetBuilder<MyChannelController>(
                  init: logic,
                  builder: (logic) {
                    return GridView.builder(

                        itemBuilder: (s, i) {
                          LiveModel model = logic.livemodels.elementAt(i);
                          return (model
                              .program != null) ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 14.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        SizedBox.expand(
                                            child: Container(
                                              key: ValueKey(
                                                  "live - ${model.id}"),
                                              child:
                                              ChannelVideoLiveWidget(
                                                videoUrl:
                                                model.url ??
                                                    "",
                                                title: model
                                                    .program!.name ??
                                                    "",
                                                liveID:
                                                model.id ??
                                                    "",
                                                onSwitch: (String liveID) {
                                                  // logic.switchTo(liveID);
                                                },
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: 7.w,
                                            height: 7.w,
                                            margin: EdgeInsets.all(3.w),
                                            child: MaterialButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  logic.switchTo(
                                                      model.id.toString());
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(5)
                                                ),
                                                child: Container(
                                                    width: 7.w,
                                                    height: 7.w,
                                                    child: SvgPicture.asset(
                                                      "assets/all/icons/switch_channels.svg",))),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                Text(model
                                    .program!.name ?? "", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp),)

                              ],
                            ),
                          ) : Container();
                        },
                        itemCount: logic.livemodels.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,));
                  })),

               GetBuilder<
                  MyChannelController>(
                  init: logic,
                  builder: (logic) {
                return Visibility(
                  visible: (logic.mainChannelModel.program != null),
                  child: Container(
                    width: 100.w,
                    height: 6.h,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    decoration: BoxDecoration(
                        color: "#b71d18".toColor(),
                        borderRadius: BorderRadius.circular(500)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        logic.onStopPressed();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500)),
                      child: Center(
                        child: Center(
                          child: Text("my_channel_8".tr,
                            style: TextStyle(fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                  ),
                );
              })

            ],
          ),
        ),
      ),
    );
  }
}
