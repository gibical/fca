import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';

class DetailTextScreen extends StatefulWidget {
  DetailTextScreen({super.key});

  @override
  State<DetailTextScreen> createState() => _DetailTextScreenState();
}

class _DetailTextScreenState extends State<DetailTextScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textController = Get.find<DetailController>();
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
        bottomNavigationBar: Obx(() {
          if (textController.isLoadingText.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (textController.textDetails != null &&
                textController.textDetails!.containsKey('asset') &&
                textController.textDetails!['asset'] != null &&
                textController.textDetails!['asset'].containsKey('plan')) {
              int plan = textController.textDetails!['asset']['plan'];
              print(plan);
              if (plan == 1) {
                return SizedBox();
              } else if (plan == 2 || plan == 3) {
                return BuyCardWidget(
                    selectedItem:textController.textDetails ,
                    title: textController.textDetails!['asset']['plan'] == 2
                        ? 'Ownership'
                        : textController.textDetails!['asset']['plan'] == 3
                        ? 'Subscribe'
                        : '',
                    price: textController.textDetails!['asset']['price']
                );

              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }
        }),
      body: Obx((){
        return textController.isLoadingText.value ? Center(child: CircularProgressIndicator(),): CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: 27.5.h,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40.sp),
                          bottomLeft: Radius.circular(40.sp),
                        ),
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.white.withOpacity(0.2)))),
                  ),
                  Positioned(
                    top: 2.h,
                    left: 7.w,
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.7.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 135,
                            width: 135,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      AppColor.primaryDarkColor,
                                      AppColor.primaryLightColor
                                          .withOpacity(0.8),
                                      AppColor.whiteColor,
                                    ])),
                            child: Transform.scale(
                                scale: 0.14,
                                child: SvgPicture.asset(
                                  AppIcon.textIcon,
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 48.w,
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${textController.textDetails?['name']}',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: textController.textDetails?['name'].length > 15 ? 17 : 21,
                                      ),
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 3.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        textController.textDetails?['asset']['user']
                                        ['username'],
                                        style: FontStyleApp.bodySmall
                                            .copyWith(
                                            color: AppColor.grayLightColor
                                                .withOpacity(0.8),
                                            fontSize: 13),
                                      ),
                                      Spacer(),
                                      Text(
                                        'report',
                                        style: FontStyleApp.bodySmall
                                            .copyWith(
                                            color: AppColor.grayLightColor
                                                .withOpacity(0.8),
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.4.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        textController.textDetails?['description'] == null
                            ? ''
                            : isExpanded
                            ? textController.textDetails!['description']
                            : (textController.textDetails?['description'].length > 80
                            ? textController.textDetails!['description']
                            .substring(0, 80) +
                            '...more'
                            : textController.textDetails?['description']),
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Wrap(
                      children: [
                        CardMarkSinglePageWidget(label: 'Suffix' , type: (textController.textDetails?['suffix'] ?? 'null') ),
                        CardMarkSinglePageWidget(label: 'Type' , type: textController.getTypeString(textController.textDetails?['asset']['type'])),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Wrap(
                      children: [],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        int itemId = textController.textDetails?['asset_id'];
                        print(itemId);
                        Get.toNamed(PageRoutes.COMMENT, arguments: {'id': itemId});
                      },
                      child: CustomCommentSinglePageWidget(),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      })
    );
  }
}
