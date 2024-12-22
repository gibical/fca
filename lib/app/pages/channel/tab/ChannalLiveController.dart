import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

class ChannelMainVideoLiveController extends GetxController {
   VlcPlayerController? playerController;

  var sliderValue = 0.0.obs;
  var position = ''.obs;
  var duration = ''.obs;
  var validPosition = false.obs;
  var isPlaying = false.obs;
  var totalDuration = Duration.zero.obs;


  final String videoUrl;

  ChannelMainVideoLiveController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    playerController = VlcPlayerController.network(
      videoUrl,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    playerController!.addListener(_updatePlayerState);


  }



  void _updatePlayerState() {
    if (!playerController!.value.isInitialized) return;

    final currentPosition = playerController!.value.position;
    final currentDuration = playerController!.value.duration;

    position.value =
    "${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}";
    duration.value =
    "${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')}";

    validPosition.value = currentDuration.compareTo(currentPosition) >= 0;
    sliderValue.value =
    validPosition.value ? currentPosition.inSeconds.toDouble() : 0.0;
    isPlaying.value = playerController!.value.isPlaying;
    totalDuration.value = currentDuration;
  }

  void togglePlaying() {
    if (isPlaying.value) {
      playerController!.pause();
    } else {
      playerController!.play();
    }
  }

  void onSliderPositionChanged(double value) {
    sliderValue.value =value;
  playerController!.setTime(sliderValue.toInt() * Duration.millisecondsPerSecond);
}


@override
  void onClose() {
    playerController!.removeListener(_updatePlayerState);
    playerController!.dispose();
    super.onClose();
  }
}
