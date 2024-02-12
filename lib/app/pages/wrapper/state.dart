
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:mediaverse/app/pages/wrapper/logic.dart';

class WrapperState implements Bindings {


  @override
  void dependencies() {
    Get.put(WrapperController());
  }
}