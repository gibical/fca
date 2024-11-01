import 'package:get/get.dart';
import 'package:mediaverse/app/pages/live/logic.dart';



class LiveState implements Bindings {



  @override
  void dependencies() {
    Get.put(LiveController());
  }

}
