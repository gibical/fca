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
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../../../common/app_config.dart';
import '../../login/widgets/custom_register_button_widget.dart';
import '../../media_suit/logic.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/report_botton_sheet.dart';


class DetailVideoScreen extends StatelessWidget {
  DetailVideoScreen({super.key});

  final videoController = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(Get.arguments['idAssetMedia'] == "idAssetMedia"){
          Get.offAllNamed(PageRoutes.WRAPPER);
        }else{
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
              int plan = videoController.videoDetails!['asset']['plan'];
              print(plan);
              if (plan == 1) {
                return SizedBox();
              } else if ((plan == 2 || plan == 3)) {
                return BuyCardWidget(
                    selectedItem: videoController.videoDetails,
                    title: videoController.videoDetails!['asset']['plan'] == 2
                        ? 'Ownership'
                        : videoController.videoDetails!['asset']['plan'] == 3
                        ? 'Subscribe'
                        : '',
                    price: videoController.videoDetails!['asset']['price']
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }
        }),

        body: Obx(() {
          return videoController.isLoadingVideos.value ? Center(
              child: CircularProgressIndicator()) : Stack(
            children: [
              CustomScrollView(
                slivers: [
                  CustomAppBarVideoAndImageDetailWidget(
                    selectedItem: videoController.videoDetails,
                    isVideo: true,
                    detailController: videoController,),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Text('${videoController.videoDetails?['name']}',
                            style: FontStyleApp.titleMedium.copyWith(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w600
                            ),),

                          SizedBox(
                            height: 1.h,
                          ),
                          Text('${videoController.videoDetails?['description'] ?? ''}',
                            style: FontStyleApp.bodyMedium.copyWith(
                              color: AppColor.grayLightColor.withOpacity(0.8),
                            ),),

                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3.w,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              if(videoController.videoDetails?['asset'] !=
                                  null)Text(videoController
                                  .videoDetails?['asset']['user']['username'],
                                style: FontStyleApp.bodySmall.copyWith(
                                    color: AppColor.grayLightColor.withOpacity(
                                        0.8),
                                    fontSize: 13
                                ),),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                      ReportBottomSheet(videoController));
                                },
                                child: Text('Report',
                                  style: FontStyleApp.bodySmall.copyWith(
                                      color: AppColor.grayLightColor.withOpacity(
                                          0.8),
                                      fontSize: 13
                                  ),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    videoController.screenShotOfTheVideo();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__screenshot.svg",
                                    width: 6.w,
                                  )),

                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    videoController.videoConvertToAudio();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__single-convert-to-audio.svg",
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
                                    "assets/icons/icon__video-white.svg",
                                    width: 6.w,
                                  )),

                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.find<MediaSuitController>().setDataEditVideo(videoController.videoDetails?['name'] ?? '' ,videoController.videoDetails?['file']['url'] );
                                  Get.toNamed(PageRoutes.MEDIASUIT);
                                },
                                child:  Icon(Icons.edit),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),

                          Wrap(
                            children: [
                              //
                              if(videoController.videoDetails?['genre'] !=
                                  null) CardMarkSinglePageWidget(label: 'Genre',
                                  type: (videoController.videoDetails?['genre']
                                      .length > 5)
                                      ? '${videoController.videoDetails?['genre']
                                      .substring(0, 5)}...'
                                      : videoController.videoDetails?['genre']),
                              CardMarkSinglePageWidget(label: 'Type',
                                  type: videoController.getTypeString(
                                      videoController.videoDetails?['type'] ??
                                          1)),
                              CardMarkSinglePageWidget(label: 'Lanuage',
                                  type: '${videoController
                                      .videoDetails?['language']}'),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              int itemId = videoController
                                  .videoDetails?['asset_id'];
                              print(itemId);
                              Get.toNamed(
                                  PageRoutes.COMMENT, arguments: {'id': itemId});
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
                                    '${Constant.getDropDownByPlan(videoController.videoDetails!['plan'].toString())}')),
                                if(!videoController.videoDetails!['plan'].toString().contains("1"))  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${(videoController.videoDetails!['price']/100).toString()} €"),
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
                                  videoController.sendToEditProfile(PostType.video);
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
          child: Text('Close'),
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