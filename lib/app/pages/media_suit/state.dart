import 'package:get/get.dart';
import 'package:mediaverse/app/pages/media_suit/logic.dart';


class MediaSuitState implements Bindings {



  @override
  void dependencies() {
    Get.put(MediaSuitController());
  }

}