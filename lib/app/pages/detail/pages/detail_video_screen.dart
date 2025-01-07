import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/common/utils/data_state.dart';
import 'package:mediaverse/app/common/widgets/appbar_btn.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/detail/widgets/details_bottom_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/player/player.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:video_player/video_player.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../../../common/app_config.dart';
import '../../channel/widgets/card_channel_widget.dart';
import '../../login/widgets/custom_register_button_widget.dart';
import '../../media_suit/logic.dart';
import '../logic.dart';
import '../widgets/back_widget.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/custom_switch.dart';
import '../widgets/report_botton_sheet.dart';
import '../widgets/youtube_bottomsheet.dart';

class DetailVideoScreen extends StatelessWidget {
  DetailVideoScreen({super.key});

  final videoController = Get.put(DetailController(4),
      tag: "${DateTime.now().microsecondsSinceEpoch}");

  var idAssetMediaValte = Get.arguments['idAssetMedia'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.arguments['idAssetMedia'] == "idAssetMedia") {
          Get.offAllNamed(PageRoutes.WRAPPER);
        } else {
          Get.back();
        }

        return false;
      },
      child: Scaffold(
          backgroundColor: AppColor.secondaryDark,
          body: SafeArea(
            child: Obx(() {
              if (videoController.isLoadingVideos.value ||
                  videoController.videoDetails!.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 10.h,
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppbarBTNWidget(
                                  iconName: 'back1',
                                  onTap: () {
                                    Get.back();
                                  }),
                              Text(
                                'Video',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(iconName: 'menu', onTap: () {}),
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.secondaryDark,
                    ),

                    //--
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: EdgeInsets.only(top: Get.height / 2 - 100),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                          backgroundColor:
                              AppColor.primaryColor.withOpacity(0.2),
                        ),
                      ),
                    )),
                    //--
                  ],
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 10.h,
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppbarBTNWidget(
                                  iconName: 'back1',
                                  onTap: () {
                                    Get.back();
                                  }),
                              Text(
                                'Video',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(
                                  iconName: 'menu',
                                  onTap: () {
                                    videoController.isEditAvaiblae.isTrue
                                        ? showMenu(
                                            color: '#0F0F26'.toColor(),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp)),
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                                100, 80, 0, 0),
                                            items: [
                                              PopupMenuItem(
                                                value: 1,
                                                onTap: () {
                                                  videoController
                                                      .sendToEditProfile(
                                                          PostType.video);
                                                },
                                                child: SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/mediaverse/icons/edit.svg'),
                                                      Text('Edit'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ).then((value) {
                                            if (value != null) {
                                              print('$value');
                                            }
                                          })
                                        :  showMenu(
                                      color: '#0F0F26'.toColor(),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              12.sp)),
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          100, 80, 0, 0),
                                      items: [
                                        PopupMenuItem(
                                          value: 1,
                                          onTap: () {
                                            Get.bottomSheet(
                                              elevation: 0,
                                                isScrollControlled: true,
                                                ReportBottomSheet2(videoController));
                                          },
                                          child: SizedBox(
                                            width: 130,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/mediaverse/icons/report.svg' , ),
                                                Text('Report'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).then((value) {
                                      if (value != null) {
                                        print('$value');
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.secondaryDark,
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 2.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: CachedNetworkImage(
                                  imageUrl: videoController
                                          .videoDetails?['user']['image_url'] ??
                                      '',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/mediaverse/icons/userprofile.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: AppColor.primaryLightColor,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Container(
                                      color: AppColor.primaryLightColor,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/mediaverse/icons/userprofile.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${videoController.videoDetails?['user']['username']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '${videoController.videoDetails?['user']['full_name']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              '16 Dec 2024, 6:50PM',
                              style: TextStyle(
                                fontSize: 13,
                                color: '#9C9CB8'.toColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(14.sp)),
                          child: PlayerVideo(),
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            buildCustomDetailBTNWidget(
                                iconName: 'Magic',
                                onTap: () {
                                  runCustomSelectBottomToolsAsset(
                                      videoController);
                                },
                                name: 'Tools'),
                            SizedBox(
                              width: 8,
                            ),
                            buildCustomDetailBTNWidget(
                                iconName: 'globe',
                                onTap: () {
                                  runCustomPublishSheet(videoController);
                                },
                                name: 'Publish'),
                            Spacer(),
                            // buildCustomDetailBTNWidget(
                            //     iconName: 'Forward',
                            //     onTap: () {},
                            //     name: 'Share'),
                          ],
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          '${videoController.videoDetails?['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: videoController
                                              .videoDetails?['description'] ==
                                          null
                                      ? ''
                                      : videoController.isExpandedViewBodyText
                                          ? videoController
                                              .videoDetails!['description']
                                          : videoController
                                                      .videoDetails![
                                                          'description']
                                                      .length >
                                                  80
                                              ? videoController.videoDetails![
                                                          'description']
                                                      .substring(0, 80) +
                                                  ' '
                                              : videoController
                                                  .videoDetails?['description'],
                                  style: TextStyle(
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                                if (videoController
                                            .videoDetails!['description'] !=
                                        null &&
                                    !videoController.isExpandedViewBodyText &&
                                    videoController.videoDetails!['description']
                                            .length >
                                        80)
                                  TextSpan(
                                    text: '...more',
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 3.h,
                        ),
                      ),
                    ),
                    //--

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Obx(() {
                              if (videoController.isLoadingComment.value) {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'details_12'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (videoController.commentsData == null ||
                                  videoController.commentsData!.isEmpty) {
                                return SizedBox();
                              } else {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'details_12'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text:
                                            ' (${videoController.commentsData!['data'].length})',
                                        style: TextStyle(
                                          color: '#9C9CB8'.toColor(),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: TextField(
                            controller: videoController.commentTextController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'Add a comment...',
                                fillColor: '#0F0F26'.toColor(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                suffixIcon: Transform.scale(
                                    scale: 0.8,
                                    child: IconButton(
                                      onPressed: () async {
                                        videoController.postComment();
                                        videoController
                                            .commentTextController.text = '';
                                        videoController.isLoadingComment.value =
                                            true;
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        videoController.fetchMediaComments();
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/mediaverse/icons/send.svg',
                                        height: 25,
                                      ),
                                    ))),
                          )),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--

                    Obx(() {
                      if (videoController.isLoadingComment.value) {
                        return SliverToBoxAdapter(
                            child: Center(
                                child: CupertinoActivityIndicator(
                          color: AppColor.primaryColor,
                        )));
                      } else if (videoController.commentsData == null ||
                          videoController.commentsData!.isEmpty) {
                        return SliverToBoxAdapter(child: SizedBox());
                      } else {
                        return SliverList.builder(
                            itemCount:
                                videoController.commentsData!['data'].length,
                            itemBuilder: (context, index) {
                              final comment =
                                  videoController.commentsData?['data'][index];
                              return CommentBoxWidget(
                                data: comment,
                              );
                            });
                      }
                    }),

                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                  ],
                );
              }
            }),
          )),
    );
  }

  Container buildCustomDetailBTNWidget(
      {required String iconName,
      required Function() onTap,
      required String name}) {
    return Container(
      decoration: BoxDecoration(
        color: '#0F0F26'.toColor(),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.01),
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/mediaverse/icons/${iconName}.svg',
                  height: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${name}',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentBoxWidget extends StatelessWidget {
  const CommentBoxWidget({
    super.key,
    required this.data,
  });

  final data;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 1.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (data['user'] != null && data['user']['image_url'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        width: 35,
                        height: 35,
                        child: CachedNetworkImage(
                          imageUrl: '${data['user']['image_url']}',
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Container(
                              color: AppColor.primaryLightColor,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/mediaverse/icons/userprofile.svg',
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return Container(
                              color: AppColor.primaryLightColor,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/mediaverse/icons/userprofile.svg',
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: AppColor.primaryLightColor,
                          shape: BoxShape.circle),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/mediaverse/icons/userprofile.svg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${data['user']?['username'] ?? 'Unknown'}',

                    style: TextStyle(color: '#9C9CB8'.toColor()),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // Text(
                  //   '1w',
                  //   style: TextStyle(color: '#9C9CB8'.toColor()),
                  // ),
                  // Spacer(),
                  // SvgPicture.asset(
                  //   'assets/mediaverse/icons/menu.svg',
                  //   height: 20,
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 42.0, right: 24),
              child: Text('${data['body'].toString()}'),
            )
          ],
        ));
  }
}

void runCustomSelectBottomToolsAsset(DetailController controller) {
  Get.bottomSheet(
    elevation: 0,
    StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: 100.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: "#0F0F26".toColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text(
                      'Tools',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 18,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: '9C9CB8'.toColor(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                color: '9C9CB8'.toColor().withOpacity(0.3),
                height: 0.5,
                width: Get.width,
              ),
              SizedBox(height: 2.h),
              //BTN Tools 1
              GestureDetector(
                onTap: () {
                  Get.back();
                  double videoLength =
                      double.parse(controller.videoDetails?['file']['length']);

                  Get.find<MediaSuitController>().setDataEditVideo(
                      controller.videoDetails?['name'] ?? '',
                      controller.videoDetails?['file']['url'],
                      videoLength,
                      controller.videoDetails!['file_id'].toString());
                  Get.toNamed(PageRoutes.MEDIASUIT);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: '2563EB'.toColor(),
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/mediaverse/icons/tools1.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Open in media studio',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/mediaverse/icons/open.svg',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                color: '9C9CB8'.toColor().withOpacity(0.3),
                height: 0.5,
                width: Get.width,
              ),

              Container(
                height: 0.5,
                width: Get.width,
              ),
              SizedBox(height: 2.h),
              //BTN Tools 2
              GestureDetector(
                onTap: () {
                  Get.back();
                  controller.videoConvertToAudio();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: '2563EB'.toColor(),
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/mediaverse/icons/tools2.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Video to Audio',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 0.5,
                width: Get.width,
              ),

              Container(
                height: 0.5,
                width: Get.width,
              ),
              SizedBox(height: 2.h),
              //BTN Tools 3
              GestureDetector(
                onTap: () {
                  controller.videoDubbing();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: '2563EB'.toColor(),
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/mediaverse/icons/tools3.svg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Dubbing ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/mediaverse/icons/arrow.svg',
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 0.5,
                width: Get.width,
              ),
            ],
          ),
        );
      },
    ),
  );
}

void runCustomPublishSheet(DetailController detailController) {
  detailController.fetchChannels();

  Get.bottomSheet(
    elevation: 0,
    Container(
      width: 100.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: "#0F0F26".toColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 3.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                Text(
                  'Publish in',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                IconButton(
                  iconSize: 18,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: '9C9CB8'.toColor(),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              'Choose where to share. Connect accounts in your profile if required.',
              style: TextStyle(color: '9C9CB8'.toColor(), fontSize: 13),
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            height: 0.5,
            width: Get.width,
          ),
          SizedBox(height: 2.h),
          //BTN Tools 1
          GestureDetector(
            onTap: () {
              Get.back();
              runPublishYoutubeSheet(detailController);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/mediaverse/icons/y.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Youtube',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/mediaverse/icons/arrow.svg',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 0.5,
            width: Get.width,
          ),

          Container(
            height: 0.5,
            width: Get.width,
          ),
          SizedBox(height: 2.h),
          //BTN Tools 2
          GestureDetector(
            onTap: () {
              Get.back();
              runPublishXSheet(detailController);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/mediaverse/icons/x.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'X',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/mediaverse/icons/arrow.svg',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 0.5,
            width: Get.width,
          ),

          Container(
            height: 0.5,
            width: Get.width,
          ),
          SizedBox(height: 2.h),
          //BTN Tools 3
          GestureDetector(
            onTap: () {
              Get.back();
              runPublishGoogleDriveSheet(detailController);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/mediaverse/icons/d.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Google drive',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/mediaverse/icons/arrow.svg',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 0.5,
            width: Get.width,
          ),
        ],
      ),
    ),
  );
}

void runPublishYoutubeSheet(DetailController detailController) {
  Get.bottomSheet(elevation: 0,
      isScrollControlled: true,
      StatefulBuilder(
    builder: (context, setState) {
      return Container(
        width: 100.w,

        decoration: BoxDecoration(
          color: "#0F0F26".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                    'Publish in Youtube',
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

              SizedBox(height: 1.h),
              Container(
                height: 0.5,
                width: Get.width,
              ),
              SizedBox(height: 2.h),
              //text filide 1 - select Account
              Obx(() {
                return GestureDetector(
                  onTap: () {
                    runSelectAccountSheet(detailController);
                  },
                  child: TextField(
                    style: TextStyle(
                      decorationColor: Colors.transparent,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      enabled: false,
                      suffixIcon:
                      detailController.isLoadingChannel.value == true
                          ? Transform.scale(
                        scale: 0.3,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor:
                          Colors.white.withOpacity(0.3),
                        ),
                      )
                          : Transform.scale(
                          scale: 0.5,
                          child: SvgPicture.asset(
                              'assets/mediaverse/icons/arrow.svg')),
                      hintText: detailController.selectedAccountTitle.isEmpty
                          ? 'Select Account'
                          : detailController.selectedAccountTitle,
                      hintStyle: TextStyle(
                          color: detailController.selectedAccountTitle.isEmpty
                              ? '9C9CB8'.toColor()
                              : Colors.white),
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
                );
              }),

              SizedBox(height: 2.h),

              //text filide 2 - title
              TextField(
                style: TextStyle(
                  decorationColor: Colors.transparent,
                  decoration: TextDecoration.none,
                ),
                controller: detailController.titleEditingController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Title',
                  hintStyle: TextStyle(color: '9C9CB8'.toColor()),
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

              SizedBox(height: 2.h),

              //text filide 3 - Description
              TextField(
                style: TextStyle(
                  decorationColor: Colors.transparent,
                  decoration: TextDecoration.none,
                ),
                maxLines: 3,
                controller: detailController.desEditingController,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Description',
                  hintStyle: TextStyle(color: '9C9CB8'.toColor()),
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

              SizedBox(height: 2.h),
              //Switch 1 - content private
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Is this content private?',
                    style: TextStyle(color: '9C9CB8'.toColor(), fontSize: 15),
                  ),
                  Obx(() => CustomSwitchWidget(
                    value: detailController.isPrivateContent.value,
                    onChanged: (value) {
                      detailController.isPrivateContent.value = value;
                      detailController.update();
                      if (detailController.isPrivateContent.value ==
                          true) {
                        print('On');
                      } else {
                        print('Off');
                      }
                    },
                  ))
                ],
              ),


              SizedBox(height: 2.h),
              //Switch 2 - Publish Later
              GetBuilder<DetailController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Publish Later',
                            style: TextStyle(
                              color: '9C9CB8'.toColor(),
                              fontSize: 15,
                            ),
                          ),
                          CustomSwitchWidget(
                            value: controller.isSeletedDate.value,
                            onChanged: (value) {
                              controller.isSeletedDate.value = value;
                              controller.update();
                              if (controller.isSeletedDate.value) {
                                print('On');
                              } else {
                                print('Off');
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (controller.isSeletedDate.value)
                        GestureDetector(
                            onTap: (){
                              runSelectDateSheet(detailController);
                            },



                            child: Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  runSelectDateSheet(detailController);
                                },
                                child: TextField(
                                  enabled: false,
                                  style: TextStyle(
                                    decorationColor: Colors.transparent,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: detailController.isSeletedDate.value
                                        ? "${detailController.selectedDate.value.year}-${detailController.selectedDate.value.month}-${detailController.selectedDate.value.day} , ${detailController.selectedDate.value.hour.toString().padLeft(2, '0')}:${detailController.selectedDate.value.minute.toString().padLeft(2, '0')}"
                                        : 'Select date and time',
                                    suffixIcon: Transform.scale(
                                      scale: 0.5,
                                      child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg'),
                                    ),
                                    hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                                    fillColor: '#17172E'.toColor(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              );
                            })


                        ),
                    ],
                  );
                },
              ),


              SizedBox(height: 2.h),
              //publish btn
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Material(
                  color: '2563EB'.toColor(),
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.white.withOpacity(0.03),
                    onTap: () {
                      detailController.onSendShareRequest('youtube');
                    },
                    child: Center(
                        child: Obx((){
                          if(detailController.loadingSendShareDataSate.value.status == Status.loading ){
                            return Transform.scale(scale: .5,child: CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.white.withOpacity(0.3),
                            ),);
                          }else{
                            return Text('Publish');
                          }
                        })
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    },
  ));
}
void runPublishXSheet(DetailController detailController) {
  Get.bottomSheet(elevation: 0, StatefulBuilder(
    builder: (context, setState) {
      return Container(
        width: 100.w,

        decoration: BoxDecoration(
          color: "#0F0F26".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                      'Publish in X',
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

                SizedBox(height: 1.h),
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                //text filide 1 - select Account
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      runSelectAccountSheet(detailController);
                    },
                    child: TextField(
                      style: TextStyle(
                        decorationColor: Colors.transparent,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        enabled: false,
                        suffixIcon:
                            detailController.isLoadingChannel.value == true
                                ? Transform.scale(
                                    scale: 0.3,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset(
                                        'assets/mediaverse/icons/arrow.svg')),
                        hintText: detailController.selectedAccountTitle.isEmpty
                            ? 'Select Account'
                            : detailController.selectedAccountTitle,
                        hintStyle: TextStyle(
                            color: detailController.selectedAccountTitle.isEmpty
                                ? '9C9CB8'.toColor()
                                : Colors.white),
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
                  );
                }),



                SizedBox(height: 2.h),
                //Switch 2 - Publish Later
                GetBuilder<DetailController>(
                  builder: (controller) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Publish Later',
                              style: TextStyle(
                                color: '9C9CB8'.toColor(),
                                fontSize: 15,
                              ),
                            ),
                            CustomSwitchWidget(
                              value: controller.isSeletedDate.value,
                              onChanged: (value) {
                                controller.isSeletedDate.value = value;
                                controller.update();
                                if (controller.isSeletedDate.value) {
                                  print('On');
                                } else {
                                  print('Off');
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        if (controller.isSeletedDate.value)
                          GestureDetector(
                            onTap: (){
                              runSelectDateSheet(detailController);
                            },



                            child: Obx(() {
                              return GestureDetector(
                                onTap: () {
                                  runSelectDateSheet(detailController);
                                },
                                child: TextField(
                                  enabled: false,
                                  style: TextStyle(
                                    decorationColor: Colors.transparent,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: detailController.isSeletedDate.value
                                        ? "${detailController.selectedDate.value.year}-${detailController.selectedDate.value.month}-${detailController.selectedDate.value.day} , ${detailController.selectedDate.value.hour.toString().padLeft(2, '0')}:${detailController.selectedDate.value.minute.toString().padLeft(2, '0')}"
                                        : 'Select date and time',
                                    suffixIcon: Transform.scale(
                                      scale: 0.5,
                                      child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg'),
                                    ),
                                    hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                                    fillColor: '#17172E'.toColor(),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              );
                            })


                          ),
                      ],
                    );
                  },
                ),


                SizedBox(height: 2.h),
                //publish btn
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Material(
                    color: '2563EB'.toColor(),
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      splashColor: Colors.white.withOpacity(0.03),
                      onTap: () {

                        detailController.onSendShareRequest('x_tweet');
                      },
                      child: Center(
                        child: Obx((){
                          if(detailController.loadingSendShareDataSate.value.status == Status.loading ){
                            return Transform.scale(scale: .5,child: CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.white.withOpacity(0.3),
                            ),);
                          }else{
                            return Text('Publish');
                          }
                        })
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    },
  ));
}
void runPublishGoogleDriveSheet(DetailController detailController) {
  Get.bottomSheet(elevation: 0, StatefulBuilder(
    builder: (context, setState) {
      return Container(
        width: 100.w,

        decoration: BoxDecoration(
          color: "#0F0F26".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                      'Publish in Google drive',
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

                SizedBox(height: 1.h),
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                //text filide 1 - select Account
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      runSelectAccountSheet(detailController);
                    },
                    child: TextField(
                      style: TextStyle(
                        decorationColor: Colors.transparent,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        enabled: false,
                        suffixIcon:
                            detailController.isLoadingChannel.value == true
                                ? Transform.scale(
                                    scale: 0.3,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 0.5,
                                    child: SvgPicture.asset(
                                        'assets/mediaverse/icons/arrow.svg')),
                        hintText: detailController.selectedAccountTitle.isEmpty
                            ? 'Select Account'
                            : detailController.selectedAccountTitle,
                        hintStyle: TextStyle(
                            color: detailController.selectedAccountTitle.isEmpty
                                ? '9C9CB8'.toColor()
                                : Colors.white),
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
                  );
                }),






                SizedBox(height: 2.h),
                //publish btn
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Material(
                    color: '2563EB'.toColor(),
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      splashColor: Colors.white.withOpacity(0.03),
                      onTap: () {

                        detailController.onSendShareRequest('google_drive');
                      },
                      child: Center(
                        child: Obx((){
                          if(detailController.loadingSendShareDataSate.value.status == Status.loading ){
                            return Transform.scale(scale: .5,child: CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.white.withOpacity(0.3),
                            ),);
                          }else{
                            return Text('Publish');
                          }
                        })
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    },
  ));
}



void runSelectDateSheet(DetailController detailController) {
  detailController.fetchChannels();

  Get.bottomSheet(
    elevation: 0,
    isScrollControlled: true,
    StatefulBuilder(builder: (context, setState) {
      return Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: "#0F0F26".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          'assets/mediaverse/icons/arrow.svg' , width: 24 , height: 24,),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Select date',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 3.h),
                // Calendar Section
                TableCalendar(
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2050),
                  focusedDay: detailController.selectedDate.value ?? DateTime.now(),
                  currentDay: detailController.selectedDate.value ,
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: '2563EB'.toColor(),
                      shape: BoxShape.circle,
                    ),
                    // selectedDecoration: BoxDecoration(
                    //   color: Colors.blue.shade700,
                    //   shape: BoxShape.circle,
                    // ),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    weekendTextStyle: TextStyle(color: Colors.white),
                    outsideTextStyle: TextStyle(color: Colors.grey),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      detailController.selectedDate.value  = selectedDay;
                      detailController.isSeletedDate.value = true;
                    });
                  },
                ),
                SizedBox(height: 2.h),
                //Continue btn
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Material(
                    color: '2563EB'.toColor(),
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      splashColor: Colors.white.withOpacity(0.03),
                      onTap: () {
                        runSelectTimeSheet(detailController);
                      },
                      child: Center(
                        child: Text('Continue'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    }),
  );
}

void runSelectTimeSheet(DetailController controller) {
  Get.bottomSheet(
    elevation: 0,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: true,
    StatefulBuilder(builder: (context, setState) {
      TimeOfDay selectedTime = TimeOfDay.now();

      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: "#0F0F26".toColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          'assets/mediaverse/icons/arrow.svg', width: 24, height: 24),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Select time',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 3.h),
              // Time Picker Section
              SizedBox(
                height: 200,
                child: TimePickerSpinner(
                  isShowSeconds: true,
                  isForce2Digits: true,

                  highlightedTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                  ),
                  normalTextStyle: TextStyle(

                      color: '9C9CB8'.toColor(),
                    fontSize: 25
                  ),
                  is24HourMode: false,
                  time: DateTime(selectedTime.hour, selectedTime.minute),
                  onTimeChange: (time) {
                    setState(() {
                      selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);

                      final currentDate = controller.selectedDate.value ?? DateTime.now();
                      final updatedDateTime = DateTime(
                        currentDate.year,
                        currentDate.month,
                        currentDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );

                      controller.selectedDate.value = updatedDateTime;
                      controller.isSeletedDate.value = true;
                    });
                  },
                ),
              ),
              SizedBox(height: 2.h),
              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Material(
                  color: '2563EB'.toColor(),
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.white.withOpacity(0.03),
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      );
    }),
  );
}
// void runSelectTimeSheet(DetailController controller) {
//   Get.bottomSheet(
//     elevation: 0,
//
//       enableDrag: false,
//       isDismissible: false,
//     isScrollControlled: true,
//     StatefulBuilder(builder: (context, setState) {
//       TimeOfDay selectedTime = TimeOfDay.now();
//
//       return Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: "#0F0F26".toColor(),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: 3.h),
//               Row(
//                 children: [
//                   RotatedBox(
//                     quarterTurns: 2,
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: SvgPicture.asset(
//                           'assets/mediaverse/icons/arrow.svg' , width: 24 , height: 24,),
//                     ),
//                   ),
//                   Spacer(),
//                   Text(
//                     'Select time',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 24,
//                   ),
//                   Spacer(),
//                 ],
//               ),
//               SizedBox(height: 3.h),
//               // Time Picker Section
//               SizedBox(
//                 height: 200,
//                 child: CupertinoTimerPicker(
//                   mode: CupertinoTimerPickerMode.hm,
//                   initialTimerDuration: Duration(
//                     hours: selectedTime.hour,
//                     minutes: selectedTime.minute,
//                   ),
//                   onTimerDurationChanged: (duration) {
//                     setState(() {
//                       selectedTime = TimeOfDay(
//                         hour: duration.inHours % 24,
//                         minute: duration.inMinutes % 60,
//                       );
//
//                        final currentDate = controller.selectedDate.value ?? DateTime.now();
//                       final updatedDateTime = DateTime(
//                         currentDate.year,
//                         currentDate.month,
//                         currentDate.day,
//                         selectedTime.hour,
//                         selectedTime.minute,
//                       );
//
//                       controller.selectedDate.value = updatedDateTime;
//                       controller.isSeletedDate.value = true;
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               // Confirm Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: Material(
//                   color: '2563EB'.toColor(),
//                   borderRadius: BorderRadius.circular(100),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(100),
//                     splashColor: Colors.white.withOpacity(0.03),
//                     onTap: () {
//
//
//                       Get.back();
//                       Get.back();
//                     },
//                     child: Center(
//                       child: Text(
//                         'Confirm',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 2.h),
//             ],
//           ),
//         ),
//       );
//     }),
//   );
// }


void runSelectAccountSheet(DetailController detailController) {
  detailController.fetchChannels();

  Get.bottomSheet(
    elevation: 0,
    Container(
      width: 100.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: "#0F0F26".toColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
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
                      child:
                          SvgPicture.asset('assets/mediaverse/icons/arrow.svg'),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Select an account',
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
              SizedBox(height: 3.h),
              Obx(() {
                if (detailController.isLoadingChannel.value == true) {
                  return Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.3),
                    ),
                  );
                } else {
                  return detailController.externalAccountlist.isEmpty ?Column(
                    children: [
                      Text('You haven’t connected any accounts yet. Please connect an account to publish your content.' ,

                      textAlign: TextAlign.center,
                      style: TextStyle(

                        fontSize: 12,
                        color: '9C9CB8'.toColor(),
                      ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Material(
                          color: '2563EB'.toColor(),
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            splashColor: Colors.white.withOpacity(0.03),
                            onTap: () {

                              Get.back();
                              Get.toNamed(PageRoutes.SHAREACCOUNT);
                            },
                            child: Center(
                              child: Text(
                                'Go to accounts center',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ):Column(
                    children: detailController.externalAccountlist
                        //  .where((element) => element.type.toString().contains("1"))
                        .toList()
                        .asMap()
                        .entries
                        .map((e) {
                      var model =
                          detailController.externalAccountlist.elementAt(e.key);

                      return accountWidget(
                          //
                          title: (model.title ?? "").toString(),
                          date: (model.createdAt ?? ""),
                          isEnable: detailController.enableChannel == e.key,
                          onTap: () {
                            detailController.selectAccountPublish(e.key);
                          });
                    }).toList(),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget accountWidget({
  required String title,
  required String date,
  bool isEnable = false,
  Function? onTap,
}) {
  return Container(
    width: double.infinity,
    height: 8.h,
    child: GestureDetector(
      onTap: () {
        try {
          onTap?.call();
        } catch (e) {
          // Handle error
        }
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isEnable ? '2563EB'.toColor() : '9C9CB8'.toColor(),
                  width: isEnable ? 5.5 : 1,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              title,
              style: FontStyleApp.bodyMedium.copyWith(
                color: AppColor.whiteColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
