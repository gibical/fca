import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/view_all/channel/logic.dart';
import 'package:mediaverse/app/pages/view_all/widgets/loading_more_widhey.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../home/widgets/item_video_tab_screen.dart';

class BestVideoScreenPage extends StatefulWidget {
  const BestVideoScreenPage({super.key});

  @override
  State<BestVideoScreenPage> createState() => _BestVideoScreenPageState();
}

class _BestVideoScreenPageState extends State<BestVideoScreenPage> {
  String tag = "video_${DateTime
      .now()
      .millisecondsSinceEpoch}";
  ViewAllChannelController logic = Get.put(
      ViewAllChannelController(2), tag: "video_${DateTime
      .now()
      .millisecondsSinceEpoch}");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewAllChannelController>(

        init:logic ,
        tag: tag,
        builder: (logic) {
      return Scaffold(
        backgroundColor: AppColor.blueDarkColor,

        body: Center(
          child: SafeArea(
            child: Container(

              child: Stack(
                children: [
                  SizedBox.expand(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: SingleChildScrollView(
                        child: Column(

                          children: [


                            Container(
                              //  padding: EdgeInsets.symmetric(horizontal: 7.5.w),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  IconButton(onPressed: () {
                                    Get.back();
                                  },
                                      icon: Icon(Icons.arrow_back, color: "666680"
                                          .toColor(),)),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        AppIcon.videoIcon, color: Colors.white,),
                                      SizedBox(width: 3.w,),
                                      Text("viewall_4".tr,
                                        style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                  Container(
                                    width: 16.w,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 4.h),

                                           ...logic.videos.asMap().entries.map((e) {
                         var index = e.key;
                         return GestureDetector(
                           onTap: () {
                             String itemId = logic.videos.elementAt(index)['id'];
                             print(itemId);
                             Get.toNamed(PageRoutes.DETAILVIDEO, arguments: {'id': itemId});
                           },
                           child: ItemVideoTabScreen(
                             logic.videos.elementAt(index),
                           ),
                         );
                                           }).toList(),
                            Visibility(
                                visible: logic.isNextPageAvailabe,
                                child: LoadigMorewidget(keys: "vestViews", function: (){
                                  logic.page = logic.page+1;
                                  logic.update();
                                }))

                          ],
                        ),
                      ),
                    ),
                  ),

                  Obx(() {
                    return Visibility(
                      //visible: false,
                      visible: logic.isloading.value,
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Lottie.asset(
                              "assets/json/Y8IBRQ38bK.json", height: 18.h),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
