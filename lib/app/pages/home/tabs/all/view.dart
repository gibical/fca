import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/home/home_tab_logic.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/models/tab_model.dart';
import 'package:mediaverse/app/pages/home/widgets/mini_live_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/title_widget_explore.dart';
import 'package:mediaverse/app/pages/view_all/videos/best_video_screen.dart';
import 'package:mediaverse/app/pages/home/widgets/bset_item_explore_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_route.dart';
import '../../../detail/logic.dart';
import '../../../view_all/videos/view_all_grid.dart';
import '../../../wrapper/logic.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../../widgets/mini_audio_widget.dart';
import '../../widgets/mini_image_widget.dart';
import '../../widgets/mini_text_widget.dart';
import '../../widgets/mini_video_widget.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class AllTabScreen extends StatelessWidget {
  HomeLogic logic = Get
      .find<WrapperController>()
      .homeLogic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;


    return Scaffold(

      backgroundColor: AppColor.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {


        },
        child: SingleChildScrollView(
          child: Column(

            children: [


              TitleWidgetExplore("home_8".tr, () {}),
              SizedBox(height: 1.h,),

              GetBuilder<HomeTabController>(
                  init: logic.channelController,
                  tag: "channel",

                  builder: (logic) {
                    print(
                        'AllTabScreen.build GetBuilder HomeTabController = ${logic
                            .isloadingMini}');
                    return Container(
                      width: 100.w,
                      height: 13.h,
                      decoration: BoxDecoration(

                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.isloadingMini.value ? 6 : logic
                              .channelsModel.length,
                          itemBuilder: (s, i) {
                            return Container(
                                width: 26.w,//
                                child: logic.isloadingMini.value
                                    ? ShimmerMiniLiveWidget()//
                                    :

                                Container(

                                  child: MiniLiveWidget(
                                     logic.channelsModel.elementAt(i),),
                                ));
                          }), //
                    );
                  }),

              SizedBox(height: 2.h,),
              TitleWidgetExplore("home_10".tr, () {
                logic.pageController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
              }),
              SizedBox(height: 1.h,),
              GetBuilder<HomeTabController>(
                  init: logic.videoController,
                  tag: "video",

                  builder: (logic) {

                    return Container(
                      width: 100.w,
                      height: 26.h,
                      decoration: BoxDecoration(

                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.isloadingMini.value ? 6 : logic
                              .models.length,
                          itemBuilder: (s, i) {
                            return Container(
                                width: 45.w,
                                child: logic.isloadingMini.value
                                    ? ShimmerMiniVideoWidget()
                                    :

                                MiniVideoWidget(
                                  model: logic.models.elementAt(i),));
                          }), //
                    );
                  }),
              SizedBox(height: 2.h,),

              TitleWidgetExplore("home_12".tr, () {
                logic.pageController.animateToPage(3, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);

              }),
              SizedBox(height: 1.h,),

              GetBuilder<HomeTabController>(
                  init: logic.imageController,
                  tag: "image",

                  builder: (logic) {
                    return Container(
                      width: 100.w,
                      height: 30.h,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(

                      ),
                      child: LayoutGrid(
                        areas: '''
                    image1 image3 
                    image2 image3
                             ''',
                        columnSizes: [1.fr, 2.fr],
                        //
                        rowSizes: [1.fr, 1.fr],
                        columnGap: 10,
                        rowGap: 10,
                        children:!logic.isloadingMini.value?logic.models.getRange(0, 3).toList().asMap().entries.map((toElement){

                          return MiniImageWidget( model: logic.models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
                        }).toList(): [
                          ShimmirMiniImageWidget().inGridArea('image1'),
                          ShimmirMiniImageWidget().inGridArea('image2'),
                          ShimmirMiniImageWidget().inGridArea('image3'),

                        ],
                      ), //
                    );
                  }),
              SizedBox(height: 2.h,),

              TitleWidgetExplore("home_13".tr, () {
                logic.pageController.animateToPage(4, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);

              }),
              SizedBox(height: 1.h,),

              GetBuilder<HomeTabController>(
                  init: logic.audioController,
                  tag: "audio",
                  builder: (logic) {
                    return Container(
                      width: 100.w,
                      height: 28.h,

                      decoration: BoxDecoration(
                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.isloadingMini.value ? 6 : logic
                              .models.length,
                          itemBuilder: (s, i) {
                            return Container(
                                width: 47.w,
                                child: logic.isloadingMini.value
                                    ? ShimmerMiniAudioWidget()
                                    :

                                MiniAudioWidget(
                                  model: logic.models.elementAt(i),));
                          }), //
                    );
                  }),
              SizedBox(height: 2.h,),

              TitleWidgetExplore("home_14".tr, () {
                logic.pageController.animateToPage(5, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);

              }),
              SizedBox(height: 1.h,),

              GetBuilder<HomeTabController>(
                  init: logic.textController,
                  tag: "text",
                  builder: (logic) {
                    return Container(
                      width: 100.w,
                      height: 28.h,
                      decoration: BoxDecoration(

                      ),
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.isloadingMini.value ? 6 : logic
                              .models.length,
                          itemBuilder: (s, i) {
                            return Container(
                                width: 46.w,
                                child: logic.isloadingMini.value
                                    ? ShimmerMiniTextWidget()
                                    :

                                Container(
                                  margin: EdgeInsets.only(
                                      right: 3.w
                                  ),
                                  child: MiniTextWidget(
                                    model: logic.models.elementAt(i),),
                                ));
                          }), //
                    );
                  }),

            ],
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: theme.background,
      body: RefreshIndicator(
        onRefresh: () async {
          logic.getMainReueqst();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                TitleExplore(
                    isViewAll: true,
                    viewAllTap: () {
                      Get.toNamed(PageRoutes.ViewAllChannel);
                    },
                    theme: theme,
                    textTheme: textTheme,
                    icon: AppIcon.videoIcon,
                    title: 'home_1'.tr),
                SizedBox(height: 1.5.h),
                SizedBox(
                  height: 21.h,

                  child: ListView.builder(
                      itemCount: logic.channels.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              print('AllTabScreen.build');
                              final channelId = logic.channels[index].id;
                              Get.toNamed(PageRoutes.LIVE,
                                  arguments: {'channelId': channelId},
                                  preventDuplicates: false);
                            },
                            child: BestChannelsWidget(model: logic.channels
                                .elementAt(index)
                            )
                        );
                      }),
                ),
                SizedBox(height: 1.5.h),

                Visibility(
                  visible: logic.bestVideos.isNotEmpty,
                  child: Column(
                    children: [
                      TitleExplore(
                        theme: theme,
                        textTheme: textTheme,
                        icon: AppIcon.videoIcon,
                        title: 'home_2'.tr,
                        isViewAll: true,

                        viewAllTap: () {
                          Get.to(BestVideoScreenPage());
                        },),
                      SizedBox(height: 1.5.h),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: SizedBox(
                          height: 30.h,
                          child: ListView.builder(
                              itemCount: logic.bestVideos.length,
                              scrollDirection: Axis.horizontal,
                              reverse: false,
                              itemBuilder: (context, index) {
                                return BestItemExploreWidget(
                                    logic.bestVideos.elementAt(index));
                              }),
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
                if(logic.mostImages.length > 3) TitleExplore(
                  theme: theme,
                  textTheme: textTheme,
                  icon: AppIcon.imageIcon,
                  title: 'home_3'.tr,
                  isViewAll: true,
                  viewAllTap: () {
                    Get.to(ViewAllGrdiScreen(), arguments: [3]);
                  },),
                SizedBox(height: 12.5),
                if(logic.mostImages.length > 0) CustomGridImageWidget(
                    logic.mostImages),
                SizedBox(height: 3.h),
                Visibility(
                  visible: logic.mostText.isNotEmpty,
                  child: Column(
                    children: [
                      TitleExplore(
                        theme: theme,
                        textTheme: textTheme,
                        icon: "assets/${F.assetTitle}/icons/text_icon.svg",
                        title: 'home_4'.tr,
                        isViewAll: true,
                        viewAllTap: () {
                          Get.to(ViewAllGrdiScreen(), arguments: [5]);
                        },),
                      SizedBox(height: 1.5.h),
                      SizedBox(
                        height: 40.w,
                        child: ListView.builder(
                            itemCount: logic.mostText.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    String itemId = logic.mostText[index]['id'];
                                    Get.toNamed(PageRoutes.DETAILTEXT,
                                        arguments: {'id': itemId});
                                  },
                                  child: BestTextWidget(
                                      model: logic.mostText.elementAt(index)));
                            }),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
                TitleExplore(
                  theme: theme,
                  textTheme: textTheme,
                  icon: "assets/${F.assetTitle}/icons/sound_icon.svg",
                  title: 'home_5'.tr,
                  isViewAll: true,
                  viewAllTap: () {
                    Get.to(ViewAllGrdiScreen(), arguments: [4]);
                  },),
                SizedBox(height: 1.5.h),
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                      itemCount: logic.mostSongs.length,
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              String itemId = logic.mostSongs[index]['id'];
                              Get.toNamed(PageRoutes.DETAILMUSIC,
                                  arguments: {'id': itemId});
                            },
                            child: BestItemSongsWidget(logic.mostSongs
                                .elementAt(index)));
                      }),
                ),
                SizedBox(height: 13.5.h),
              ],
            ),
          ),
        ),
      ), //
    );
  }
}

class TitleExplore extends StatelessWidget {
  const TitleExplore({
    super.key,
    required this.theme,
    required this.textTheme,
    required this.icon,
    required this.title,
    this.isViewAll, this.viewAllTap

  });

  final ColorScheme theme;
  final TextTheme textTheme;
  final String icon;
  final String title;
  final bool? isViewAll;
  final Function()? viewAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 2.h, color: theme.onBackground),
          SizedBox(width: 1.5.w),
          Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                fontSize: 13.5.sp
            ),
          ),
          Spacer(),
          isViewAll ?? false ? GestureDetector(
            onTap: viewAllTap,
            child: Text(
              'home_6'.tr,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                  fontSize: 11.sp,
                  color: AppColor.primaryLightColor
              ),
            ),
          ) : SizedBox(),
        ],
      ),
    );
  }
}
