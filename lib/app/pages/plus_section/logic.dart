import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/pages/plus_section/widget/first_form.dart';

import 'state.dart';

class PlusSectionLogic extends GetxController {

  TextEditingController titleController = TextEditingController();
  TextEditingController planController = TextEditingController(text: "Free");
  TextEditingController editibaleController = TextEditingController(text: "yes");
  TextEditingController captionController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController subscrptionController = TextEditingController();





  final PlusSectionState state = PlusSectionState();
  MediaMode mediaMode = MediaMode.image;
  CameraController? controller;
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    initCamera();
    planController.addListener(() {
      update();
    });
  }
  var imageFile;
  late List<CameraDescription> _cameras;


  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      Constant.showMessege('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    Get.to(FirstForm(),arguments: [this]);

    try {
      final XFile file = await cameraController.takePicture();
      imageFile = file;
      print('PlusSectionLogic.takePicture Picture saved to  = ${file.path}');
      return file;
    } on CameraException catch (e) {
     // _showCameraException(e);
      return null;
    }
  }
  void initCamera()async{
    _cameras = await availableCameras();

    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller!.initialize().then((_) {

     update();
    }).catchError((Object e) {
      if (e is CameraException) {
        print('_PlusSectionPageState.initState = ${e.description}');
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.

            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }


  @override
  void onClose() {
    super.onClose();
    controller!.dispose();

  }

  getTopIcon() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return 2;
      case MediaMode.image:
        // TODO: Handle this case.
        return 1;

      case MediaMode.text:
        // TODO: Handle this case.
        return 3;
    }
  }

  getLeftIcon() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return 1;
      case MediaMode.image:
        // TODO: Handle this case.
        return 2;
      case MediaMode.text:
        // TODO: Handle this case.
        return 1;
    }
  }

  getRightIcon() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        return 3;
      case MediaMode.image:
        // TODO: Handle this case.
        return 3;
      case MediaMode.text:
        // TODO: Handle this case.
        return 2;
    }
  }

  void middleClick() {
    switch (mediaMode) {
      case MediaMode.audio:
      // TODO: Handle this case.
        break;
      case MediaMode.image:
        takePicture();
      // TODO: Handle this case.
    break;
      case MediaMode.text:

        break;
      // TODO: Handle this case.
    }
  }

  void getLeftClick() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        mediaMode = MediaMode.image;
      case MediaMode.image:
        // TODO: Handle this case.
        mediaMode = MediaMode.audio;

      case MediaMode.text:
        // TODO: Handle this case.
        mediaMode = MediaMode.image;
    }
    update();
  }

  void getRightClick() {
    switch (mediaMode) {
      case MediaMode.audio:
        // TODO: Handle this case.
        mediaMode = MediaMode.text;
      case MediaMode.image:
        // TODO: Handle this case.
        mediaMode = MediaMode.text;

      case MediaMode.text:
        // TODO: Handle this case.
        mediaMode = MediaMode.audio;
    }
    update();
  }
}

enum MediaMode { audio, image, text }
