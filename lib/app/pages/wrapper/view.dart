
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/plus_section/view.dart';
import 'package:mediaverse/app/pages/wallet/view.dart';

import '../../widgets/bottomnavwidget.dart';
import '../home/view.dart';
import '../profile/view.dart';
import 'logic.dart';
import 'package:flutter/material.dart';

class MainWrapperScreen extends GetView<WrapperController> {
  MainWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomNavWidget(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          splashColor: Colors.transparent,
          backgroundColor: AppColor.primaryLightColor,
          onPressed: () {
            Get.to(PlusSectionPage());
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          HomeScreen(),
          Scaffold(
            backgroundColor: Colors.amber,
            body: Center(
              child: Text(
                'Add Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          WalletScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
