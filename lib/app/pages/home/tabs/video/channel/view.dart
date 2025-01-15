import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import '../../../../../common/app_color.dart';
import '../../../home_tab_logic.dart';
import '../../../logic.dart';
import '../../../widgets/mini_audio_widget.dart';
import '../../../widgets/mini_channel_widget.dart';
import '../../../widgets/sort_select_bottom_sheet.dart';

class ChannelTabScreen extends StatefulWidget {
  const ChannelTabScreen({super.key});

  @override
  State<ChannelTabScreen> createState() => _ChannelTabScreenState();
}

class _ChannelTabScreenState extends State<ChannelTabScreen> {
  HomeTabController logic = Get
      .find<HomeLogic>()
      .channelController;


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
        tag: "channel",
        builder: (logic) {
          print('_ChannelTabScreenState.build = ${logic.channelsModel.length}');
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
                    Text("home_15_4".tr, style: TextStyle(
                        fontWeight: FontWeight.bold),),

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
                      image8
                      image9
                     
                               ''',
                  columnSizes: [
                    1.fr
                  ],
                  //
                  rowSizes: [
                    1.fr,
                    1.fr,
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
                  children: logic.channelsModel.getRange(0, 9).toList().asMap().entries.map((toElement){
                    List<ChannelsModel> models=  logic.channelsModel.getRange(0, 9).toList();

                    return MiniChannelWidget(model:  models.elementAt(toElement.key)).inGridArea("image${toElement.key+1}");
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
