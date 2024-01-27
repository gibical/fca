import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/font_style.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';


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
             SliverToBoxAdapter(
              child: Text(
                'Latest',
                style: FontStyleApp.titleLarge.copyWith(
              color: AppColor.whiteColor
              )
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(top: 1.5.h)),
            const CustomGridViewWidget(),
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
            if(false)CustomGridImageWidget([]),
            SliverPadding(padding: EdgeInsets.only(top: 12.h)),
          ],
        ),
      ),
    );
  }
}
