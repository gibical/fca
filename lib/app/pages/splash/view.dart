import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SplashLogic());
    final state = Get.find<SplashLogic>().state;

    return Container();
  }
}
