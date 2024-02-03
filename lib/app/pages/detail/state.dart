import 'package:get/get.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import '../home/logic.dart';

class DetailState implements Bindings {



  @override
  void dependencies() {
    Get.put(DetailController());
  }

}
