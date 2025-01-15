import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/home/home_tab_logic.dart';
import 'package:mediaverse/app/pages/home/widgets/card_live_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/custom_grid_image_widget.dart';
import 'package:mediaverse/app/pages/home/widgets/item_video_tab_screen.dart';
import 'package:mediaverse/app/pages/home/widgets/mini_video_widget.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../detail/logic.dart';
import '../../../detail/view.dart';
import '../../../wrapper/logic.dart';
import '../../logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../../widgets/mini_image_widget.dart';
import '../../widgets/sort_select_bottom_sheet.dart';
import '../all/view.dart';

class VideoTabScreen extends StatefulWidget {
  @override
  State<VideoTabScreen> createState() => _VideoTabScreenState();
}

class _VideoTabScreenState extends State<VideoTabScreen> {
  HomeLogic logic = Get.find<WrapperController>().homeLogic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GetBuilder<HomeTabController>(
        init: logic.videoController,
        tag: 'video',
        builder: (logic) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: SafeArea(
                child: SingleChildScrollView(
              child: logic.isloadingPage.value
                  ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    width: 100.w,
                    child: ShimmerMiniVideoWidget(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: 100.w,
                          child: ShimmerMiniVideoWidget(),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: 100.w,
                          child: ShimmerMiniVideoWidget(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: 100.w,
                          child: ShimmerMiniVideoWidget(),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: 100.w,
                          child: ShimmerMiniVideoWidget(),
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  :  Column(
                children:[
                        Container(
                          margin: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "home_15_2".tr,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                  borderRadius: BorderRadius.circular(500),
                                  onTap: () {
                                    logic.openSort();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/all/icons/arrow-sort.svg"))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 23.h,
                          child: LayoutGrid(
                            areas: '''
                    image1 image1
                    
                             ''',
                            columnSizes: [1.fr, 2.fr],
                            //
                            rowSizes: [
                              1.fr,
                            ],
                            columnGap: 10,
                            rowGap: 10,
                            children: logic.models.getRange(0, 1).toList().asMap().entries.map((toElement){
                              return MiniVideoWidget(model:  logic.models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 75.h,
                          child: LayoutGrid(
                            areas: '''
                      image1 image2
                      image3 image4
                               ''',
                            columnSizes: [1.fr, 1.fr],
                            //
                            rowSizes: [
                              1.fr,
                              1.fr,
                            ],
                            columnGap: 6.w,
                            rowGap: 10,
                            children:  logic.models.getRange(1, 4).toList().asMap().entries.map((toElement){
                              return MiniVideoWidget(model:  logic.models.elementAt(toElement.key+1)).inGridArea("image${toElement.key+1}");
                            }).toList(),
                          ),
                        ),
                      ],
              ),
            )),
          );
        });
  }
}
