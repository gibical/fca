import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';


class TextTabScreen extends StatelessWidget {
  HomeLogic logic = Get.find<HomeLogic>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return   FocusDetector(
      onFocusGained: (){
        if (logic.textRecently.length == 0) {
          logic.sendTextRecentlyReuqest();
        }
      },
      child: Scaffold(
          backgroundColor: theme.background,
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child:  SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 13.h),
                  TitleExplore(theme: theme, textTheme: textTheme,
                      icon: "assets/icons/text_icon.svg", title: 'Top Text'),
                  SizedBox(height: 1.5.h),
                  SizedBox(
                    height: 40.w,
                    child: ListView.builder(
                        itemCount: logic.mostText.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return BestTextWidget(model: logic.mostText.elementAt(index));
                        }),
                  ),
                  SizedBox(height: 3.5.h),
      
                Obx(() {
                  var isloadingImage = logic.textRecently.length==0;
                  if(isloadingImage){
                    return Container(
                      child: Lottie.asset("assets/json/Y8IBRQ38bK.json",height: 10.h),
                    );
                  }
                  return Container(
                    height: 40.h,
                    child: GridView.builder(
                        itemCount: logic.textRecently.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                        ), itemBuilder: (s,q){
                      var item = logic.textRecently.elementAt(q);
                      return AspectRatio(
                        aspectRatio: 1/1,
                        child: BestTextWidget(model: item),
                      );
      
                    }),
                  );
                })
            
      
                ],
              ),
            ),
          )
      ),
    );
  }
}
