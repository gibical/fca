

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/setting/view.dart';

class WrapperController extends GetxController {
  final PageController pageController = PageController(initialPage: 0);
  Rx<int> selectedIndex = Rx<int>(0);
  navigatePages(int index) {
    selectedIndex.value = index;
    pageController..animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    final _appLinks = AppLinks();


    _appLinks.allUriLinkStream.listen((uri) {
      print('WrapperController.onReady allUriLinkStream = ${uri}');
      parseAndNavigate(uri);
    });
  }

  void parseAndNavigate(Uri uri) {
    if (uri.host == 'media.verse') {
      if (uri.toString().contains('page')) {
        String? page = uri.queryParameters['page'];
        if (page == 'profile') {

          navigatePages(3);
        }
        if (page == 'wallet') {
          navigatePages(2);

        }
        if (page == 'setting') {

          Get.to(SettingScreen());
          navigatePages(3);

        } else if (page == 'single') {
          String? type = uri.queryParameters['type'].toString();
          String? id = uri.queryParameters['id'].toString();
          String route = PageRoutes.DETAILVIDEO;

          switch(type){
            case "1":
              route = PageRoutes.DETAILTEXT;
            case "2":
              route = PageRoutes.DETAILIMAGE;
            case "3":
              route = PageRoutes.DETAILMUSIC;
            case "4":
              route = PageRoutes.DETAILVIDEO;

          }
          Get.toNamed(route,arguments: {'id': id});
        }
      }
    }
  }
}