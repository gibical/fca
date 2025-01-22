import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/detail/widgets/back_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/live/logic.dart';
import 'package:mediaverse/app/pages/live/widgets/custom_video_live_widget.dart';
import 'package:sizer/sizer.dart';
import '../../common/app_route.dart';
import '../home/logic.dart';
import '../home/widgets/bset_item_explore_widget.dart';

class LiveScreen extends StatefulWidget {
  LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  HomeLogic logic = Get.find<HomeLogic>();

  LiveController liveController = Get.put(
      LiveController(), tag: "time_${DateTime
      .now()
      .millisecond}");

  late Widget videoWidget;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print(
          '_LiveScreenState.initState = ${liveController.liveDetails?['link'] ??
              ''}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    liveController.controllerVideoPlay.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return liveController.isLoadingLive.value
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Stack(
            children: [
              CustomScrollView(
                      slivers: [

              SliverToBoxAdapter(
                child: SizedBox(
                  child: Column(
                    children: [

                    VideoLiveWidget(
                    videoUrl: liveController.liveDetails?['current_url'] ?? '',
                      liveController: liveController,),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.sp),
                              child: SizedBox(
                                height: 5.h,
                                width: 10.w,
                                child: Image.asset(
                                  "assets/mediaverse/images/mainLogo.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              liveController.liveDetails?['name'] ?? '',
                              style: Theme
                                      .of(context)
                                      .textTheme.bodySmall?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.2.w),
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if(liveController.isLoadingRecord.value)Lottie.asset(
                                  "assets/${F.assetTitle}/images/record.json"),
                              if(!liveController.isLoadingRecord.value) IconButton(
                                onPressed: () {

                                  if(!liveController.isLoadingRecord.value){
                                    showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                              return Container(
                                                height: 55.h,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryDarkColor
                                                      .withOpacity(0.5),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(20.sp),
                                                    topRight: Radius.circular(20.sp),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: <Widget>[
                                                    SizedBox(height: 4.h),
                                                    Text('libe_1'.tr,
                                                      style: Theme
                                      .of(context)
                                      .textTheme.bodySmall?.copyWith(
                                                          fontSize: 19,
                                                          color: AppColor
                                                              .primaryDarkColor
                                                      ),),
                                                    SizedBox(height: 4.h),
                                                    for (int index = 0; index <
                                                        liveController.titles
                                                            .length; index++)
                                                      CustomItemRecordBottomSheet(
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width,
                                                        isSelected: liveController
                                                            .selectedIndex == index,
                                                        onTap: () {
                                                          setState(() {
                                                            liveController
                                                                .selectedIndex =
                                                                index;
                                                          });
                                                        },
                                                        title: liveController
                                                            .titles[index],
                                                      ),

                                                    Spacer(),
                                                    Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 5.w,
                                                            vertical: 1.h),
                                                        child: Obx(() {
                                                          return SizedBox(
                                                            height: 60,
                                                            width: double.infinity,
                                                            child: ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10.sp),
                                                                  ),
                                                                  backgroundColor: AppColor
                                                                      .primaryLightColor,
                                                                ),
                                                                onPressed: () {
                                                                  liveController
                                                                      .postTimeRecord(
                                                                      liveController
                                                                          .liveDetails?['id']);
                                                                },
                                                                child: liveController
                                                                    .isLoadingRecord
                                                                    .value
                                                                    ? CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,)
                                                                    : Text(
                                                                  'libe_2'.tr,
                                                                  style: GoogleFonts
                                                                      .inter(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 15
                                                                  ),)
                                                            ),
                                                          );
                                                        })
                                                    ),
                                                    SizedBox(height: 2.h),
                                                  ],
                                                ),
                                              );
                                            }
                                        );
                                      },
                                    );
                                  }
                                },
                                icon:
                                Image.asset(AppIcon.recIcon,
                                  scale: 5.5, color:
                                  Colors.white,),
                              ),

                              IconButton(onPressed: () {
                                liveController.takeScreenShot();
                                liveController.controllerVideoPlay.pause();
                              },
                                  icon: Image.asset(
                                    AppIcon.screenshotIcon, scale: 5.8,
                                    color: Colors.white,)
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.5.w,
                        ),
                        child: Text(
                          'libe_3'.tr,
                          style: Theme
                                      .of(context)
                                      .textTheme.bodySmall?.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 21.h,
                        child: ListView.builder(
                            itemCount: logic.channels.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _sendtoNewPage(index);
                                },
                                child: BestChannelsWidget(
                                    model: logic.channels.elementAt(index)),
                              );
                            }),
                      )
                    ],
                  )),
                      ],
                    ),
              BackWidget()
            ],
          );
    }));
  }

  void _sendtoNewPage(index) async {
    final channelId = logic.channels[index].id;
    liveController.controllerVideoPlay.pause();
    await Get.toNamed(PageRoutes.LIVE,
        arguments: {'channelId': channelId}, preventDuplicates: false);
    liveController.controllerVideoPlay.play();
  }
}


class CustomItemRecordBottomSheet extends StatelessWidget {
  const CustomItemRecordBottomSheet({
    Key? key,
    required this.title,
    required this.width,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final double width;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool selected = isSelected;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Container(
          height: 60,
          width: width,
          decoration: BoxDecoration(
            color: selected
                ? AppColor.whiteColor.withOpacity(0.4) : AppColor
                .blueDarkColor.withOpacity(0.1)
            ,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$title ${"libe_4".tr}',
              style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
