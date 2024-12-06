import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/detail/widgets/details_bottom_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../../../common/app_config.dart';
import '../../login/widgets/custom_register_button_widget.dart';
import '../../media_suit/logic.dart';
import '../logic.dart';
import '../widgets/back_widget.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
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
        backgroundColor: AppColor.primaryDarkColor,
        bottomNavigationBar: Obx(() {
          if (videoController.isLoadingVideos.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (videoController.videoDetails != null &&
                videoController.videoDetails!.containsKey('asset') &&
                videoController.videoDetails!['asset'] != null &&
                videoController.videoDetails!['asset'].containsKey('plan')) {
              int plan = videoController.videoDetails!['asset']['license_type'];
              print(plan);
              if (plan == 1) {
                return SizedBox();
              } else if ((plan == 2 || plan == 3)) {
                return BuyCardWidget(
                    selectedItem: videoController.videoDetails,
                    title: videoController.videoDetails!['asset']
                                ['license_type'] ==
                            2
                        ? 'Ownership'
                        : videoController.videoDetails!['asset']
                                    ['license_type'] ==
                                3
                            ? 'Subscribe'
                            : '',
                    price: videoController.videoDetails!['asset']['price']);
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }
        }),
        body: Obx(() {
          return videoController.isLoadingVideos.value
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        CustomAppBarVideoAndImageDetailWidget(
                          selectedItem: videoController.videoDetails,
                          isVideo: true,
                          detailController: videoController,
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
                                Text(
                                  '${videoController.videoDetails?['media']['name']}',
                                  style: FontStyleApp.titleMedium.copyWith(
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  '${videoController.videoDetails?['media']['description'] ?? ''}',
                                  style: FontStyleApp.bodyMedium.copyWith(
                                    color: AppColor.grayLightColor
                                        .withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: videoController
                                                      .videoDetails?['user']
                                                  ['image_url'] ==
                                              null
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  AppColor.blueDarkColor,
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  AppColor.blueDarkColor,
                                              backgroundImage: NetworkImage(
                                                  videoController
                                                          .videoDetails?['user']
                                                      ['image_url']),
                                            ),
                                      width: 7.w,
                                    ),
                                    CircleAvatar(
                                      radius: 3.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    if (videoController
                                            .videoDetails?['asset'] !=
                                        null)
                                      Text(
                                        videoController.videoDetails?['asset']
                                            ['user']['username'],
                                        style: FontStyleApp.bodySmall.copyWith(
                                            color: AppColor.grayLightColor
                                                .withOpacity(0.8),
                                            fontSize: 13),
                                      ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                            ReportBottomSheet(videoController));
                                      },
                                      child: Text(
                                        'details_6'.tr,
                                        style: FontStyleApp.bodySmall.copyWith(
                                            color: AppColor.grayLightColor
                                                .withOpacity(0.8),
                                            fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                if (!videoController.file_id
                                    .toString()
                                    .contains("null"))
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            videoController
                                                .videoConvertToAudio();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/${F.assetTitle}/icons/icon__single-convert-to-audio.svg",
                                            width: 6.w,
                                          )),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            videoController.sendShareYouTube();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/${F.assetTitle}/icons/icon__video-white.svg",
                                            width: 6.w,
                                          )),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            videoController.videoDubbing();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/${F.assetTitle}/icons/dubbing.svg",
                                            width: 6.w,color: Colors.white,
                                          )),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          double videoLength =
                                              (videoController.videoDetails?[
                                                          'file']['info']['time'] ??
                                                      0)
                                                  .toDouble();

                                          Get.find<MediaSuitController>()
                                              .setDataEditVideo(
                                                  videoController.videoDetails?[
                                                          'media']['name'] ??
                                                      '',
                                                  videoController
                                                          .videoDetails?['file']
                                                      ['url'],
                                                  videoLength,
                                                  videoController
                                                      .videoDetails!['file_id']
                                                      .toString());
                                          Get.toNamed(PageRoutes.MEDIASUIT);

                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                if (!videoController.file_id
                                    .toString()
                                    .contains("null"))
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                Wrap(
                                  children: [
                                    //
                                    if (videoController
                                            .videoDetails?['genre'] !=
                                        null)
                                      CardMarkSinglePageWidget(
                                          label: 'details_9'.tr,
                                          type: (videoController
                                                      .videoDetails?['genre']
                                                      .length >
                                                  5)
                                              ? '${videoController.videoDetails?['genre'].substring(0, 5)}...'
                                              : videoController
                                                  .videoDetails?['genre']),
                                    CardMarkSinglePageWidget(
                                        label: 'details_8'.tr,
                                        type: videoController.getTypeString(
                                            videoController.videoDetails?[
                                                    'media_type'] ??
                                                1)),
                                    CardMarkSinglePageWidget(
                                        label: 'details_10'.tr,
                                        type:
                                            '${videoController.videoDetails?['media']['language']}'),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    String itemId = videoController
                                        .videoDetails?['asset_id'];
                                    print(itemId);
                                    Get.toNamed(PageRoutes.COMMENT, arguments: {
                                      'id': itemId,
                                      "logic": videoController
                                    });
                                  },
                                  child: CustomCommentSinglePageWidget(),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      return Visibility(
                        visible: videoController.isEditAvaiblae.isTrue,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: DetailsBottomWidget(
                              videoController, PostType.video),
                        ),
                      );
                    }),
                    BackWidget(
                      idAssetMedia:
                      idAssetMediaValte == "idAssetMedia",
                    )
                  ],
                );
        }),
      ),
    );
  }
}

class VideoDialog extends StatefulWidget {
  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  final VideoPlayerController _controller = VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Video Dialog'),
      content: Container(
        width: double.maxFinite,
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('details_2'.tr),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.initialize().then((_) {
      Get.back(result: true);
      _controller.play();
    });
  }
}
