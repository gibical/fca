import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/stream/logic.dart';
import 'package:mediaverse/gen/model/json/walletV2/FromJsonGetPrograms.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import 'package:rtmp_broadcaster/camera.dart';

import '../../../common/app_color.dart';
import '../../channel/view.dart';
import '../../wrapper/logic.dart';


class CameraExampleHome extends StatefulWidget {
  @override
  State<CameraExampleHome> createState() => _CameraExampleHomeState();
}

class _CameraExampleHomeState extends State<CameraExampleHome>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    try {
      _streamController.animationController!.dispose();
      _streamController.animationController = null;
    } catch (e) {
      // TODO
    }
    _streamController.animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _streamController.animationController!.dispose();
    _streamController.stopVideoStreaming();

    super.dispose();
  }

  StreamViewController _streamController = Get
      .find<WrapperController>()
      .streamViewController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamViewController>(
        init: _streamController,
        tag: "main",

        builder: (logic) {
          return Scaffold(

            body: Obx(() {
              return _streamController.isLoading.value ? Center(
                child: Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json", height: 5.h),
              ) : Container(
                width: 100.w,
                height: 100.h,

                child: Stack(
                  children: <Widget>[
                    SizedBox.expand(
                      child: _cameraPreviewWidget(),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: 120,
                          width: 100.w,

                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                children: [
                                  SizedBox.expand(child: Image.asset(
                                    "assets/${F.assetTitle}/images/plus_base.png",
                                    fit: BoxFit.fitWidth,)),

                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (_streamController
                                            .isRecordingTimeVisible.value) {
                                          _streamController
                                              .stopVideoStreaming();
                                        } else {
                                          _streamController
                                              .startVideoStreaming();
                                        }
                                      },

                                      onLongPressStart: (l) {

                                      },
                                      onLongPressEnd: (h) {

                                      },
                                      child: Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: "#030340".toColor(),
                                              shape: BoxShape.circle
                                          ),
                                          margin: EdgeInsets.only(top: 15),
                                          child: Obx(() {
                                            return SvgPicture.asset(//
                                                (!logic
                                                    .isRecordingTimeVisible
                                                    .value)
                                                    ? "assets/mediaverse/icons/record-button.svg"
                                                    : "assets/mediaverse/icons/record.svg",fit: BoxFit.fill,);
                                          })),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        width: 40.w,
                                        height: 55,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        margin: EdgeInsets.only(
                                            right: 0, bottom: 10),
                                        child: MaterialButton(
                                            onPressed: () {

                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    6000)
                                            ),


                                            child: Obx(() {
                                              return Center(
                                                  child: _streamController
                                                      .shareAccountLogic
                                                      .isloading.value
                                                      ? Lottie.asset(
                                                      "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                                                      height: 3.h)
                                                      : Text(_streamController
                                                      .programModel == null
                                                      ? "Insert Program Here"
                                                      : _streamController
                                                      .programModel!.name
                                                      .toString()));
                                            }))),
                                  ),
                                ],
                              ))),

                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SafeArea(
                        child: Container(
                          width: 5.w,
                          height: 5.w,
                          margin: EdgeInsets.all(2.w),
                          child: MaterialButton(
                              padding: EdgeInsets.zero,

                              onPressed: () {
                                logic.onRefreshCamera();
                              },
                              child: SvgPicture.asset(
                                "assets/${F.assetTitle}/icons/sync.svg", color: Colors.white,)),
                        ),
                      ),
                    ),
                    Obx(() {
                      return Visibility(
                        visible: _streamController.isRecordingTimeVisible.value,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SafeArea(
                            child: Container(
                              width: 20.w,
                              height: 4.h,
                              margin: EdgeInsets.only(
                                  top: 1.w,
                                  right: 14.w
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(400)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/${F.assetTitle}/images/record.svg"),
                                  Text(
                                    _streamController.recordingTime.value,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    Lottie.asset("assets/${F.assetTitle}/json/countdown.json",
                      controller: _streamController.animationController,
                      onLoaded: (composition) {
                        _streamController.animationController!
                          ..duration = composition.duration;
                      },)
                  ],
                ),
              );
            }),
          );
        });
  }

  Widget _cameraPreviewWidget() {
    return CameraPreview(_streamController.controller!,);
  }

  Widget _toggleAudioWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          const Text('Enable Audio:'),
          Switch(
            value: _streamController.enableAudio,
            onChanged: (bool value) {
              _streamController.enableAudio = value;
              if (_streamController.controller != null) {
                _streamController.onNewCameraSelected(
                    _streamController.controller!.description);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _streamController.imagePath == null
                ? Container()
                : SizedBox(
              child: Image.file(File(_streamController.imagePath!)),
              width: 64.0,
              height: 64.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: _streamController.isControllerInitialized
              ? () async {
            await _streamController.takePicture();
          }
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: _streamController.isControllerInitialized &&
              !_streamController.isRecordingVideo
              ? () async {
            await _streamController.startVideoRecording();
          }
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: _streamController.isControllerInitialized &&
              _streamController.isRecordingVideo
              ? () async {
            await _streamController.stopVideoRecording();
          }
              : null,
        ),
      ],
    );
  }

  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (_streamController.cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in _streamController.cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: _streamController.controller?.description,
              value: cameraDescription,
              onChanged: (CameraDescription? cld) =>
              _streamController.isRecordingVideo ? null : _streamController
                  .onNewCameraSelected(cld),
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  IconData getCameraLensIcon(CameraLensDirection? direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
      default:
        return Icons.camera;
    }
  }


}
