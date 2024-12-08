import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/share_account/widgets/program_show_bottom_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/pages/channel/widgets/add_channel_card_widget.dart';
import 'package:mediaverse/app/pages/channel/widgets/card_channel_widget.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannels.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/walletV2/FromJsonGetPrograms.dart';
import '../../../common/app_color.dart';
import '../../share_account/logic.dart';

class ProgramsTab extends StatefulWidget {
  @override
  State<ProgramsTab> createState() => _ProgramsTabState();
}

class _ProgramsTabState extends State<ProgramsTab> {
  final _logic = Get.find<ShareAccountLogic>();

    List<ChannelsModel> list = [];
    bool isBack  =false;


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((callback){

    });
  }
  @override
  Widget build(BuildContext context) {


    return Obx(() {
      if (_logic.isloading.value) {
        return Scaffold(
          backgroundColor: AppColor.blueDarkColor,

          body: Container(

            child: Center(
              child: Lottie.asset(
                  "assets/${F.assetTitle}/json/Y8IBRQ38bK.json", height: 10.h),
            ),
          ),
        );
      } else {
        try {
          print('_ProgramsTabState.initState = ${(Get.arguments[0]==true)}');
          if(Get.arguments[0]==true){

            list = _logic.channelModels;//
            isBack = true;
            print('ProgramsTab.build = ${list.length}');
          }

        }  catch (e) {
          // TODO
        }finally{

        }
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AddChannelCardWidget(),//

          ),
          SliverList.builder(
              itemCount:(isBack?list: _logic.channelModels).length,
              itemBuilder: (context, index) {
                var model = (isBack?list:_logic.channelModels).elementAt(index);
                return CardChannelWidget(
                    title: (model.name??"").toString(), date: (model.createdAt??""),onTap: (){
                  print('_ProgramsTabState.build');
                        try {
                        if(isBack){
                          Get.back(result: model);
                        }else{
                          Get.bottomSheet(ProgramShowBottomSheet(model));

                        }
                      }  catch (e) {
                        // TODO
                        print('_ProgramsTabState.build');
                          Get.bottomSheet(ProgramShowBottomSheet(model));
                      }

                }, model: model);
              })
        ],
      );
    }});
  }
}
