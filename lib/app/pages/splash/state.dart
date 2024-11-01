import 'package:get/get.dart';

import 'logic.dart';

class SplashState implements Bindings {


  @override
  void dependencies() {
    Get.put(SplashLogic());
  }
}
