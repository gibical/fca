import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/view_all/videos/best_video_screen.dart';
import 'package:mediaverse/app/pages/home/widgets/bset_item_explore_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_route.dart';
import '../../../detail/logic.dart';
import '../../../view_all/videos/view_all_grid.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';

class AllTabScreen extends StatelessWidget {
  HomeLogic logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: theme.background,
      body: RefreshIndicator(
        onRefresh: ()async{

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
                    viewAllTap: (){
                      Get.toNamed(PageRoutes.ViewAllChannel);
                    },
                    theme: theme, textTheme: textTheme, icon: AppIcon.videoIcon, title: 'home_1'.tr),
                SizedBox(height: 1.5.h),
                SizedBox(
                  height: 21.h,

                  child: ListView.builder(
                      itemCount: logic.channels.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              print('AllTabScreen.build');
                              final channelId = logic.channels[index].id;
                             Get.toNamed(PageRoutes.LIVE , arguments: {'channelId': channelId},preventDuplicates: false);


                            },
                            child: BestChannelsWidget(model: logic.channels.elementAt(index)
                            )
                        );
                      }),
                ),
                SizedBox(height: 1.5.h),

                Visibility(
                  visible: logic.bestVideos.isNotEmpty,
                  child: Column(
                    children: [
                      TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.videoIcon, title: 'home_2'.tr,                    isViewAll: true,

                        viewAllTap: (){

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
                                return BestItemExploreWidget(logic.bestVideos.elementAt(index));
                              }),
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              if(logic.mostImages.length>3)   TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.imageIcon, title: 'home_3'.tr,
                isViewAll: true,viewAllTap: (){
                    Get.to(ViewAllGrdiScreen(),arguments: [3]);
                  },),
                SizedBox(height: 12.5),
               if(logic.mostImages.length>0) CustomGridImageWidget(logic.mostImages),
                SizedBox(height: 3.h),
                Visibility(
                  visible: logic.mostText.isNotEmpty,
                  child: Column(
                    children: [
                      TitleExplore(theme: theme, textTheme: textTheme,
                          icon: "assets/${F.assetTitle}/icons/text_icon.svg", title: 'home_4'.tr , isViewAll: true,viewAllTap: (){
                          Get.to(ViewAllGrdiScreen(),arguments: [5]);
                        },),
                      SizedBox(height: 1.5.h),
                      SizedBox(
                        height: 40.w,
                        child: ListView.builder(
                            itemCount: logic.mostText.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return  GestureDetector(
                                  onTap: (){
                                    String itemId = logic.mostText[index]['id'];
                                    Get.toNamed(PageRoutes.DETAILTEXT, arguments: {'id': itemId});
                                  },
                                  child: BestTextWidget(model: logic.mostText.elementAt(index)));
                            }),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
                TitleExplore(theme: theme, textTheme: textTheme, icon: "assets/${F.assetTitle}/icons/sound_icon.svg", title: 'home_5'.tr , isViewAll: true,viewAllTap: (){
                  Get.to(ViewAllGrdiScreen(),arguments: [4]);
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
                            onTap: (){
                              String itemId = logic.mostSongs[index]['id'];
                              Get.toNamed(PageRoutes.DETAILMUSIC, arguments: {'id': itemId});
                            },
                            child: BestItemSongsWidget(logic.mostSongs.elementAt(index)));
                      }),
                ),
                SizedBox(height: 13.5.h),
              ],
            ),
          ),
        ),
      ),
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
                .textTheme.bodySmall?.copyWith(
                fontSize: 13.5.sp
            ),
          ),
          Spacer(),
          isViewAll ?? false ?  GestureDetector(
            onTap: viewAllTap,
            child: Text(
              'home_6'.tr,
              style: Theme
                  .of(context)
                  .textTheme.bodySmall?.copyWith(
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
