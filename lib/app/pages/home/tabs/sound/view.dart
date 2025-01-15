import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/app_route.dart';
import '../../../../common/font_style.dart';
import '../../../detail/logic.dart';
import '../../home_tab_logic.dart';
import '../../logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../../widgets/mini_audio_widget.dart';
import '../../widgets/sort_select_bottom_sheet.dart';
import '../all/view.dart';


class SoundTabScreen extends StatefulWidget {


  @override
  State<SoundTabScreen> createState() => _SoundTabScreenState();
}

class _SoundTabScreenState extends State<SoundTabScreen> {

  HomeTabController logic = Get
      .find<HomeLogic>()
      .audioController;


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
        tag: "audio",
        builder: (logic) {
      return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(child: SingleChildScrollView(
          child:logic.isloadingPage.value
              ? Container(
            padding: EdgeInsets.all(16),
                child: Column(
                            children: [
                
                SizedBox(height: 1.h,),
                Container(
                  width: 100.w,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                          SizedBox(width: 2.w,),
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                          SizedBox(width: 2.w,),
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                        ],
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
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                          SizedBox(width: 2.w,),
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                          SizedBox(width: 2.w,),
                          Expanded(
                            child: Container(
                                height: 20.h,
                                child: ShimmerMiniAudioWidget()),
                          ),
                        ],
                      ),
                
                    ],
                  ),
                ),
                            ],
                          ),
              )
              :  Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("home_15_1".tr, style: TextStyle(
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
                height: 110.h,
                child: LayoutGrid(
                  areas: '''
                      image1 image2
                      image3 image4
                      image5 image6
                      image7 image8
                      image9 image10
                               ''',
                  columnSizes: [
                    1.fr, 1.fr
                  ],
                  //
                  rowSizes: [
                    1.fr,
                    1.fr,
                    1.fr,
                    1.fr,
                    1.fr,

                  ],
                  columnGap: 6.w,
                  rowGap: 10,
                  children: logic.models.getRange(0, 10).toList().asMap().entries.map((toElement){
                    List<ContentModel> models=  logic.models.getRange(0, 10).toList();

                    return MiniAudioWidget(model:  models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
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