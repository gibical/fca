import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/detail/widgets/report_botton_sheet.dart';
import 'package:mediaverse/app/pages/detail/widgets/youtube_bottomsheet.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_config.dart';
import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../../common/utils/duraton_music_helper.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';

class DetailMusicScreen extends StatelessWidget {
  final controller = Get.put(DetailController(),
      tag: "${DateTime.now().microsecondsSinceEpoch}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      bottomNavigationBar: Obx(() {
        if (controller.isLoadingMusic.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (controller.musicDetails != null &&
              controller.musicDetails!.containsKey('asset') &&
              controller.musicDetails!['asset'] != null &&
              controller.musicDetails!['asset'].containsKey('plan')) {
            int plan = controller.musicDetails!['asset']['plan'];
            print(plan);
            if (plan == 1) {
              return SizedBox();
            } else if ((plan == 2 || plan == 3)&&(!controller.asset_id.contains(GetStorage().read("userid")))) {
              return BuyCardWidget(
                  selectedItem: controller.musicDetails,
                  title: "${controller.asset_id.contains(GetStorage().read("userid"))}",
                  price: controller.musicDetails!['asset']['price']);
            } else {
              return SizedBox();
            }
          } else {
            return SizedBox();
          }
        }
      }),
      body: Obx(() {
        return controller.isLoadingMusic.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
              children: [
                CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            Container(
                              height: 42.5.h,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(40.sp),
                                    bottomLeft: Radius.circular(40.sp),
                                  ),
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.white.withOpacity(0.2)))),
                            ),
                            Positioned(
                                top: 5.5.h,
                                left: 3.w,
                                child: IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: SvgPicture.asset(AppIcon.backIcon))),
                            Positioned(
                              top: 2.h,
                              left: 0.w,
                              right: 0,
                              bottom: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: SizedBox(
                                  width: 48.w,
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 44.w,
                                          height: 22.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.1),
                                              border: Border.symmetric(
                                                  horizontal: BorderSide(
                                                width: 0.9,
                                                color: Colors.white.withOpacity(
                                                  0.2,
                                                ),
                                              )),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.sp))),
                                          child: GestureDetector(
                                            onTap: (){
                                              try {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return VideoDialog(videoUrl: controller.musicDetails!['file']?['url'],controller: controller,);
                                                    });
                                              }  catch (e) {
                                                // TODO
                                              }
                                            },
                                            child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                              if(controller.musicDetails!['thumbnails']
                                              !=null)  SizedBox.expand(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(20.sp),
                                                    child: (controller.musicDetails!
                                                    ['thumbnails']
                                                                .toString()
                                                                .length >
                                                            3)
                                                        ? Image.network(
                                                            "${controller.musicDetails?['thumbnails']['336x366']}",
                                                            fit: BoxFit.cover)
                                                        : Image.asset(
                                                            "assets/images/tum_sound.jpeg",
                                                            fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Container(
                                                  width: 50.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20.sp)),
                                                      gradient: LinearGradient(
                                                          begin:
                                                              Alignment.bottomCenter,
                                                          end: Alignment.topCenter,
                                                          colors: [
                                                            Colors.black
                                                                .withOpacity(0.6),
                                                            Colors.black
                                                                .withOpacity(0.4),
                                                            Colors.transparent,
                                                          ])),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 15, bottom: 10),
                                                  child: SvgPicture.asset(
                                                      "assets/icons/sound_vector.svg",
                                                      color: AppColor.grayLightColor
                                                          .withOpacity(0.5),
                                                      height: 1.8.h),
                                                )
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        '${controller.musicDetails?['name']}',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: controller.musicDetails?['name']
                                                      .length >
                                                  15
                                              ? 16
                                              : 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.3.h,
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 3.w,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                                (controller.musicDetails!
                                                                ['user']['username']
                                                            .toString()
                                                            .length >
                                                        10)
                                                    ? controller
                                                            .musicDetails!
                                                                ['user']['username']
                                                            .toString()
                                                            .substring(0, 10) +
                                                        '...'
                                                    : controller
                                                            .musicDetails?
                                                        ['user']['username'],
                                                style: GoogleFonts.inter(
                                                  color:
                                                      Colors.white.withOpacity(0.5),
                                                  fontSize: 13,
                                                )),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: (){
                                                Get.bottomSheet(ReportBottomSheet(controller));
                                              },
                                              child: Text('Report',
                                                  style: GoogleFonts.inter(
                                                    color:
                                                        Colors.white.withOpacity(0.5),
                                                    fontSize: 13,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Text(
                                    '${controller.musicDetails?['description']}',
                                    style: GoogleFonts.inter(
                                        fontSize: 14.5,
                                        color: Colors.white.withOpacity(0.5))),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        controller.sendShareYouTube();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/icon__video-white.svg",
                                        width: 6.w,
                                      )),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.soundConvertToText();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/icon__single-convert-to-text.svg",
                                        width: 6.w,
                                      )),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        controller.soundTranslate();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/icon__single-tranlate.svg",
                                        width: 6.w,
                                      )),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),

                              Wrap(
                                children: [
                                  //
                                  CardMarkSinglePageWidget(label: 'Suffix', type: "Somethi"),
                                  CardMarkSinglePageWidget(label: 'Type', type: "Sound"),
                         //         CardMarkSinglePageWidget(label: 'Type', type: controller.musicDetails!['url']),

                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              GetBuilder<DetailController>(
                                builder: (context) {
                                  if (controller.musicDetails != null &&
                                      controller.musicDetails!['asset'] != null &&
                                      controller.musicDetails!['asset']['plan'] ==
                                          1) {
                                    return Container(
                                        height: 15.5.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColor.whiteColor
                                                .withOpacity(0.1),
                                            border: Border(
                                                right: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    width: 0.9),
                                                bottom: BorderSide(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    width: 0.4)),
                                            borderRadius:
                                                BorderRadius.circular(14.sp)),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: SliderTheme(
                                                data: SliderThemeData(
                                                  thumbColor:
                                                      AppColor.primaryLightColor,
                                                  activeTrackColor:
                                                      AppColor.primaryLightColor,
                                                  inactiveTrackColor: AppColor
                                                      .whiteColor
                                                      .withOpacity(0.3),
                                                  trackHeight: 5,
                                                ),
                                                child: Slider(
                                                  min: 0,
                                                  max: DurationMusic
                                                      .duration.inSeconds
                                                      .toDouble(),
                                                  value: DurationMusic
                                                      .position.inSeconds
                                                      .toDouble(),
                                                  onChanged: (value) async {
                                                    await controller
                                                        .sliderMetode(value);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    DurationMusic.formtTime(
                                                        DurationMusic.position),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    DurationMusic.formtTime(
                                                        DurationMusic.duration),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.toggleMusic(controller
                                                        .musicDetails?['asset']
                                                    ?['file']?['url']);
                                              },
                                              child: Container(
                                                width: 13.w,
                                                height: 5.4.h,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryLightColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  controller.isPlaying
                                                      ? Icons.pause
                                                      : Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  int itemId = controller.musicDetails?['asset_id'];
                                  print(itemId);
                                  Get.toNamed(PageRoutes.COMMENT,
                                      arguments: {'id': itemId});
                                },
                                child: CustomCommentSinglePageWidget(),
                              ),
                              SizedBox(
                                height:30.h,
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                Obx(() {
                  return Visibility(
                    visible: controller.isEditAvaiblae.isTrue,

                    child: Align(
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
                              height: 7.h,
                              decoration: BoxDecoration(
                                  color: Color(0xff4E4E61).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10.sp),
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
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Row(
                                children: [
                                  Expanded(child: Text(
                                      '${Constant.getDropDownByPlan(controller.musicDetails!['plan'].toString())}')),
                                  if(!controller.musicDetails!['plan'].toString().contains("1"))  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("${controller.musicDetails!['price'].toString()} €"),
                                      SizedBox(width: 3.w,),
                                      SvgPicture.asset("assets/images/download.svg"),
                                    ],
                                  )
                                ],
                              ),
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
                                    controller.sendToEditProfile(PostType.audio);
                                  },
                                  child: Center(
                                    child: Text("Edit information",
                                      style: TextStyle(color: "83839C".toColor()),),
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            );
      }),
    );
  }
}
