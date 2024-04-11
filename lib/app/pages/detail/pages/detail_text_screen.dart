import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/media_suit/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../../../common/app_config.dart';
import '../../../common/app_route.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/report_botton_sheet.dart';

class DetailTextScreen extends StatefulWidget {
  DetailTextScreen({super.key});

  @override
  State<DetailTextScreen> createState() => _DetailTextScreenState();
}

class _DetailTextScreenState extends State<DetailTextScreen> {
  bool isExpanded = false;

    final logic = Get.find<DetailController>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        backgroundColor: AppColor.primaryDarkColor,
        bottomNavigationBar: Obx(() {
          if (logic.isLoadingText.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (logic.textDetails != null &&
                logic.textDetails!.containsKey('asset') &&
                logic.textDetails!['asset'] != null &&
                logic.textDetails!['asset'].containsKey('plan')) {
              int plan = logic.textDetails!['asset']['plan'];
              print(plan);
              if (plan == 1) {
                return SizedBox();
              } else if (plan == 2 || plan == 3) {
                return BuyCardWidget(
                    selectedItem:logic.textDetails ,
                    title: logic.textDetails!['asset']['plan'] == 2
                        ? 'Ownership'
                        : logic.textDetails!['asset']['plan'] == 3
                        ? 'Subscribe'
                        : '',
                    price: logic.textDetails!['asset']['price']
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

          return logic.isLoadingText.value ? Center(child: CircularProgressIndicator(),): Stack(
            children: [
              CustomScrollView(
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
                                        if(logic.textDetails?['name']!=null)   Expanded(
                                          child: Text(
                                            '${logic.textDetails?['name']}',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: logic.textDetails?['name'].length > 15 ? 17 : 21,
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
                                            if( logic.textDetails?['user']
                                                !=null)  Text(
                                              logic.textDetails?['user']
                                              ['username'],
                                              style: FontStyleApp.bodySmall
                                                  .copyWith(
                                                  color: AppColor.grayLightColor
                                                      .withOpacity(0.8),
                                                  fontSize: 13),
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: (){
                                                Get.bottomSheet(ReportBottomSheet(logic));
                                              },
                                              child: Text(
                                                'report',
                                                style: FontStyleApp.bodySmall
                                                    .copyWith(
                                                    color: AppColor.grayLightColor
                                                        .withOpacity(0.8),
                                                    fontSize: 13),
                                              ),
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
                              logic.textDetails?['description'] == null
                                  ? ''
                                  : isExpanded
                                  ? logic.textDetails!['description']
                                  : (logic.textDetails?['description'].length > 80
                                  ? logic.textDetails!['description']
                                  .substring(0, 80) +
                                  '...more'
                                  : logic.textDetails?['description']),
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    logic.textToText();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__single-convert-to-text.svg",
                                    width: 6.w,
                                  )),

                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    logic.textToImage();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__single-convert-to-image.svg",
                                    width: 6.w,
                                  )),

                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    logic.textConvertToAudio();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__single-convert-to-audio.svg",
                                    width: 6.w,
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    logic.sendShareYouTube();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__video-white.svg",
                                    width: 6.w,
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    logic.translateText();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/icon__single-tranlate.svg",
                                    width: 6.w,
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.find<MediaSuitController>().setDataEditText(logic.textDetails?['name'] ?? '');
                                  Get.toNamed(PageRoutes.MEDIASUIT);
                                },
                                child:  Icon(Icons.edit),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Wrap(
                            children: [
                              CardMarkSinglePageWidget(label: 'Suffix' , type: (logic.textDetails?['suffix'] ?? 'null') ),
                              CardMarkSinglePageWidget(label: 'Type' , type: logic.getTypeString(logic.textDetails?['type']??1)),
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
                              int itemId = logic.textDetails?['asset_id'];
                              print(itemId);
                              Get.toNamed(PageRoutes.COMMENT, arguments: {'id': itemId});
                            },
                            child: CustomCommentSinglePageWidget(),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                return Visibility(
                  visible: logic.isEditAvaiblae.isTrue,

                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 100.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                          color: "191b47".toColor(),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.sp),
                            topLeft: Radius.circular(15.sp),
                          ),
                          border: Border(
                              top: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 0.6),
                              left: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 0.8),

                              right: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 0.1)
                          )
                      ),

                      padding: EdgeInsets.all(16),
                      child: Column(

                        children: [
                          Container(
                            width: 100.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                                color: Color(0xff4E4E61).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 0.6),
                                    left: BorderSide(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 0.8),

                                    right: BorderSide(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 0.1)
                                )
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Row(
                              children: [
                                Expanded(child: Text(
                                    '${Constant.getDropDownByPlan(logic.textDetails!['plan'].toString())}')),
                                if(!logic.textDetails!['plan'].toString().contains("1"))  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("${(logic.textDetails!['price']/100).toString()} €"),
                                    SizedBox(width: 3.w,),
                                    SvgPicture.asset("assets/images/download.svg"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Container(
                              width: 100.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  color: Color(0xff4E4E61).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100.sp),
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 0.6),
                                      left: BorderSide(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 0.8),

                                      right: BorderSide(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 0.1)
                                  )
                              ),

                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000)
                                ),
                                onPressed: () {
                                  logic.sendToEditProfile(PostType.text);
                                },
                                child: Center(
                                  child: Text("Edit informatiocn",
                                    style: TextStyle(color: "83839C".toColor()),),
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              })

            ],
          );
        })
    ), onWillPop: ()async{
      if(Get.arguments['idAssetMedia'] == "idAssetMedia"){
              Get.offAllNamed(PageRoutes.WRAPPER);
      }else{
    Get.back();
      }

      return false;
    }
    );
  }
}
