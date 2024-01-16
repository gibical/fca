import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/home/widgets/bset_item_explore_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';


class AllTabScreen extends StatelessWidget {
  const AllTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return  Scaffold(
      backgroundColor: theme.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          slivers: [
            SliverPadding(padding: EdgeInsets.only(top: 7.h)),
            SliverPadding(padding: EdgeInsets.only(top: 6.h)),
             TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.videoIcon, title: 'Best videos'),
            SliverPadding(padding: EdgeInsets.only(top: 1.5.h)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index){
                  return BestItemExploreWidget();
                }),
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(top: 7.h)),
            TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.imageIcon, title: 'Most viewed'),
            const SliverPadding(padding: EdgeInsets.only(top: 12.5)),
            CustomGridImageWidget(),
            SliverPadding(padding: EdgeInsets.only(top: 12.h)),
          ],
        ),
      ),
    );
  }
}

class TitleExplore extends StatelessWidget {
  const TitleExplore({
    super.key,
    required this.theme,
    required this.textTheme, required this.icon, required this.title,
  });

  final ColorScheme theme;
  final TextTheme textTheme;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
     child: Padding(
       padding:  EdgeInsets.symmetric(horizontal: 5),
       child: Row(
         children: [
           SvgPicture.asset(icon , height: 2.h , color: theme.onBackground,),
           SizedBox(width: 1.5.w,),
           Text(
             title,
             style: textTheme.headlineMedium?.copyWith(
               color: theme.onBackground,
               fontSize: 19
             )
           ),
         ],
       ),
     ),
                );
  }
}
