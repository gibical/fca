import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/pages/channel/control_room/view.dart';
import 'package:mediaverse/app/pages/channel/view.dart';
import 'package:mediaverse/app/pages/channel/widgets/all_tools_button.dart';
import 'package:mediaverse/app/pages/media_suit/view.dart';
import 'package:sizer/sizer.dart';

import '../../common/app_color.dart';
import '../stream/view.dart';

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
              AllToolsButtonWidget(onPressed: (){//

                Get.to(ChannelScreen());
                  }, icon: "assets/${F.assetTitle}/icons/all_tools_1.svg", name: "channel_30".tr),
              // AllToolsButtonWidget(onPressed: (){
              //   Get.to(ControlRoomPage());
              //
              // }, icon: "assets/${F.assetTitle}/icons/all_tools_2.svg", name: "Control Room"),
              AllToolsButtonWidget(onPressed: (){
               Get.toNamed(PageRoutes.MEDIASUIT);
                //Get.to(()=>CameraExampleHome());

              }, icon: "assets/${F.assetTitle}/icons/all_tools_3.svg", name: "channel_31".tr),
              // AllToolsButtonWidget(onPressed: (){},
              // icon: "assets/${F.assetTitle}/icons/all_tools_4.svg", name: "channel_32".tr,enable: false,),
              // AllToolsButtonWidget(onPressed: (){},
              // icon: "assets/${F.assetTitle}/icons/all_tools_5.svg", name: "channel_33".tr,enable: false,),
              // AllToolsButtonWidget(onPressed: (){},
              // icon: "assets/${F.assetTitle}/icons/all_tools_6.svg", name: "channel_34".tr,enable: false,),

            ],
          ),
        ),
      ),
    );
  }
}
