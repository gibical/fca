

import 'dart:typed_data';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mediaverse/app/pages/live/widgets/custom_video_live_widget2.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../logic.dart';




class VideoLiveWidget extends StatefulWidget {
  final String videoUrl;

   VideoLiveWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoLiveWidgetState createState() => _VideoLiveWidgetState();
}

class _VideoLiveWidgetState extends State<VideoLiveWidget> {


  LiveController liveController = Get.find<LiveController>();
  late bool _isPlaying;
  double _sliderValue = 0.0;
  var chewieController ;

  @override
  void initState() {
    super.initState();
    liveController.controllerVideoPlay = VideoPlayerController.network(
      '${widget.videoUrl}',
    )..initialize().then((_) {
      chewieController= ChewieController(
        videoPlayerController:    liveController.controllerVideoPlay,
        autoPlay: true,
        looping: true,

      );
      setState(() {

      });

    });

  }

  @override
  void dispose() {
    liveController.controllerVideoPlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return      liveController.controllerVideoPlay.value.isInitialized  ? Column(
      children: [
        Stack(
          children: [
            Screenshot(
              controller: liveController.screenshotController,
              child: AspectRatio(
                aspectRatio:    liveController.controllerVideoPlay.value.aspectRatio,
                child:  Chewie(
                  controller: chewieController,
                ),
              ),
            ),
])

      ],
    ): Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: CircularProgressIndicator(),
    );
  }
}