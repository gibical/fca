import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class PlayerVideo extends StatefulWidget {
  const PlayerVideo({super.key});

  @override
  State<PlayerVideo> createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo>     with WidgetsBindingObserver {
  final logic = Get.put(DetailController(4));



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (logic.videoPlayerController!.value.isPlaying) {
        logic.videoPlayerController!.pause();
      } else {
        logic.videoPlayerController!.play();
      }
      logic.isPlayingNotifier.value =
          logic.videoPlayerController!.value.isPlaying;
      logic.showIconPlayPause.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (logic.loadingVideo.value ) {
        return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
              backgroundColor: AppColor.primaryColor.withOpacity(0.2),
            ));
      } else {
        return GestureDetector(
          onTap: _togglePlayPause,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
          borderRadius: BorderRadius.circular(14.sp),
                child: Container(
                  height: 350,
                  width: 400,

                  child: Chewie(controller: logic.chewieController! ,),
                ),
              ),
              Obx(() {
                return AnimatedOpacity(
                  opacity: logic.showIconPlayPause.value ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Icon(
                    logic.isPlayingNotifier.value
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 50.sp,
                    color: Colors.white,
                  ),
                );
              }),

            ],
          ),
        );
      }
    });
  }
}

class CustomControls extends StatefulWidget {
  final ValueNotifier<bool> isPlayingNotifier;

  CustomControls({required this.isPlayingNotifier});

  final DetailController logic = Get.find<DetailController>();

  @override
  _CustomControlsState createState() => _CustomControlsState();
}

class _CustomControlsState extends State<CustomControls> {
  final logic = Get.find<DetailController>();
  void _onSliderChange(double value) {
    final position =
        logic.videoPlayerController!.value.duration * value; // Calculate duration
    logic.videoPlayerController!.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    String _formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Directionality(
          textDirection: TextDirection.ltr,
          child:     Obx(() {
            final totalDuration =
            logic.videoPlayerController!.value.duration.inMilliseconds.toDouble();
            final current =
            logic.currentPosition.value.inMilliseconds.toDouble().clamp(0, totalDuration);

            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4.0,
                thumbColor: AppColor.whiteColor,
                activeTrackColor: AppColor.primaryColor,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
              ),
              child: Slider(
                value: current.isNaN ? 0 : current / totalDuration,
                onChanged: (value) => _onSliderChange(value),

                inactiveColor: Colors.grey.withOpacity(0.4),
              ),
            );
          }),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                widget.logic.chewieController!.isFullScreen
                    ? Icons.fullscreen_exit
                    : Icons.fullscreen,
                color: Colors.white,
              ),
              onPressed: () {
                widget.logic.chewieController!.enterFullScreen();
              },
            ),

            Spacer(),
            ValueListenableBuilder<bool>(
              valueListenable: widget.isPlayingNotifier,
              builder: (context, isPlaying, child) {
                return Obx(() {
                  return Text(
                    '${_formatDuration(widget.logic.currentPosition
                        .value)} / ${_formatDuration(
                        widget.logic.videoPlayerController!.value.duration)}',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  );
                });
              },
            ),
            SizedBox(width: 8.0.sp),
            IconButton(
              icon: Icon(
                widget.logic.videoPlayerController!.value.volume > 0
                    ? Icons.volume_up
                    : Icons.volume_off,
                color: Colors.white,
              ),
              onPressed: () {
                if (widget.logic.videoPlayerController!.value.volume > 0) {
                  widget.logic.videoPlayerController!.setVolume(0);
                } else {
                  widget.logic.videoPlayerController!.setVolume(1.0);
                }
                setState(() {});
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: widget.isPlayingNotifier,
              builder: (context, isPlaying, child) {
                return IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      widget.logic.videoPlayerController!.pause();
                    } else {
                      widget.logic.videoPlayerController!.play();
                    }
                    widget.isPlayingNotifier.value = !isPlaying;
                  },
                );
              },
            ),
          ],
        ),
        SizedBox(height: 6.sp),
      ],
    );
  }
}