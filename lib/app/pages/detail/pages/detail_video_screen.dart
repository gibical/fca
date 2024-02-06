import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';


class DetailVideoScreen extends StatelessWidget {
   DetailVideoScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final videoController = Get.find<DetailController>();
    return Scaffold(

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
            } else if (plan == 2 || plan == 3) {
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

      body:Obx(() {

        return videoController.isLoadingVideos.value ? Center(child: CircularProgressIndicator()) :CustomScrollView(
          slivers: [
          CustomAppBarVideoAndImageDetailWidget(selectedItem: videoController.videoDetails, isVideo: true,),
            SliverToBoxAdapter(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text('${videoController.videoDetails?['name']}', style: FontStyleApp.titleMedium.copyWith(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w600
                    ),),

                    SizedBox(
                      height: 1.h,
                    ),
                    Text('${videoController.videoDetails?['description']}' , style: FontStyleApp.bodyMedium.copyWith(
                      color: AppColor.grayLightColor.withOpacity(0.8),
                    ),),

                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius:3.w,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        if(videoController.videoDetails?['asset']!=null)Text(videoController.videoDetails?['asset']['user']['username'] , style: FontStyleApp.bodySmall.copyWith(
                            color: AppColor.grayLightColor.withOpacity(0.8),
                            fontSize: 13
                        ),),
                        Spacer(),
                        Text('Report' , style: FontStyleApp.bodySmall.copyWith(
                            color: AppColor.grayLightColor.withOpacity(0.8),
                            fontSize: 13
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Wrap(
                      children: [
                        //
                    if(videoController.videoDetails?['genre']!=null)    CardMarkSinglePageWidget(label: 'Genre' , type: (videoController.videoDetails?['genre'].length > 5) ? '${videoController.videoDetails?['genre'].substring(0, 5)}...' : videoController.videoDetails?['genre']),
                        CardMarkSinglePageWidget(label: 'Type' , type: videoController.getTypeString(videoController.videoDetails?['asset']['type'])),
                        CardMarkSinglePageWidget(label: 'Lanuage' , type: '${videoController.videoDetails?['language']}'),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        int itemId = videoController.videoDetails?['asset_id'];
                        print(itemId);
                        Get.toNamed(PageRoutes.COMMENT, arguments: {'id': itemId});
                      },
                      child: CustomCommentSinglePageWidget(),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                  ],
                ),
              ),
            ),

          ],
        );
      }),


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