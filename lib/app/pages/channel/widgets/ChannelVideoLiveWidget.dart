import 'dart:typed_data';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/channel/tab/ChannalLiveController.dart';
import 'package:mediaverse/app/pages/channel/tab/single_channel_logic.dart';
import 'package:mediaverse/app/pages/live/widgets/custom_video_live_widget2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import 'ControlsOverlay.dart';

class ChannelVideoLiveWidget extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String liveID;
  final Function(String liveID) onSwitch;

  const ChannelVideoLiveWidget({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.liveID,
    required this.onSwitch,
  }) : super(key: key);

  @override
  _ChannelVideoLiveWidgetState createState() => _ChannelVideoLiveWidgetState();
}

class _ChannelVideoLiveWidgetState extends State<ChannelVideoLiveWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl,  videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),)
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: false,
            looping: true,isLive: true,customControls: Container(),allowMuting: true
          );
          _chewieController?.setVolume(0);
          setState(() {});
        },);

      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.hasError) {
          print("Video player error: ${_videoPlayerController.value.errorDescription}");
        }
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? FocusDetector(
      onFocusLost: () {
        try {
          _videoPlayerController.pause();
        } catch (e) {
          print("Error pausing video: $e");
        }
      },
      onFocusGained: () {
        try {
          _videoPlayerController.play();
        } catch (e) {
          print("Error playing video: $e");
        }
      },
      child: Container(
        child: Column(
          children: [

            AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(
                _videoPlayerController
              ),
            ),
          ],
        ),
      ),
    )
        : Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text("Live is Starting Right Now"),
      ),
    );
  }
}

class ChannelMainVideoLiveWidget extends StatefulWidget {
  String url;

  ChannelMainVideoLiveWidget(this.url);

  @override
  State<ChannelMainVideoLiveWidget> createState() => _ChannelMainVideoLiveWidgetState();
}

class _ChannelMainVideoLiveWidgetState extends State<ChannelMainVideoLiveWidget> {
  late VideoPlayerController _videoPlayerController;

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    try {
      _videoPlayerController = VideoPlayerController.network(widget.url, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,allowBackgroundPlayback: true,),)
        ..initialize().then((_) {

          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: true,isLive: true,customControls: Container(),
          );

          setState(() {});
        });

      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.hasError) {
          print("Video player error: ${_videoPlayerController.value.errorDescription}");
        }
      });
    } catch (e) {
      print('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? FocusDetector(
      onFocusLost: () {
        try {
          _videoPlayerController.pause();
        } catch (e) {
          print("Error pausing video: $e");
        }
      },
      onFocusGained: () {
        try {
          _videoPlayerController.play();
        } catch (e) {
          print("Error playing video: $e");
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [

            AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: Chewie(
                controller: _chewieController!,
              ),
            ),
          ],
        ),
      ),
    )
        : Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Container(height: 20.h,child: Center(
        child: Text("Live is Not Available Right Now"),
      ),),
    );
  }
}

