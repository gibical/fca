import 'package:get/get.dart';

import 'logic.dart';

class HomeState implements Bindings {



  @override
  void dependencies() {
  Get.put(HomeLogic());
  }

}
