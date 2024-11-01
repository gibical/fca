

import 'dart:typed_data';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/pages/live/widgets/custom_video_live_widget2.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../logic.dart';




class VideoLiveWidget extends StatefulWidget {
  final String videoUrl;
  LiveController liveController;

   VideoLiveWidget({Key? key, required this.videoUrl, required this.liveController}) : super(key: key);

  @override
  _VideoLiveWidgetState createState() => _VideoLiveWidgetState();
}

class _VideoLiveWidgetState extends State<VideoLiveWidget> {


  late bool _isPlaying;
  double _sliderValue = 0.0;
  var chewieController ;

  
  var isErrorHandling = false.obs;
  @override
  void initState() {
    super.initState();
   try {
     widget. liveController.controllerVideoPlay = VideoPlayerController.network(
        '${widget.videoUrl}',
      )..initialize().then((_) {
        chewieController= ChewieController(
          videoPlayerController:     widget.liveController.controllerVideoPlay,
          autoPlay: true,
          looping: true,

        );
        setState(() {

        });

      });
     widget. liveController.controllerVideoPlay.addListener(() {
       if (widget. liveController.controllerVideoPlay.value.hasError) {

       }

     });
   }  catch (e) {
     // TODO
     print('_VideoLiveWidgetState.initState catch ');
    }

  }

  @override
  void dispose() {
    widget. liveController.controllerVideoPlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return      widget. liveController.controllerVideoPlay.value.isInitialized  ?FocusDetector(
      onFocusLost: (){
        try {
          widget.   liveController.controllerVideoPlay.pause();
        } on Exception catch (e) {
          // TODO
        }
      },
      onFocusGained: (){
        try {
          widget. liveController.controllerVideoPlay.play();
        } on Exception catch (e) {
          // TODO
        }
      },
      child: Column(
        children: [
          SizedBox(height: 8.h,),
          Stack(
            children: [
              Screenshot(
                controller:  widget.liveController.screenshotController,
                child: AspectRatio(
                  aspectRatio:   widget.  liveController.controllerVideoPlay.value.aspectRatio,
                  child:  Chewie(
                    controller: chewieController,
                  ),
                ),//
              ),
      ])

        ],
      ),
    ): Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: Center(child: Container(
          width: 10.w,
          height: 10.w,
          child: CircularProgressIndicator())),
    );
  }
}