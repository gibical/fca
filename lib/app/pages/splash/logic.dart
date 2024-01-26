import 'package:get/get.dart';

import '../../common/app_route.dart';
import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();
  var showSplash = true.obs;

  void hideSplashAndNavigateToNextScreen() {
    showSplash.value = false;
    Get.offAndToNamed(PageRoutes.PROFILE);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
