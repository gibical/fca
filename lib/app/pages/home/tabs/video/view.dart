import 'package:flutter/material.dart';
import 'package:mediaverse/app/pages/home/widgets/card_live_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_grid_video_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../widgets/custom_grid_view_widget.dart';


class VideoTabScreen extends StatelessWidget {
  const VideoTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColor.grayLightColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 4.h)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                      itemBuilder: (context , index){
                        return CardLiveWidget();
                      }),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 3.h)),
              const SliverToBoxAdapter(
                child: Text(
                  'Latest',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.5,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 1.5.h)),
              const CustomGridViewWidget(),
              SliverPadding(padding: EdgeInsets.only(top: 7.h)),
              const SliverToBoxAdapter(
                child: Text(
                  'Most view',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.5,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 12.5)),
              SliverToBoxAdapter(
                child: CustomGridVideoWidget(),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 9.h)),
            ],
          ),
        )
    );
  }
}
