import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class RtmpStreamManager {
  static const _platform = MethodChannel('com.app.mediaverse/rtmp');

  Future<void> startStreaming(String rtmpUrl) async {
    // Step 1: Request camera and microphone permissions
    PermissionStatus cameraStatus = await _requestCameraPermission();
    PermissionStatus microphoneStatus = await _requestMicrophonePermission();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      // Step 2: If both permissions are granted, start screen sharing
      try {
        final String result = await _platform.invokeMethod('startScreenShare', {
          'rtmpUrl': rtmpUrl,
        });
        print(result); // Handle success
      } on PlatformException catch (e) {
        print("Failed to start streaming: '${e.message}'.");
      }
    } else {
      print('Permissions denied');
      if (!cameraStatus.isGranted) {
        print('Camera permission denied');
      }
      if (!microphoneStatus.isGranted) {
        print('Microphone permission denied');
      }
    }
  }

  Future<PermissionStatus> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    return status;
  }

  Future<PermissionStatus> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status;
  }

  Future<void> stopStreaming() async {
    try {
      final String result = await _platform.invokeMethod('stopScreenShare');
      print(result); // Handle success
    } on PlatformException catch (e) {
      print("Failed to stop streaming: '${e.message}'.");
    }
  }
}
