import 'package:get/get.dart';

import 'logic.dart';

class VideoEditorState implements Bindings {


  @override
  void dependencies() {
    Get.put(VideoEditorController());
  }
}
