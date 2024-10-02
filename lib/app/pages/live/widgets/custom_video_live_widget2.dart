

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../logic.dart';




class VideoLiveWidget2 extends StatefulWidget {
  final String videoUrl;

   VideoLiveWidget2({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoLiveWidget2State createState() => _VideoLiveWidget2State();
}

class _VideoLiveWidget2State extends State<VideoLiveWidget2> {
  late VideoPlayerController _controller;

  late bool _isPlaying;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      '${widget.videoUrl}',
    )..initialize().then((_) {
      setState(() {
        _isPlaying = true;
      });
      _controller.play();
    });
    _isPlaying = false;
    _controller.addListener(() {
      setState(() {
        _sliderValue = _controller.value.position.inSeconds.toDouble();
      });
    });
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
        FocusDetector(
          onFocusLost: (){
            _controller.pause();
          },
          onFocusGained: (){
            try {
              _controller.play();
            }  catch (e) {
              // TODO
            }

          },
          child: Stack(
            children: [
              // Screenshot(
              //   controller: liveController.screenshotController,
              //   child: AspectRatio(
              //     aspectRatio: _controller.value.aspectRatio,
              //     child: VideoPlayer(_controller),
              //   ),
              // ),
              Positioned(
                top: 4.h,
                left: 3.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.sp),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaY: 8,
                        sigmaX: 8
                    ),
                    child: GestureDetector(
                      onTap: (){
                        Get.back();


                      },
                      child: Container(
                        height: 5.h,
                        width: 18.w,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14.sp)
                        ),
                        child: Transform.scale(
                            scale: 0.4,
                            child: SvgPicture.asset(AppIcon.backIcon , color: AppColor.whiteColor,)),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _isPlaying ? _controller.pause() : _controller.play();
                  _isPlaying = !_isPlaying;
                });
              },
            ),
            Expanded(
              child: Material(
                child: Slider(
                  value: _sliderValue.clamp(0.0, _controller.value.duration.inSeconds.toDouble()),
                  min: 0.0,
                  max: _controller.value.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      _controller.seekTo(Duration(seconds: value.toInt()));
                    });
                  },
                ),
              ),
            ),
            IconButton(onPressed: (){
            },
                icon: Image.asset(AppIcon.fullscreenIcon , scale: 23.sp, color: Colors.white,))

          ],
        ),


      ],
    ): Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.h),
      child: CircularProgressIndicator(),
    );
  }
}