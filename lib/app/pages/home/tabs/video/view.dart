import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/home/widgets/card_live_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_grid_image_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/item_video_tab_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../detail/logic.dart';
import '../../../detail/view.dart';
import '../../logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';

class VideoTabScreen extends StatelessWidget {
  Function onClick;

  Function onSendRequest;
  RxList<dynamic> list = <dynamic>[].obs;

  VideoTabScreen(
      {required this.onClick, required this.onSendRequest, required this.list});


  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
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
              Obx(() {
                return SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.find<DetailController>().selectedItem.value = list.reversed
                                .toList().elementAt(index);

                            Get.toNamed(PageRoutes.DETAILVIDEO);
                          },
                          child: BestItemExploreWidget(list.reversed
                              .toList().elementAt(index)),
                        );
                      }),
                );
              }),
              SizedBox(height: 2.h),
              TitleExplore(theme: theme,
                  textTheme: textTheme,
                  icon: "assets/icons/sound_icons.svg",
                  title: 'Recently'),


              SizedBox(height: 1.5.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.find<DetailController>().selectedItem.value = list.reversed
                          .toList().elementAt(index);

                      Get.toNamed(PageRoutes.DETAILVIDEO);
                    },
                    child: ItemVideoTabScreen(
                        list.reversed.toList().elementAt(index)),
                  );
                },
              ),
              SizedBox(height: 7.h),
            ],
          ),
        ),
      ),
    );
  }
}
