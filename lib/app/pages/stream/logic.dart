import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rtmp_broadcaster/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../gen/model/json/walletV2/FromJsonGetPrograms.dart';
import '../channel/view.dart';
import '../share_account/logic.dart';

class StreamViewController extends GetxController {
  CameraController? controller;
  String? imagePath;
  String? videoPath;
  String? url;
  bool enableAudio = true;
  bool useOpenGL = true;
  List<CameraDescription> cameras = [];
  bool isVisible = true;
  var isLoading = true.obs;
   AnimationController? animationController;

  ProgramModel? programModel;
  ShareAccountLogic shareAccountLogic = Get.put(ShareAccountLogic(), tag: "stream");
  int selectedCamera;

  bool isScreenStreaming = false;
  Timer? _screenRecordingTimer;
  Duration _screenRecordingDuration = Duration.zero;
  var screenRecordingTime = ''.obs;
  var isScreenRecordingTimeVisible = false.obs;

  StreamViewController(this.selectedCamera);

  bool get isControllerInitialized => controller?.value.isInitialized ?? false;
  bool get isStreaming => controller?.value.isStreamingVideoRtmp ?? false;
  bool get isRecordingVideo => controller?.value.isRecordingVideo ?? false;
  bool get isRecordingPaused => controller?.value.isRecordingPaused ?? false;
  bool get isStreamingPaused => controller?.value.isStreamingPaused ?? false;
  bool get isTakingPicture => controller?.value.isTakingPicture ?? false;
  Timer? _recordingTimer;
  Duration _recordingDuration = Duration.zero;
  var recordingTime = ''.obs;
  var isRecordingTimeVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    const platform = MethodChannel('com.mediaverse.mediaverse/rtmp');

    platform.setMethodCallHandler((call) async {
      if (call.method == "stopTheStream") {

        stopScreenStreaming();
      }
    });
    initMethod();
  }

  Future<void> initMethod() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description ?? "No description found");
    }
    await onNewCameraSelected(cameras[selectedCamera]);
    isLoading(false);
  }

  Future<void> onNewCameraSelected(CameraDescription? cameraDescription) async {
    if (cameraDescription == null) return;

    if (controller != null) {
      await stopVideoStreaming();
      await controller?.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: enableAudio,
      androidUseOpenGL: useOpenGL,
    );

    controller!.addListener(() async {
      if (controller!.value.hasError) {
        await stopVideoStreaming();
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  Future<String?> takePicture() async {
    if (!isControllerInitialized) return null;

    final Directory? extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir?.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (isTakingPicture) return null;

    try {
      await controller!.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    imagePath = filePath;
    return filePath;
  }

  Future<String?> startVideoRecording() async {
    if (!isControllerInitialized) return null;

    final Directory? extDir = await getExternalStorageDirectory();
    if (extDir == null) return null;

    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (isRecordingVideo) return null;

    try {
      videoPath = filePath;
      await controller!.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!isRecordingVideo) return;

    try {
      await controller!.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<String?> startVideoStreaming() async {
    animationController!.forward();
    Future.delayed(Duration(seconds: 4)).then((onValue){
      _startTimer();
    });
    if (!isControllerInitialized) return null;
    if (controller?.value.isStreamingVideoRtmp ?? false) return null;

    try {
      await controller!.startVideoStreaming(url!);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return url;
  }

  Future<void> stopVideoStreaming() async {
    try {
      _recordingTimer?.cancel();
      _recordingDuration = Duration.zero;
      recordingTime.value = '';
      isRecordingTimeVisible(false);
    } catch (e) {
      // Handle exception
    }
    if (controller == null || !isControllerInitialized) return;
    if (!controller!.value.isStreamingVideoRtmp!) return;

    try {
      await controller!.stopVideoStreaming();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<void> pauseVideoStreaming() async {
    if (!controller!.value.isStreamingVideoRtmp!) return;

    try {
      await controller!.pauseVideoStreaming();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoStreaming() async {
    if (!controller!.value.isStreamingVideoRtmp!) return;

    try {
      await controller!.resumeVideoStreaming();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> startScreenStreaming() async {
    if (programModel!=null) {
      PermissionStatus microphoneStatus = await Permission.microphone.status;
      if (!microphoneStatus.isGranted) {
        microphoneStatus = await Permission.microphone.request();
      }

      if (microphoneStatus.isGranted) {
        try {
          final String result = await MethodChannel('com.mediaverse.mediaverse/rtmp').invokeMethod('startScreenShare', {
            'rtmpUrl': programModel!.streamURL,
          });
          print(result);

          isScreenStreaming = true;
          isScreenRecordingTimeVisible(true);
          _screenRecordingDuration = Duration.zero;
          _screenRecordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            _screenRecordingDuration += Duration(seconds: 1);
            screenRecordingTime.value = _formatDuration(_screenRecordingDuration);
            update();
          });
        } on PlatformException catch (e) {
          print("Failed to start screen streaming: '${e.message}'.");
        }
      } else {
        print('Microphone permission denied');
      }
    }else{
      Constant.showMessege("You must Select Program First");
    }
  }

  Future<void> stopScreenStreaming() async {
    try {
      final String result = await MethodChannel('com.mediaverse.mediaverse/rtmp').invokeMethod('stopScreenShare');
      print(result);

      isScreenStreaming = false;
      _screenRecordingTimer?.cancel();
      _screenRecordingDuration = Duration.zero;
      screenRecordingTime.value = '';
      isScreenRecordingTimeVisible(false);
    } on PlatformException catch (e) {
      print("Failed to stop screen streaming: '${e.message}'.");
    }
  }

  void logError(String code, String? message) {
    print('Error: $code\nError Message: $message');
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onRefreshCamera() {
    isLoading(true);
    stopVideoRecording();
    stopVideoStreaming();
    try {
      controller?.dispose();
    } catch (e) {
      // Handle exception
    }
    Future.delayed(Duration(seconds: 2));
    if (selectedCamera == 1) {
      selectedCamera = 0;
    } else {
      selectedCamera = 1;
    }
    initMethod();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void deleteProgram(String? id) {
  }

  int getUnselectedCamera() {
    if (selectedCamera == 0) {
      return 1;
    } else if (selectedCamera == 1) {
      return 0;
    } else {
      return 0;
    }
  }

  void goToChannelScreen() async {
    ProgramModel programModel = await Get.to(ChannelScreen(), arguments: [true]);
    this.programModel = programModel;
    url = programModel.streamURL;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _screenRecordingTimer?.cancel();
    _recordingTimer?.cancel();
  }

  void _startTimer() {
    isRecordingTimeVisible(true);
    _recordingDuration = Duration.zero;
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _recordingDuration += Duration(seconds: 1);
      recordingTime.value = _formatDuration(_recordingDuration);
      update();
    });
  }
}
