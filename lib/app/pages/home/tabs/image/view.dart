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
import '../../widgets/mini_video_widget.dart';
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
        tag: "image",
        builder: (logic) {
      return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(child: SingleChildScrollView(
          child:logic.isloadingPage.value
              ? Column(
            children: [

              Container(
                height: 35.h,
                child: Row(
                  children: [

                    Expanded(
                      child: Container(
                        width: 100.w,
                        child: Column(
                          children: [
                            Container(
                                height: 17.h,
                                child: ShimmirMiniImageWidget()),
                            SizedBox(height: 1.h,),
                            Container(
                                height: 17.h,
                                child: ShimmirMiniImageWidget()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(

                        width: 100.w,
                        height: 35.h,

                        child: ShimmirMiniImageWidget(),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Container(
                width: 100.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 1.h,),

              Container(
                height: 35.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(

                        width: 100.w,
                        height: 35.h,

                        child: ShimmirMiniImageWidget(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 100.w,
                        child: Column(
                          children: [
                            Container(
                                height: 17.h,
                                child: ShimmirMiniImageWidget()),
                            SizedBox(height: 1.h,),
                            Container(
                                height: 17.h,
                                child: ShimmirMiniImageWidget()),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Container(
                width: 100.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: Container(
                              height: 17.h,
                              child: ShimmirMiniImageWidget()),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          )
              :  Column(
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
                  children: logic.models.getRange(0, 3).toList().asMap().entries.map((toElement){
                    List<ContentModel> models=  logic.models.getRange(0, 3).toList();

                    return MiniImageWidget(model:  models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.h,),
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
                  children: logic.models.getRange(3, 7).toList().asMap().entries.map((toElement){
                    List<ContentModel> models=  logic.models.getRange(3, 10).toList();

                    return MiniImageWidget(model:  models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.h,),

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
                  children: logic.models.getRange(7, 10).toList().asMap().entries.map((toElement){
                    List<ContentModel> models=  logic.models.getRange(7, 10).toList();
                    return MiniImageWidget(model:  models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
                  }).toList(),
                ),
              ),
              SizedBox(height: 2.h,),



            ],
          ),
        )),
      );
    });
  }


}
