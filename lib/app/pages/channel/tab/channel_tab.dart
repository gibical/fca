import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibical/app/pages/share_account/widgets/program_show_bottom_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:gibical/app/pages/channel/widgets/add_channel_card_widget.dart';
import 'package:gibical/app/pages/channel/widgets/card_channel_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../share_account/logic.dart';

class ProgramsTab extends StatelessWidget {
  final _logic = Get.find<ShareAccountLogic>();

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (_logic.isloading.value) {
        return Scaffold(
          backgroundColor: AppColor.blueDarkColor,

          body: Container(

            child: Center(
              child: Lottie.asset(
                  "assets/json/Y8IBRQ38bK.json", height: 10.h),
            ),
          ),
        );
      } else {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AddChannelCardWidget(),

          ),
          SliverList.builder(
              itemCount: _logic.list.length,
              itemBuilder: (context, index) {
                var model = _logic.list.elementAt(index);
                return CardChannelWidget(
                    title: (model.name??"").toString(), date: (model.createdAt??""),onTap: (){

                      Get.bottomSheet(ProgramShowBottomSheet(model));
                });
              })
        ],
      );
    }});
  }
}
