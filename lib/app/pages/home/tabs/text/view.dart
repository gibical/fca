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
import '../../../../common/app_route.dart';
import '../../../detail/logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';

class TextTabScreen extends StatelessWidget {
  Function onClick;

  Function onSendRequest;
  RxList<dynamic> list = <dynamic>[].obs;

  TextTabScreen(
      {required this.onClick, required this.onSendRequest, required this.list});

  @override
  Widget build(BuildContext context) {
    print('TextTabScreen.build =  ${list.length}');
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return FocusDetector(
      onFocusGained: () {
        if (list.length == 0) {
          onSendRequest.call();
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          Get.find<HomeLogic>().getMainReueqst();
          onSendRequest.call();
        },
        child: Scaffold(
            backgroundColor: theme.background,
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Visibility(
                visible: list.isNotEmpty,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: 13.h),
                          TitleExplore(
                              theme: theme,
                              textTheme: textTheme,
                              icon: "assets/${F.assetTitle}/icons/text_icon.svg",
                              title: 'home_9'.tr),
                          SizedBox(height: 1.5.h),
                          SizedBox(
                            height: 40.w,
                            child: Obx(() {
                              return ListView.builder(
                                  itemCount: list.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return BestTextWidget(
                                        model: list.elementAt(index));
                                  });
                            }),
                          ),
                          SizedBox(height: 3.5.h),
                          TitleExplore(
                              theme: theme,
                              textTheme: textTheme,
                              icon: "assets/${F.assetTitle}/icons/sound_icons.svg",
                              title: 'home_8'.tr),
                        ],
                      ),
                    ),
                    Obx(() {
                      var isloadingText = list.length == 0;
                      if (isloadingText) {
                        return SliverToBoxAdapter(
                          child: Container(
                            child: Lottie.asset("assets/json/Y8IBRQ38bK.json",
                                height: 10.h),
                          ),
                        );
                      }
                      return    SliverGrid.builder(
                          itemCount: list.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemBuilder: (s, q){
                            var item = list.elementAt(q);
                            return AspectRatio(
                              aspectRatio: 1 / 1,
                              child: BestTextWidget(model: item),
                            );
                          });
                    }),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 13.h,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

