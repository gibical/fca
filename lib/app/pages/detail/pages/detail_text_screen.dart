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

import '../logic.dart';

class DetailTextScreen extends StatefulWidget {
  DetailTextScreen({super.key});

  @override
  State<DetailTextScreen> createState() => _DetailTextScreenState();
}

class _DetailTextScreenState extends State<DetailTextScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDarkColor,
      bottomNavigationBar: BuyCardWidget(price: Get.find<DetailController>().selectedItem.value['asset']['price']),
      body: GetBuilder<DetailController>(
        builder: (controller) {
          var selectedItem = controller.selectedItem.value;
          return CustomScrollView(
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
                                        '${selectedItem['name']}',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: selectedItem['name'].length > 15 ? 17 : 21,
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
                                          selectedItem['asset']['user']
                                              ['username'],
                                          style: FontStyleApp.bodySmall
                                              .copyWith(
                                                  color: AppColor.grayLightColor
                                                      .withOpacity(0.8),
                                                  fontSize: 13),
                                        ),
                                        Spacer(),
                                        Text(
                                          '8:15',
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
                          selectedItem['description'] == null
                              ? ''
                              : isExpanded
                              ? selectedItem['description']
                              : (selectedItem['description'].length > 80
                              ? selectedItem['description']
                              .substring(0, 80) +
                              '...more'
                              : selectedItem['description']),
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
                          CardMarkSinglePageWidget(label: 'Suffix' , type: (selectedItem['suffix'] ?? 'null') ),
                          CardMarkSinglePageWidget(label: 'Type' , type: '${selectedItem['type']}'),
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
                      Container(
                        height: 17.5.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border(
                                top: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.6),
                                left: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.8),
                                right: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.1))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Comments',
                                    style: FontStyleApp.bodyLarge.copyWith(
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Text(
                                    '56',
                                    style: FontStyleApp.bodyMedium.copyWith(
                                      color:
                                          AppColor.whiteColor.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 19,
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 5.h,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.black54,
                                            hintText: 'Add a comment...',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none)),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
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
        },
      ),
    );
  }
}
