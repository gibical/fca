import 'dart:typed_data';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
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
  final SingleChannelLogic logic;
  final String title;
  final String liveID;

  const ChannelVideoLiveWidget({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.liveID,
    required this.logic,
  }) : super(key: key);

  @override
  _ChannelVideoLiveWidgetState createState() => _ChannelVideoLiveWidgetState();
}

class _ChannelVideoLiveWidgetState extends State<ChannelVideoLiveWidget> {
  late bool _isPlaying;
  double _sliderValue = 0.0;
  var chewieController;
  var isErrorHandling = false.obs;

  @override
  void initState() {
    super.initState();
    try {
      widget.logic.controllerVideoPlay = VideoPlayerController.network(
        widget.videoUrl,
      )..initialize().then((_) {
        chewieController = ChewieController(
          videoPlayerController: widget.logic.controllerVideoPlay,
          autoPlay: true,
          looping: true,
        );
        setState(() {});
      });
      widget.logic.controllerVideoPlay.addListener(() {
        if (widget.logic.controllerVideoPlay.value.hasError) {
          // Handle error
        }
      });
    } catch (e) {
      print('_VideoLiveWidgetState.initState catch: $e');
    }
  }

  @override
  void dispose() {
    widget.logic.controllerVideoPlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.logic.controllerVideoPlay.value.isInitialized
        ? FocusDetector(
      onFocusLost: () {
        try {
          widget.logic.controllerVideoPlay.pause();
        } catch (e) {
          // Handle exception
        }
      },
      onFocusGained: () {
        try {
          widget.logic.controllerVideoPlay.play();
        } catch (e) {
          // Handle exception
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
                TextButton(
                  onPressed: () {
                    widget.logic.switchTo(widget.liveID);
                  },
                  child: Text(
                    "Switch",
                    style: TextStyle(color: AppColor.primaryLightColor),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Screenshot(
                  controller: widget.logic.screenshotController,
                  child: AspectRatio(
                    aspectRatio:
                    widget.logic.controllerVideoPlay.value.aspectRatio,
                    child: Chewie(
                      controller: chewieController,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Center(
        child: Text("Live is Starting Right Now"),
      ),
    );
  }
}
class ChannelMainVideoLiveWidget extends StatelessWidget {
  ChannelMainVideoLiveController controller;


  ChannelMainVideoLiveWidget(this.controller);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ColoredBox(
            color: Colors.black,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                if(controller.playerController!=null)Center(
                  child: VlcPlayer(
                    controller: controller.playerController!,
                    aspectRatio: 16 / 9,
                    placeholder:
                    const Center(child: CircularProgressIndicator()),
                  ),
                ),
                if(controller.playerController!=null) ControlsOverlay(controller: controller.playerController!),
              ],
            ),
          ),
        ),
        Obx(() => Visibility(
          visible: true,
          child: ColoredBox(
            color: Colors.black87,
            child: Row(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: controller.isPlaying.value
                      ? const Icon(Icons.pause_circle_outline)
                      : const Icon(Icons.play_circle_outline),
                  onPressed: controller.togglePlaying,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.position.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: Slider(
                          activeColor: Colors.blueAccent,
                          inactiveColor: Colors.white70,
                          value: controller.sliderValue.value,
                          max: controller.validPosition.value
                              ? controller.totalDuration.value.inSeconds
                              .toDouble()
                              : 1.0,
                          onChanged: controller.validPosition.value
                              ? controller.onSliderPositionChanged
                              : null,
                        ),
                      ),
                      Text(
                        controller.duration.value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}

