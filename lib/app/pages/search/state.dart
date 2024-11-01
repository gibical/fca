import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:mediaverse/app/pages/search/logic.dart';

class SearchState implements Bindings {


  @override
  void dependencies() {
    Get.put(SearchLogic());
  }
}