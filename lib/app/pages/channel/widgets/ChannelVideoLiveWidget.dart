

import 'dart:typed_data';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/pages/channel/tab/single_channel_logic.dart';
import 'package:mediaverse/app/pages/live/widgets/custom_video_live_widget2.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';




class ChannelVideoLiveWidget extends StatefulWidget {
  final String videoUrl;
  SingleChannelLogic logic;
  String title;
  String liveID;

  ChannelVideoLiveWidget({Key? key, required this.videoUrl,required this.title,required this.liveID,
    required this.logic}) : super(key: key);

  @override
  _ChannelVideoLiveWidgetState createState() => _ChannelVideoLiveWidgetState();
}

class _ChannelVideoLiveWidgetState extends State<ChannelVideoLiveWidget> {


  late bool _isPlaying;
  double _sliderValue = 0.0;
  var chewieController ;


  var isErrorHandling = false.obs;
  @override
  void initState() {
    super.initState();
    try {
      widget. logic.controllerVideoPlay = VideoPlayerController.network(
        '${widget.videoUrl}',
      )..initialize().then((_) {
        chewieController= ChewieController(
          videoPlayerController:     widget.logic.controllerVideoPlay,
          autoPlay: true,
          looping: true,

        );
        setState(() {

        });

      });
      widget. logic.controllerVideoPlay.addListener(() {
        if (widget. logic.controllerVideoPlay.value.hasError) {

        }

      });
    }  catch (e) {
      // TODO
      print('_VideoLiveWidgetState.initState catch ');
    }

  }

  @override
  void dispose() {
    widget. logic.controllerVideoPlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return      widget. logic.controllerVideoPlay.value.isInitialized  ?FocusDetector(
      onFocusLost: (){
        try {
          widget.   logic.controllerVideoPlay.pause();
        } on Exception catch (e) {
          // TODO
        }
      },
      onFocusGained: (){
        try {
          widget. logic.controllerVideoPlay.play();
        } on Exception catch (e) {
          // TODO
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                TextButton(onPressed: (){
                  widget.logic.switchTo(widget.liveID);
                }, child: Text("Switch",style: TextStyle(
                  color: AppColor.primaryLightColor
                ),))
              ],
            ),
            Stack(
                children: [
                  Screenshot(
                    controller:  widget.logic.screenshotController,
                    child: AspectRatio(
                      aspectRatio:   widget.  logic.controllerVideoPlay.value.aspectRatio,
                      child:  Chewie(
                        controller: chewieController,
                      ),
                    ),//
                  ),
                ])

          ],
        ),
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