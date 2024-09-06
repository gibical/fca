import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rtmp_broadcaster/camera.dart';
import 'dart:io';

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

  int selectedCamera = 1;

  bool get isControllerInitialized => controller?.value.isInitialized ?? false;
  bool get isStreaming => controller?.value.isStreamingVideoRtmp ?? false;
  bool get isRecordingVideo => controller?.value.isRecordingVideo ?? false;
  bool get isRecordingPaused => controller?.value.isRecordingPaused ?? false;
  bool get isStreamingPaused => controller?.value.isStreamingPaused ?? false;
  bool get isTakingPicture => controller?.value.isTakingPicture ?? false;


  @override
  void onInit() {
    super.onInit();
    initMethod();
  }

  Future<void> initMethod() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description ?? "No description found");
    }
  await onNewCameraSelected(
      cameras[selectedCamera]);
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
      return null;
    }
  }

  Future<String?> startVideoStreaming() async {
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
    if (controller == null || !isControllerInitialized) return;
    if (!controller!.value.isStreamingVideoRtmp!) return;

    try {
      await controller!.stopVideoStreaming();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
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
    Future.delayed(Duration(seconds: 2));
    initMethod();


    if(selectedCamera==1){
      selectedCamera=0;
    }else{
      selectedCamera=1;

    }
    onNewCameraSelected(cameras[selectedCamera]);
  }
}
