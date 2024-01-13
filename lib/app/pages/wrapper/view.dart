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

    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GetX<WrapperController>(
      builder: (builderController) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ItemBottomNavBar(
              color: AppColor.whiteColor,
              iconActiveColor: AppColor.whiteColor,
              iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
              activeColor: AppColor.primaryDarkColor,
              icon: AppIcon.exploreIcon,
              indexItem: 0
          ),
          ItemBottomNavBar(
              color: AppColor.whiteColor,
              iconActiveColor: AppColor.whiteColor,
              iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
              activeColor: AppColor.primaryDarkColor,
              icon: AppIcon.addIcon,
              indexItem: 1
          ),
          ItemBottomNavBar(
              color: AppColor.whiteColor,
              iconActiveColor: AppColor.whiteColor,
              iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
              activeColor: AppColor.primaryDarkColor,
              icon: AppIcon.profileIcon,
              indexItem: 2
          ),
          ItemBottomNavBar(
              color: AppColor.whiteColor,
              iconActiveColor: AppColor.whiteColor,
              iconColor: AppColor.primaryDarkColor.withOpacity(0.2),
              activeColor: AppColor.primaryDarkColor,
              icon: AppIcon.profileIcon,
              indexItem: 3
          ),
          // IconButton(
          //   onPressed: () {
          //     builderController.navigatePages(0);
          //   },
          //   icon: Icon(Icons.verified_user , color: builderController.selectedIndex.value==0 ? theme.primary : theme.surface,),
          //   splashColor: Colors.transparent,
          //   highlightColor: Colors.transparent,
          // ),


        ],
      ),
    );
  }
}


Widget ItemBottomNavBar({
  required Color color ,
  required Color activeColor,
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
        color: builderController.selectedIndex.value== indexItem ? activeColor : color,
        child: Center(child: SvgPicture.asset(icon , color: builderController.selectedIndex.value== indexItem ? iconActiveColor : iconColor,)),
          ),
      )
  );
}