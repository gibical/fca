import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return  RefreshIndicator(
      onRefresh: ()async{

        Get.find<HomeLogic>().getMainReueqst();

      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),

                Visibility(
                  visible: list.isNotEmpty,
                  child: Column(
                    children: [
                      TitleExplore(theme: theme,
                          textTheme: textTheme,
                          icon: "assets/${F.assetTitle}/icons/sound_icons.svg",
                          title: 'home_7'.tr),
                      SizedBox(height: 1.5.h),
                      Obx(() {
                        return SizedBox(
                          height: 30.h,
                          child: ListView.builder(
                              itemCount: list.reversed.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return  BestItemExploreWidget(
                                    list.reversed
                                        .toList().elementAt(index));
                              }),
                        );
                      }),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
                Visibility(
                  visible: list.isNotEmpty,

                  child: Column(
                    children: [
                      TitleExplore(theme: theme,
                          textTheme: textTheme,
                          icon: "assets/${F.assetTitle}/icons/sound_icons.svg",
                          title: 'home_8'.tr),


                      SizedBox(height: 1.5.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              String itemId = list[index]['id'];
                              print(itemId);
                              Get.toNamed(PageRoutes.DETAILVIDEO, arguments: {'id': itemId});
                            },
                            child: ItemVideoTabScreen(
                              list[index],
                            ),
                          );


                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
