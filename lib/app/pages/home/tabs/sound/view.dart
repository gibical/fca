import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_icon.dart';
import '../../../../common/app_route.dart';
import '../../../../common/font_style.dart';
import '../../../detail/logic.dart';
import '../../logic.dart';
import '../../widgets/bset_item_explore_widget.dart';
import '../../widgets/custom_grid_view_widget.dart';
import '../all/view.dart';



class SoundTabScreen extends StatelessWidget {
  Function onClick;

  Function onSendRequest;
  RxList<dynamic> list = <dynamic>[].obs;

  SoundTabScreen(
      {required this.onClick, required this.onSendRequest, required this.list});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return FocusDetector(
      onFocusGained: () {
        if (list.length == 0) {
          onSendRequest.call();
        }
      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15.h),

                TitleExplore(theme: theme,
                    textTheme: textTheme,
                    icon: "assets/icons/sound_icons.svg",
                    title: 'Best in month'),
                SizedBox(height: 1.5.h),
                SizedBox(
                  height: 30.h,
                  child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              Get.find<DetailController>().selectedItem.value = list.reversed
                                  .toList().elementAt(index);

                              Get.toNamed(PageRoutes.DETAILMUSIC);
                            },
                            child: BestItemSongsWidget(list.reversed.toList().elementAt(index)));
                      }),
                ),
                TitleExplore(theme: theme,
                    textTheme: textTheme,
                    icon: "assets/icons/sound_icons.svg",
                    title: 'Recently'),

                SizedBox(height: 4.h,),

                Obx(() {
                  var isloadingImage = list.length==0;
                  if(isloadingImage){
                    return Container(
                      child: Lottie.asset("assets/json/Y8IBRQ38bK.json",height: 10.h),
                    );
                  }
                  return Container(
                    height: 40.h,
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                    ), itemBuilder: (s,q){
                          var item = list.elementAt(q);
                          return AspectRatio(
                            aspectRatio: 1/1,
                            child: Container(

                              margin: EdgeInsets.all(2.w),
                              child: Stack(
                                children: [
                                  SizedBox.expand(
                                    child: Image.asset("assets/images/sound_bg.png"),
                                  ),
                                  SizedBox.expand(
                                    child:Container(
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(0.00, 1.00),
                                          end: Alignment(0, -1),
                                          colors: [Color(0xFF0B0B31), Color(0x000A0A32)],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(width: 1, color: Color(0x33CFCFFC)),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //if(item)

                                ],
                              ),
                            ),
                          );

                    }),
                  );
                }),
                SizedBox(height: 10.5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}