import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/home/home_tab_logic.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/app/pages/home/models/sort_type.dart';
import 'package:mediaverse/app/pages/home/tabs/image/most_image_widget.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_route.dart';
import '../../../../common/font_style.dart';
import '../../../detail/logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_image_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../../widgets/mini_image_widget.dart';
import '../../widgets/sort_select_bottom_sheet.dart';
import '../all/view.dart';


class ImageTabScreen extends StatelessWidget {

  HomeTabController logic = Get
      .find<HomeLogic>()
      .imageController;


  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    return GetBuilder<HomeTabController>(
        init: logic,
        builder: (logic) {
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
                    Text("home_15".tr, style: TextStyle(
                        fontWeight: FontWeight.bold),),
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
                padding: EdgeInsets.symmetric(
                    horizontal: 16
                ),
                height: 32.h,
                child: LayoutGrid(
                  areas: '''
                    image1 image3
                    image2 image3
                             ''',
                  columnSizes: [
                    1.fr, 2.fr
                  ],
                  //
                  rowSizes: [
                    1.fr,
                    1.fr,
                  ],
                  columnGap: 10,
                  rowGap: 10,
                  children: [
                    MiniImageWidget(model: ContentModel(),).inGridArea('image1'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image2'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image3'),


                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16
                ),
                height: 40.h,
                child: LayoutGrid(
                  areas: '''
                      image1 image2
                      image3 image4
                               ''',
                  columnSizes: [
                    1.fr, 1.fr
                  ],
                  //
                  rowSizes: [
                    1.fr,
                    1.fr,
                  ],
                  columnGap: 10,
                  rowGap: 10,
                  children: [
                    MiniImageWidget(model: ContentModel(),).inGridArea('image1'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image2'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image3'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image4'),


                  ],
                ),
              ),
              SizedBox(height: 2.h,),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16
                ),
                height: 32.h,
                child: LayoutGrid(
                  areas: '''
                    image1 image2
                    image1 image3
                             ''',
                  columnSizes: [
                    2.fr, 1.fr
                  ],
                  //
                  rowSizes: [
                    1.fr,
                    1.fr,
                  ],
                  columnGap: 10,
                  rowGap: 10,
                  children: [
                    MiniImageWidget(model: ContentModel(),).inGridArea('image1'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image2'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image3'),


                  ],
                ),
              ),
              SizedBox(height: 2.h,),

              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16
                ),
                height: 20.h,
                child: LayoutGrid(
                  areas: '''
                      image1 image2
                               ''',
                  columnSizes: [
                    1.fr, 1.fr
                  ],
                  //
                  rowSizes: [
                    1.fr,
                  ],
                  columnGap: 10,
                  rowGap: 10,
                  children: [
                    MiniImageWidget(model: ContentModel(),).inGridArea('image1'),
                    MiniImageWidget(model: ContentModel(),).inGridArea('image2'),


                  ],
                ),
              ),


            ],
          ),
        )),
      );
    });
  }


}
