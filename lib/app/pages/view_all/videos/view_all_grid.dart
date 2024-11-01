import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/profile/tab/ownser_tab_screen.dart';
import 'package:mediaverse/app/pages/view_all/channel/logic.dart';
import 'package:mediaverse/app/pages/view_all/widgets/loading_more_widhey.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../home/widgets/item_video_tab_screen.dart';
import '../../profile/widgets/GridMainWidget.dart';

class ViewAllGrdiScreen extends StatefulWidget {
  const ViewAllGrdiScreen({super.key});

  @override
  State<ViewAllGrdiScreen> createState() => _ViewAllGrdiScreenState();
}

class _ViewAllGrdiScreenState extends State<ViewAllGrdiScreen> {
  String tag = "video_${DateTime
      .now()
      .millisecondsSinceEpoch}";
  ViewAllChannelController logic = Get.put(
      ViewAllChannelController(Get.arguments[0]), tag: "video_${DateTime
      .now()
      .millisecondsSinceEpoch}");

  int type = Get.arguments[0];

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

                                    Text("viewall_5".tr,
                                      style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                Container(
                                  width: 16.w,
                                )
                              ],
                            ),
                          ),

                                         Expanded(child: GridView(


                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                               crossAxisCount: 2),
                                           children: logic.images
                                               .asMap()
                                               .entries
                                               .map((e) {
                                             return GridPostView( logic.images.elementAt(e.key));
                                           }).toList(),

                                         )),
                          Visibility(
                              visible: false,
                             // visible: logic.isNextPageAvailabe,
                              child: LoadigMorewidget(keys: "vestViews", function: (){
                                logic.page = logic.page+1;
                                logic.update();
                              }))

                        ],
                      ),
                    ),
                  ),

                  Obx(() {
                    return Visibility(
                     // visible: false,
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
