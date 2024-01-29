import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_tab_bar_widget.dart';


class SubscribeTabScreen extends StatelessWidget {

  HomeLogic logic = Get.find<HomeLogic>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBarWidget(logic),
    );
  }
}
