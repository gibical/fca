

import 'package:flutter/material.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:get/get.dart';

class CustomeWidgetController extends StatefulWidget {
  const CustomeWidgetController({super.key});

  @override
  State<CustomeWidgetController> createState() =>
      _CustomeWidgetControllerState();
}

class _CustomeWidgetControllerState extends State<CustomeWidgetController> {
  final logic = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () async {
            if (logic.videoPlayerController!.value.isPlaying) {
              await logic.videoPlayerController!.pause();
            } else {
              await logic.videoPlayerController!.play();
            }
            setState(() {});
          },
          icon: logic.videoPlayerController!.value.isPlaying
              ? Icon(Icons.pause)
              : Icon(Icons.play_arrow),
        ),
      ],
    );
  }
}