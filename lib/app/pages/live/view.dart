import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/common/utils/data_state.dart';
import 'package:mediaverse/app/common/widgets/appbar_btn.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/detail/widgets/details_bottom_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/player/player.dart';
import 'package:mediaverse/app/pages/live/widgets/player_live_widget.dart';
import 'package:mediaverse/app/pages/live/widgets/show_time_record_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:video_player/video_player.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../detail/logic.dart';
import '../home/logic.dart';
import 'logic.dart';
import 'old.dart';

class LiveScreen extends StatelessWidget {
  LiveScreen({super.key});

  HomeLogic logic = Get.find<HomeLogic>();

  LiveController liveController = Get.put(
      LiveController(), tag: "time_${DateTime
      .now()
      .millisecond}");
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.arguments['idAssetMedia'] == "idAssetMedia") {
          Get.offAllNamed(PageRoutes.WRAPPER);
        } else {
          Get.back();
        }

        return false;
      },
      child: Scaffold(
          backgroundColor: AppColor.secondaryDark,
          body: SafeArea(
            child: Obx(() {
              if (liveController.isLoadingLive.value ||
                  liveController.liveDetails!.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 10.h,
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppbarBTNWidget(
                                  iconName: 'back1',
                                  onTap: () {
                                    if (Get.arguments['idAssetMedia'] == "idAssetMedia") {
                                      Get.offAllNamed(PageRoutes.WRAPPER);
                                    } else {
                                      Get.back();
                                    }
                                  }),
                              Text(
                                'Channel',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Opacity(
                                opacity: 0,
                                  child: AppbarBTNWidget(iconName: 'menu', onTap: () {})),


                            ],
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.secondaryDark,
                    ),

                    //--
                    SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height / 2 - 100),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                              backgroundColor:
                              AppColor.primaryColor.withOpacity(0.2),
                            ),
                          ),
                        )),
                    //--
                  ],
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      toolbarHeight: 10.h,
                      surfaceTintColor: Colors.transparent,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppbarBTNWidget(
                                  iconName: 'back1',
                                  onTap: () {
                                    Get.back();
                                  }),
                              Text(
                                'Channel',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),

                              Opacity(
                                  opacity: 0,
                                  child: AppbarBTNWidget(iconName: 'menu', onTap: () {})),


                            ],
                          ),
                        ),
                      ),
                      backgroundColor: AppColor.secondaryDark,
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 2.h),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: CachedNetworkImage(
                                  imageUrl: liveController
                                      .liveDetails?['user']['image_url'] ??
                                      '',
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/mediaverse/icons/userprofile.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: AppColor.primaryLightColor,
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return Container(
                                      color: AppColor.primaryLightColor,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/mediaverse/icons/userprofile.svg',
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${liveController.liveDetails?['user']['username']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '${liveController.liveDetails?['user']['full_name']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(

                              padding: EdgeInsets.symmetric(horizontal: 15 ,  vertical: 5),
                              decoration: BoxDecoration(
                                color: 'B71D18'.toColor(),
                                borderRadius: BorderRadius.circular(5.sp)
                              ),
                              child: Text(
                                'Live',
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    // //--
                    //
                    // SliverToBoxAdapter(
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 22.0 ,  ),
                    //     child: Row(
                    //       children: [
                    //         Text('Current program: ' , style: TextStyle(
                    //           color: '#9C9CB8'.toColor()
                    //         ),),
                    //         Text('Name of program'),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SliverToBoxAdapter(
                    //   child: SizedBox(
                    //     child: SizedBox(
                    //       height: 2.h,
                    //     ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(14.sp)),
                          child: PlayerLiveWidget(),
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return GestureDetector(
                                onTap:liveController.remainingTime.value == 0? () {
                                  liveController.toggleExpand();
                                }:null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 45,
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                        color: 'B71D18'.toColor(),
                                      ),
                                      child: Row(
                                        children: [
                                          liveController.remainingTime.value != 0
                                              ? Icon(
                                            Icons.circle,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                              : liveController.isLoadingRecord.value
                                              ? SizedBox(
                                            width: 14,
                                            height: 14,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              backgroundColor: Colors.white.withOpacity(0.3),
                                              strokeWidth: 1.2,
                                            ),
                                          )
                                              : SvgPicture.asset('assets/mediaverse/images/record1.svg'),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(liveController.remainingTime.value == 0
                                              ? "Record"
                                              : '${liveController.formatTime(liveController.remainingTime.value)}')
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height: liveController.isExpanded.value
                                          ? liveController.titlesRecordText.length * 50.0
                                          : 0,
                                      curve: Curves.easeInOut,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: '#0F0F26'.toColor(),
                                          borderRadius: BorderRadius.circular(12.sp),
                                        ),
                                        child: SingleChildScrollView(

                                          physics: NeverScrollableScrollPhysics(),
                                          child: Column(
                                            children: [
                                              for (int index = 0; index < liveController.titlesRecordText.length; index++)
                                                GestureDetector(
                                                  onTap: () {

                                                    liveController.selectedIndex = index;
                                                    liveController.postTimeRecord(liveController.liveDetails?['id']);
                                                    liveController.toggleExpand();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                                    margin: EdgeInsets.symmetric(vertical: 4.0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius: BorderRadius.circular(10.sp),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(liveController.titlesRecordIcon[index]),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          liveController.titlesRecordText[index],
                                                          style: TextStyle(
                                                            color: '#9C9CB8'.toColor(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }),
                            SizedBox(
                              width: 5,
                            ),
              GestureDetector(
              onTap: () {

              },
              child:    Container(
                height: 45,

                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: '#0F0F26'.toColor(),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/mediaverse/icons/calendar01.svg'),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Conductor')
                  ],
                ),
              ),
              ),

                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          '${liveController.liveDetails?['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: liveController
                                      .liveDetails?['description'] ==
                                      null
                                      ? ''
                                      : liveController.isExpandedViewBodyText
                                      ? liveController
                                      .liveDetails!['description']
                                      : liveController
                                      .liveDetails![
                                  'description']
                                      .length >
                                      80
                                      ? liveController.liveDetails![
                                  'description']
                                      .substring(0, 80) +
                                      ' '
                                      : liveController
                                      .liveDetails?['description'],
                                  style: TextStyle(
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                                if (liveController
                                    .liveDetails!['description'] !=
                                    null &&
                                    !liveController.isExpandedViewBodyText &&
                                    liveController.liveDetails!['description']
                                        .length >
                                        80)
                                  TextSpan(
                                    text: '...more',
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 3.h,
                        ),
                      ),
                    ),//--

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            liveController.liveDetails!["country"] !=null ?    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Country'),
                                Text('${liveController.liveDetails!["country"] !=null? liveController.liveDetails!["country"]["name"] :''}' ,style: TextStyle(
                                  color: '#9C9CB8'.toColor(),
                                  fontSize: 16
                                ),)
                              ],
                            ):SizedBox(),
                            SizedBox(width:  liveController.liveDetails!["country"] !=null ?  10.w:0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Language'),
                                Text('${ liveController.liveDetails!["language"]}' ,style: TextStyle(
                                  color: '#9C9CB8'.toColor(),
                                  fontSize: 16
                                ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 3.h,
                        ),
                      ),
                    ),
                    //--

                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 1.h,
                        ),
                      ),
                    ),
                    //--
                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--


                    //--
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: SizedBox(
                          height: 2.h,
                        ),
                      ),
                    ),
                    //--
                  ],
                );
              }
            }),
          )),
    );
  }

  Container buildCustomDetailBTNWidget(
      {required String iconName,
        required Function() onTap,
        required String name}) {
    return Container(
      decoration: BoxDecoration(
        color: '#0F0F26'.toColor(),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white.withOpacity(0.01),
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/mediaverse/icons/${iconName}.svg',
                  height: 16,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${name}',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

