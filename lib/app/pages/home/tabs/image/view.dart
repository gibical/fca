import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/tabs/image/most_image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_route.dart';
import '../../../../common/font_style.dart';
import '../../../detail/logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';


class ImageTabScreen extends StatelessWidget {

  Function onClick;

  Function onSendRequest;
  RxList<dynamic> list = <dynamic>[].obs;

  ImageTabScreen(
      {required this.onClick, required this.onSendRequest, required this.list});


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
        if (list.length == 0) {
          onSendRequest.call();
        }
      },
      child: RefreshIndicator(
        onRefresh: ()async{

          Get.find<HomeLogic>().getMainReueqst();
          onSendRequest.call();

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
                      icon: "assets/${F.assetTitle}/icons/sound_icons.svg",
                      title: 'home_7'.tr),
                  SizedBox(height: 1.5.h),
                  SizedBox(
                    height: 30.h,
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return  GestureDetector(
                              onTap: (){
                                String itemId = list[index]['id'];
                                Get.toNamed(PageRoutes.DETAILIMAGE, arguments: {'id': itemId});
                              },
                              child: MostImageWidget(
                                  list.elementAt(index)),
                            );
                          });
                    }),
                  ),
                  TitleExplore(theme: theme,
                      textTheme: textTheme,
                      icon: "assets/${F.assetTitle}/icons/sound_icons.svg",
                      title: 'home_8'.tr),

                  SizedBox(height: 4.h,),

                  Obx(() {
                    var isloadingImage = list.length == 0;
                    if (isloadingImage) {
                      return Container(
                        child: Lottie.asset(
                            "assets/${F.assetTitle}/json/Y8IBRQ38bK.json", height: 10.h),
                      );
                    }
                    return Column(
                      children: [
                        Container(child: CustomGridImageWidget(list.value)),
                        // Container(child: CustomGridImageWidget(list.value,
                        //   isReversed: true,)),
                        // Container(child: CustomGridImageWidget(list,
                        //   isReversed: false,)),
                        SizedBox(height: 15.5.h),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
