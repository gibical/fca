import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/widgets/bset_item_explore_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.videoIcon, title: 'Live Channels'),
              SizedBox(height: 1.5.h),
              SizedBox(
                height: 40.w,
                child: ListView.builder(
                    itemCount: logic.channels.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return BestChannelsWidget(model: logic.channels.elementAt(index));
                    }),
              ),
              SizedBox(height: 1.5.h),

              TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.videoIcon, title: 'Best videos'),
              SizedBox(height: 1.5.h),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                    itemCount: logic.bestVideos.length,
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return BestItemExploreWidget(logic.bestVideos.elementAt(index));
                    }),
              ),
              SizedBox(height: 3.h),
              TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.imageIcon, title: 'Most viewed'),
              SizedBox(height: 12.5),
             if(logic.mostImages.length>0) CustomGridImageWidget(logic.mostImages),
              SizedBox(height: 3.h),
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
              SizedBox(height: 6.h),
              TitleExplore(theme: theme, textTheme: textTheme, icon: "assets/icons/sound_icon.svg", title: 'Top Song'),
              SizedBox(height: 1.5.h),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                    itemCount: logic.mostSongs.length,
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return BestItemSongsWidget(logic.mostSongs.elementAt(index));
                    }),
              ),
              SizedBox(height: 13.5.h),
            ],
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
  });

  final ColorScheme theme;
  final TextTheme textTheme;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 2.h, color: theme.onBackground),
          SizedBox(width: 1.5.w),
          Text(
            title,
            style: textTheme.headlineMedium?.copyWith(
                color: theme.onBackground, fontSize: 19),
          ),
        ],
      ),
    );
  }
}
