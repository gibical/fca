import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/tabs/image/most_image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/font_style.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';


class ImageTabScreen extends StatelessWidget {

  HomeLogic logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return FocusDetector(
      onFocusGained: () {
        if (logic.imagesRecently.length == 0) {
          logic.sendImageRecentlyReuqest();
        }
      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),

                TitleExplore(theme: theme,
                    textTheme: textTheme,
                    icon: "assets/icons/sound_icons.svg",
                    title: 'Best in month'),
                SizedBox(height: 1.5.h),
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                      itemCount: logic.mostImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return MostImageWidget(
                            logic.mostImages.elementAt(index));
                      }),
                ),
                TitleExplore(theme: theme,
                    textTheme: textTheme,
                    icon: "assets/icons/sound_icons.svg",
                    title: 'Recently'),

                SizedBox(height: 4.h,),

                Obx(() {
                var isloadingImage = logic.imagesRecently.length==0;
                if(isloadingImage){
                  return Container(
                    child: Lottie.asset("assets/json/Y8IBRQ38bK.json",height: 10.h),
                  );
                }
                return Column(
                  children: [
                    Container(child: CustomGridImageWidget(logic.imagesRecently.value)),
                    Container(child: CustomGridImageWidget(logic.imagesRecently.value,isReversed: true,)),
                    Container(child: CustomGridImageWidget(logic.imagesRecently.value,isReversed: false,)),
                  ],
                );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
