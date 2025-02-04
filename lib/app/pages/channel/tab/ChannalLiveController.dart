import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelMainVideoLiveController extends GetxController {

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
  }


}