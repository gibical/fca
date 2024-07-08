import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibical/app/pages/home/logic.dart';
import 'package:gibical/app/pages/home/widgets/custom_tab_bar_widget.dart';
import 'package:gibical/app/pages/wrapper/logic.dart';
import 'package:gibical/app/widgets/custom_app_bar_widget.dart';

class HomeScreen extends GetView< WrapperController> {

  HomeLogic homeLogic = Get.put(HomeLogic());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor:  Theme.of(context).colorScheme.background,
        appBar: CustomAppBarWidget(context),
        body:  CustomTabBarWidget(homeLogic),

    );
  }
}


