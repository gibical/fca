

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
  late VideoPlayerController _controller;

  LiveController liveController = Get.find<LiveController>();
  late bool _isPlaying;
  double _sliderValue = 0.0;
  var chewieController ;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      '${widget.videoUrl}',
    )..initialize().then((_) {
      chewieController= ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: true,
      );
      setState(() {
   //     _isPlaying = true;
      });
   //   _controller.play();
    });
    // _isPlaying = false;
    // _controller.addListener(() {
    //   setState(() {
    //     _sliderValue = _controller.value.position.inSeconds.toDouble();
    //   });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   _controller.value.isInitialized  ? Column(
      children: [
        Stack(
          children: [
            Screenshot(
              controller: liveController.screenshotController,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
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