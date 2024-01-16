import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_icon.dart';
import '../home/view.dart';
import 'logic.dart';
import 'package:flutter/material.dart';









class MainWrapperScreen extends GetView<WrapperController> {
  MainWrapperScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar:  BottomNavWidget() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 5,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        splashColor: Colors.transparent,
        backgroundColor: AppColor.primaryLightColor,
        onPressed: (){

        },
        child: Icon(Icons.add , color: Theme.of(context).colorScheme.onBackground,),
      ),
      body:
      PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [

          HomeScreen(),
          Scaffold(
            backgroundColor: Colors.amber,
            body: Center(
              child: Text('Add Screen' , style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.deepOrange,
            body: Center(
              child: Text('Profile Screen' , style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Center(
              child: Text('Profile Screen' , style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),


        ],
      ),

    );
  }
}



class BottomNavWidget extends GetView<WrapperController> {
  @override
  Widget build(BuildContext context) {
    return GetX<WrapperController>(
      builder: (builderController) => ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10 , sigmaX: 10),
          child: BottomAppBar(
            height: 10.h,
            color: Colors.white.withOpacity(0.2),
            shape: const CircularNotchedRectangle(), //shape of notch
            notchMargin: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemBottomNavBar(
                      iconActiveColor: AppColor.whiteColor,
                      iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
                      icon: AppIcon.exploreIcon,
                      indexItem: 0
                  ),
                  ItemBottomNavBar(
                      iconActiveColor: AppColor.whiteColor,
                      iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
                      icon: AppIcon.channelIcon,
                      indexItem: 1
                  ),
                  ItemBottomNavBar(
                      iconActiveColor: AppColor.whiteColor,
                      iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
                      icon: AppIcon.profileIcon,
                      indexItem: 2
                  ),
                  ItemBottomNavBar(
                      iconActiveColor: AppColor.whiteColor,
                      iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
                      icon: AppIcon.profileIcon,
                      indexItem: 3
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Widget ItemBottomNavBar({

  required Color iconColor ,
  required Color iconActiveColor,
  required String icon,
  required int indexItem,
  
}){
  final builderController = Get.find<WrapperController>();
  return   Expanded(
      child: GestureDetector(
        onTap: (){
          builderController.navigatePages(indexItem);
        },
        child: Container(
          height: 8.5.h,

          child: Center(child: SvgPicture.asset(icon , color: builderController.selectedIndex.value== indexItem ? iconActiveColor : iconColor, height: 25,)),
        ),
      )
  );
}