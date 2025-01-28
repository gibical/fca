import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:mediaverse/app/pages/plus/widgets/perimisson_bottom_sheet.dart';
import 'package:mediaverse/app/pages/plus/widgets/plus_camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'state.dart';

class PlusLogic extends GetxController {
  final PlusState state = PlusState();
  final GlobalKey containerKey = GlobalKey();

  late List<CameraDescription> _cameras;
  CameraController? controller;

  PlusAspectRatio aspectRatio = PlusAspectRatio.post;

  var isRecordingTimeVisible = false.obs;
  var recordingTime = ''.obs;

  Timer? _recordingTimer;
  Duration _recordingDuration = Duration.zero;

  String videoOutPut = "";
  String imageOutPut = "";

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  @override
  void onReady() {
    super.onReady();
    _checkPermissionAndNavigate();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  Future<bool> _checkAllPermissions() async {
    final permissions = [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
    ];
    final statuses = await Future.wait(permissions.map((p) => p.status));
    return statuses.every((s) => s.isGranted);
  }

  Future<void> requestPermissions() async {
    final permissions = [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
    ];
    final statuses = await permissions.request();
    if (statuses.values.every((s) => s.isGranted)) {
      _checkPermissionAndNavigate();
    } else {
      Get.bottomSheet(PerimissonBottomSheet(), isScrollControlled: true);
    }
  }

  void initCamera() async {
    _cameras = await availableCameras();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {
      update();
    }).catchError((e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  void _checkPermissionAndNavigate() async {
    if (await _checkAllPermissions()) {
      Get.to(() => PlusCameraScreen());
    } else {
      Get.bottomSheet(PerimissonBottomSheet(), isScrollControlled: true);
    }
  }

  Future<void> startVideoRecording() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (controller!.value.isRecordingVideo) return;
    try {
      await controller!.startVideoRecording();
      isRecordingTimeVisible.value = true;
      _startVideoRecordingTimer();
      update();
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> stopVideoRecording() async {
    if (controller == null) return;
    if (!controller!.value.isRecordingVideo) return;
    try {
      XFile video = await controller!.stopVideoRecording();
      videoOutPut = video.path;
      isRecordingTimeVisible.value = false;
      _stopVideoRecordingTimer();
      update();
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) return null;
    if (controller!.value.isTakingPicture) return null;
    try {
      final XFile file = await controller!.takePicture();
      imageOutPut = file.path;
      update();
      return file;
    } on CameraException catch (e) {
      print('Error taking picture: ${e.description}');
      return null;
    }
  }

  void _startVideoRecordingTimer() {
    _recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordingDuration += Duration(seconds: 1);
      recordingTime.value = _formatDuration(_recordingDuration);
      update();
    });
  }

  void _stopVideoRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingDuration = Duration.zero;
    recordingTime.value = '';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void startOrStopMediaRecording() {
    if(isRecordingTimeVisible.value){
      stopVideoRecording();
    }else{
      startVideoRecording();
    }
  }

  void selectFileFromGallery() {
    final theme = InstaAssetPicker.themeData(Theme.of(Get.context!).primaryColor);
    InstaAssetPicker.pickAssets(
      Get.context!,
      pickerConfig: InstaAssetPickerConfig(
        pickerTheme: theme.copyWith(
          canvasColor: Colors.black, // body background color
          splashColor: Colors.green, // ontap splash color
          colorScheme: theme.colorScheme.copyWith(
            background: Colors.black87, // albums list background color
          ),
          appBarTheme: theme.appBarTheme.copyWith(
            backgroundColor: Colors.black, // app bar background color
            titleTextStyle: Theme.of(Get.context!)
                .appBarTheme
                .titleTextStyle
                ?.copyWith(color: Colors.white), // change app bar title text style to be like app theme
          ),
          // edit `confirm` button style
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
              disabledForegroundColor: Colors.red,
            ),
          ),
        ),
      ),
      onCompleted: (_) {},
    );
  }
}

enum PlusAspectRatio {
  post,
  story
}
