import 'package:get/get.dart';
import 'logic.dart';


class MediaSuitState implements Bindings {



  @override
  void dependencies() {
    Get.put(MediaSuitController());
  }

}