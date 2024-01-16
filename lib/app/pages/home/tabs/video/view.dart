import 'package:flutter/material.dart';
import 'package:mediaverse/app/pages/home/widgets/card_live_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_grid_image_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/item_video_tab_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../widgets/custom_grid_view_widget.dart';


class VideoTabScreen extends StatelessWidget {
  const VideoTabScreen({super.key});

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
              SliverPadding(padding: EdgeInsets.only(top: 11.h)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                      itemBuilder: (context , index){
                        return CardLiveWidget('https://cstipstech.com/wp-content/uploads/2023/04/Best-movies-on-netflix-right-now.jpeg');
                      }),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 2.h , )),
               SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0 , right: 8),
                  child: Text(
                    'Recently',
                    style: textTheme.headlineMedium!.copyWith(
                      color: theme.onBackground
                    ),
                  ),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 1.5.h)),
              SliverList.builder(itemBuilder: (context , index){
                return ItemVideoTabScreen();
              },
              itemCount: 5,
              ),
              SliverPadding(padding: EdgeInsets.only(top: 7.h)),
              const SliverPadding(padding: EdgeInsets.only(top: 18.5)),
              SliverPadding(padding: EdgeInsets.only(top: 3.h)),
            ],
          ),
        )
    );
  }
}
