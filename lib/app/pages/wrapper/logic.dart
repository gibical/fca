

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WrapperController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  Rx<int> selectedIndex = Rx<int>(0);
  navigatePages(int index) {
    selectedIndex.value = index;
    pageController..animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }


}
