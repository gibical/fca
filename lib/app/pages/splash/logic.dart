import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/app_route.dart';
import 'state.dart';

class SplashLogic extends GetxController {
  final SplashState state = SplashState();
  var showSplash = true.obs;

  void hideSplashAndNavigateToNextScreen() async{
    showSplash.value = false;
    if(GetStorage().read("islogin")??false){

      Get.offAndToNamed(PageRoutes.WRAPPER);
    }else{
      Get.offAndToNamed(PageRoutes.INTRO);

    }
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
