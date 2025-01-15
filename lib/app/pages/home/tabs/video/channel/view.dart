import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_color.dart';
import '../../../widgets/mini_channel_widget.dart';
import '../../../widgets/sort_select_bottom_sheet.dart';

class ChannelTabScreen extends StatefulWidget {
  const ChannelTabScreen({super.key});

  @override
  State<ChannelTabScreen> createState() => _ChannelTabScreenState();
}

class _ChannelTabScreenState extends State<ChannelTabScreen> {
  int sortType = 0;


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
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("home_15_4".tr,style: TextStyle(fontWeight: FontWeight.bold),),
                  InkWell(
                      borderRadius: BorderRadius.circular(500),
                      onTap: (){


                        _openSort();
                      },
                      child: SvgPicture.asset("assets/all/icons/arrow-sort.svg"))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 16
              ),
              height: 60.h,
              child: LayoutGrid(
                areas: '''
                      image1
                      image2
                      image3
                      image4
                      image5
                      image6
                      image7
                     
                               ''',
                columnSizes: [
                  1.fr
                ],//
                rowSizes: [
                  1.fr,
                  1.fr,
                  1.fr,
                  1.fr,
                  1.fr,
                  1.fr,
                  1.fr,

                ],
                columnGap: 6.w,
                rowGap: 10,
                children: [
                  MiniChannelWidget(height: 100.w,).inGridArea('image1'),
                  MiniChannelWidget(height: 100.w,).inGridArea('image2'),
                  MiniChannelWidget(height: 100.w,).inGridArea('image3'),
                  MiniChannelWidget(height: 100.w,).inGridArea('image4'),
                  MiniChannelWidget(height: 100.w,).inGridArea('image5'),
                  MiniChannelWidget(height: 100.w,).inGridArea('image6'),
                  MiniChannelWidget(height: 100.w,).inGridArea('image7'),

                ],
              ),
            ),

          ],
        ),
      )),
    );
  }

  void _openSort()async {
    int? s =  await Get.bottomSheet(SortSelectBottomSheet(sortType));
    if(s!=null){
      sortType = s;
    }
  }
}
