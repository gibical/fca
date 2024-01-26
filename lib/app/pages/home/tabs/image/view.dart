import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/font_style.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';


class ImageTabScreen extends StatelessWidget {
  const ImageTabScreen({super.key});

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
            SliverPadding(padding: EdgeInsets.only(top: 4.h)),
            TitleExplore(theme: theme, textTheme: textTheme, icon: AppIcon.imageIcon, title: 'Best videos'),
            SliverPadding(padding: EdgeInsets.only(top: 1.5.h)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index){
                      return BestItemExploreWidget(AppIcon.imageIcon);
                    }),
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(top: 7.h)),
            SliverToBoxAdapter(
              child:      Text(
                  'Most view',
                  style: FontStyleApp.titleLarge.copyWith(
                      color: AppColor.whiteColor
                  )
              ),
            ),

            const SliverPadding(padding: EdgeInsets.only(top: 12.5)),
            CustomGridImageWidget(),
            SliverPadding(padding: EdgeInsets.only(top: 14.h)),
          ],
        ),
      ),
    );
  }
}
