import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/channel/control_room/view.dart';
import 'package:mediaverse/app/pages/channel/view.dart';
import 'package:mediaverse/app/pages/channel/widgets/all_tools_button.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';

class AllToolsScreen extends StatefulWidget {
  const AllToolsScreen({super.key});

  @override
  State<AllToolsScreen> createState() => _AllToolsScreenState();
}

class _AllToolsScreenState extends State<AllToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blueDarkColor,

      body:   Center(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [



              SizedBox(height: 5.h,),
              AllToolsButtonWidget(onPressed: (){

                Get.to(ChannelScreen());
                  }, icon: "assets/icons/all_tools_1.svg", name: "Channel Management"),
              AllToolsButtonWidget(onPressed: (){
                Get.to(ControlRoomPage());

              }, icon: "assets/icons/all_tools_2.svg", name: "Control Room"),
              AllToolsButtonWidget(onPressed: (){}, icon: "assets/icons/all_tools_3.svg", name: "Media Suit"),
              AllToolsButtonWidget(onPressed: (){}, icon: "assets/icons/all_tools_4.svg", name: "Studio",enable: false,),
              AllToolsButtonWidget(onPressed: (){}, icon: "assets/icons/all_tools_5.svg", name: "CG & Playout",enable: false,),
              AllToolsButtonWidget(onPressed: (){}, icon: "assets/icons/all_tools_6.svg", name: "AI & Production",enable: false,),

            ],
          ),
        ),
      ),
    );
  }
}