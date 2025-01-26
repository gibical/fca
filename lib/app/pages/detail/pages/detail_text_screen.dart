import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/pages/text_page.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/app/pages/detail/widgets/text_file_widget.dart';
import 'package:mediaverse/app/pages/media_suit/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/enums/post_type_enum.dart';
import '../../../common/app_config.dart';
import '../../../common/app_route.dart';
import '../../../common/widgets/appbar_btn.dart';
import '../logic.dart';
import '../widgets/back_widget.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/details_bottom_widget.dart';
import '../widgets/report_botton_sheet.dart';
import '../widgets/youtube_bottomsheet.dart';
import 'detail_video_screen.dart';

class DetailTextScreen extends StatefulWidget {
  DetailTextScreen({super.key});

  @override
  State<DetailTextScreen> createState() => _DetailTextScreenState();
}

class _DetailTextScreenState extends State<DetailTextScreen> {
  bool isExpanded = false;

  final logic = Get.put(DetailController(1),
      tag: "${DateTime.now().microsecondsSinceEpoch}");

  var idAssetMediaValte = Get.arguments['idAssetMedia'];

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
              if (logic.isLoadingText.value || logic.textDetails!.isEmpty) {
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
                                'Text',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(iconName: 'menu', onTap: () {}),
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
                                    if (Get.arguments['idAssetMedia'] == "idAssetMedia") {
                                      Get.offAllNamed(PageRoutes.WRAPPER);
                                    } else {
                                      Get.back();
                                    }
                                  }),
                              Text(
                                'Text',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(
                                  iconName: 'menu',
                                  onTap: () {
                                    logic.isEditAvaiblae.isTrue
                                        ? showMenu(
                                            color: '#0F0F26'.toColor(),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp)),
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                                100, 80, 0, 0),
                                            items: [
                                              PopupMenuItem(
                                                value: 1,
                                                onTap: () {
                                                  logic.sendToEditProfile(
                                                      PostType.text);
                                                },
                                                child: SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/mediaverse/icons/edit.svg'),
                                                      Text('Edit'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 1,
                                                onTap: () {

                                                  Get.dialog(
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: Center(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: '#0F0F26'.toColor(),
                                                            borderRadius: BorderRadius.circular(12.sp),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 22),
                                                          margin: EdgeInsets.symmetric(horizontal: 18),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Delete asset?',
                                                                style: TextStyle(color: Colors.white  , fontWeight: FontWeight.w600),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                'Are you sure you want to delete this? This action cannot be undone.',
                                                                style: TextStyle(color:'#9C9CB8'.toColor() , fontSize: 13),
                                                              ),
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  InkWell(
                                                                    onTap:(){
                                                                      Get.back();
                                                                    },
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(color: Colors.white  , fontWeight: FontWeight.w600),
                                                                    ),
                                                                  ),

                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  InkWell(
                                                                    onTap:(){
                                                                      logic.
                                                                      deleteAsset(id:logic
                                                                          .textDetails?['id'] );
                                                                    },
                                                                    child:  Obx(() {
                                                                      if (logic.isLoadingDeleteAsset.value) {
                                                                        return Transform.scale(

                                                                          scale: 0.5,
                                                                          child: CircularProgressIndicator(
                                                                            color: Colors.redAccent,
                                                                            backgroundColor: Colors.redAccent.withOpacity(0.2),
                                                                          ),
                                                                        );
                                                                      }
                                                                      return    Text(
                                                                        'Delete',
                                                                        style: TextStyle(color:'#FF5630'.toColor()  , fontWeight: FontWeight.w600),
                                                                      );
                                                                    }),



                                                                  ),

                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );

                                                },
                                                child: SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      Obx(() {
                                                        if (logic.isLoadingDeleteAsset.value) {
                                                          return Transform.scale(

                                                            scale: 0.5,
                                                            child: CircularProgressIndicator(
                                                              color: Colors.redAccent,
                                                              backgroundColor: Colors.redAccent.withOpacity(0.2),
                                                            ),
                                                          );
                                                        }
                                                        return   SvgPicture.asset(
                                                            'assets/mediaverse/icons/delete.svg');
                                                      }),


                                                      Text('Delete'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ).then((value) {
                                            if (value != null) {
                                              print('$value');
                                            }
                                          })
                                        : showMenu(
                                            color: '#0F0F26'.toColor(),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.sp)),
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                                100, 80, 0, 0),
                                            items: [
                                              PopupMenuItem(
                                                value: 1,
                                                onTap: () {
                                                  Get.bottomSheet(
                                                      elevation: 0,
                                                      isScrollControlled: true,
                                                      ReportBottomSheet2(
                                                          logic));
                                                },
                                                child: SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/mediaverse/icons/report.svg',
                                                      ),
                                                      Text('Report'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ).then((value) {
                                            if (value != null) {
                                              print('$value');
                                            }
                                          });
                                  }),
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
                                  imageUrl: logic.textDetails?['user']
                                          ['image_url'] ??
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
                                  '${logic.textDetails?['user']['username']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '${logic.textDetails?['user']['full_name']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              '16 Dec 2024, 6:50PM',
                              style: TextStyle(
                                fontSize: 13,
                                color: '#9C9CB8'.toColor(),
                              ),
                            ),
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
                    //--
                    SliverToBoxAdapter(
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal:18.0 ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 350,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: '#17172E'.toColor(),
                                  borderRadius: BorderRadius.circular(14.sp)),
                              child:              FittedBox(
                                fit: BoxFit.cover,
                                child: Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.sp),
                                      child: CachedNetworkImage(
                                        imageUrl: logic.textDetails?[
                                        'thumbnails'] !=
                                            null &&
                                            logic.textDetails!['thumbnails']
                                            is Map<String, dynamic>
                                            ? logic.textDetails!['thumbnails']
                                        ['525x525'] ??
                                            ''
                                            : '',
                                        fit: BoxFit.cover,


                                        placeholder: (context, url) {
                                          return Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: SvgPicture.asset(
                                              'assets/mediaverse/icons/file-text.svg' , height: 4,),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: SvgPicture.asset(
                                              'assets/mediaverse/icons/file-text.svg' ,height: 4,),
                                          );
                                        },
                                      )),
                                ),
                              ),
                              // child: PlayerVideo(),
                            ),

                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {

                                  Get.to(TextPage(title: '${logic.textDetails?['name']}', url: '${logic.textDetails?['file']['url']}'));
                                },
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  padding:EdgeInsets.symmetric(horizontal: 15 , vertical: 13) ,
                                  decoration:
                                  BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColor.primaryColor),
                                  child: Row(
                                    children: [
                                      SvgPicture.string(
                                          """<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                                  <path d="M4.66602 6.87887C5.72083 7.04222 6.8975 7.31381 7.99935 7.7399M4.66602 10.2122C5.19892 10.2947 5.76293 10.4049 6.33268 10.5486M10.4993 5.04447V16.9187M3.82796 2.50939C5.6766 2.71829 8.16029 3.28027 9.93004 4.52037C10.2702 4.75871 10.7285 4.75871 11.0687 4.52037C12.8384 3.28027 15.3221 2.71829 17.1707 2.50939C18.0857 2.40601 18.8327 3.17002 18.8327 4.11265V13.5C18.8327 14.4426 18.0857 15.2069 17.1707 15.3103C15.3221 15.5192 12.8384 16.0811 11.0687 17.3212C10.7285 17.5596 10.2702 17.5596 9.93004 17.3212C8.16029 16.0811 5.6766 15.5192 3.82796 15.3103C2.91304 15.2069 2.16602 14.4426 2.16602 13.5V4.11265C2.16602 3.17002 2.91304 2.40601 3.82796 2.50939Z" stroke="#F5F5F5" stroke-linecap="round"/>
                                  </svg>
                                  """),
                                      SizedBox(
                                        width: 5,
                                      ),

                                      Text('Open')


                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                    ),
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          children: [
                            buildCustomDetailBTNWidget(
                                iconName: 'Magic',
                                onTap: () {
                                  runCustomSelectBottomToolsTextAsset(logic);
                                },
                                name: 'Tools'),
                            SizedBox(
                              width: 8,
                            ),
                            buildCustomDetailBTNWidget(
                                iconName: 'globe',
                                onTap: () {
                                  runCustomPublishSheet(logic);
                                },
                                name: 'Publish'),
                            Spacer(),
                            // buildCustomDetailBTNWidget(
                            //     iconName: 'Forward',
                            //     onTap: () {},
                            //     name: 'Share'),
                          ],
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
                        child: Text(
                          '${logic.textDetails?['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                          onTap: () {
                           setState(() {
                             logic.isExpandedViewBodyText  = !   logic.isExpandedViewBodyText;
                           });
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: logic.textDetails?['description'] ==
                                          null
                                      ? ''
                                      : logic.isExpandedViewBodyText
                                          ? logic.textDetails!['description']
                                          : logic.textDetails!['description']
                                                      .length >
                                                  80
                                              ? logic.textDetails![
                                                          'description']
                                                      .substring(0, 80) +
                                                  ' '
                                              : logic
                                                  .textDetails?['description'],
                                  style: TextStyle(
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                                if (logic.textDetails!['description'] != null &&
                                    !logic.isExpandedViewBodyText &&
                                    logic.textDetails!['description'].length >
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
                    ),
                    //--

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Obx(() {
                              if (logic.isLoadingComment.value) {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'details_12'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (logic.commentsData == null ||
                                  logic.commentsData!.isEmpty) {
                                return SizedBox();
                              } else {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'details_12'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text:
                                            ' (${logic.commentsData!['data'].length})',
                                        style: TextStyle(
                                          color: '#9C9CB8'.toColor(),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })),
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
                    //--
                    SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: TextField(
                            controller: logic.commentTextController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: 'Add a comment...',
                                fillColor: '#0F0F26'.toColor(),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.sp)),
                                suffixIcon: Transform.scale(
                                    scale: 0.8,
                                    child: IconButton(
                                      onPressed: () async {
                                        logic.postComment();
                                        logic.commentTextController.text = '';
                                        logic.isLoadingComment.value = true;
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        logic.fetchMediaComments();
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/mediaverse/icons/send.svg',
                                        height: 25,
                                      ),
                                    ))),
                          )),
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

                    Obx(() {
                      if (logic.isLoadingComment.value) {
                        return SliverToBoxAdapter(
                            child: Center(
                                child: CupertinoActivityIndicator(
                          color: AppColor.primaryColor,
                        )));
                      } else if (logic.commentsData == null ||
                          logic.commentsData!.isEmpty) {
                        return SliverToBoxAdapter(child: SizedBox());
                      } else {
                        return SliverList.builder(
                            itemCount: logic.commentsData!['data'].length,
                            itemBuilder: (context, index) {
                              final comment =
                                  logic.commentsData?['data'][index];
                              return CommentBoxWidget(
                                data: comment,
                              );
                            });
                      }
                    }),

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



























void runCustomSelectBottomToolsTextAsset(DetailController controller) {
  Get.bottomSheet(
    elevation: 0,
    isScrollControlled: true,
    StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: 100.w,

          decoration: BoxDecoration(
            color: "#0F0F26".toColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 3.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Text(
                        'Tools',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        iconSize: 18,
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: '9C9CB8'.toColor(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  color: '9C9CB8'.toColor().withOpacity(0.3),
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                //BTN Tools 1
                GestureDetector(
                  onTap: () {
                    Get.back();


                    Get.find<MediaSuitController>().setDataEditText(controller.textDetails?['name'] ?? '' , controller.textDetails?['name']  , controller.textDetails!['file_id'].toString());
                    Get.toNamed(PageRoutes.MEDIASUIT);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: '2563EB'.toColor(),
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/mediaverse/icons/tools1.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Open in media studio',
                          style: TextStyle(
                              fontSize: 15,),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/mediaverse/icons/open.svg',
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  color: '9C9CB8'.toColor().withOpacity(0.3),
                  height: 0.5,
                  width: Get.width,
                ),
            
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                //BTN Tools 2
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.textToAudio();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: '2563EB'.toColor(),
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: Center(
                            child: SvgPicture.string(
                             """<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M15.4993 8.5563C15.9975 8.84447 16.3327 9.38309 16.3327 9.99999C16.3327 10.6169 15.9975 11.1555 15.4993 11.4437M15.4993 5.91665C17.4012 6.30271 18.8327 7.98417 18.8327 9.99997C18.8327 12.0158 17.4012 13.6972 15.4993 14.0833M6.77704 6.33504L10.3327 3.66952C11.4314 2.84585 12.9993 3.62946 12.9993 5.00225V14.9977C12.9993 16.3705 11.4314 17.1541 10.3327 16.3304L6.77704 13.6649C6.4886 13.4487 6.13782 13.3318 5.77733 13.3318H3.83268C2.91221 13.3318 2.16602 12.5859 2.16602 11.6659V8.33407C2.16602 7.41401 2.91221 6.66816 3.83268 6.66816H5.77733C6.13782 6.66816 6.4886 6.55128 6.77704 6.33504Z" stroke="#F5F5F5" stroke-linecap="round"/>
            </svg>
            """,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Text to Audio',
                          style: TextStyle(
                              fontSize: 15, ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
            
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                //BTN Tools 3
                GestureDetector(
                  onTap: () {
                    controller.translateText();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: '2563EB'.toColor(),
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: Center(
                            child: SvgPicture.string(
                              """<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M17.584 17.0833L16.334 14.3056M10.084 17.0833L11.334 14.3056M11.334 14.3056L13.834 8.75L16.334 14.3056M11.334 14.3056H16.334" stroke="#F5F5F5" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M3.41602 4.58335H7.16602M10.916 4.58335H9.04102M7.16602 4.58335V2.91669M7.16602 4.58335H9.04102M9.04102 4.58335C9.04102 4.58335 9.04102 11.25 3.41602 11.25M10.0827 10.4167C6.33268 10.4167 5.08268 7.08335 5.08268 7.08335" stroke="#F5F5F5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            """,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Translate to',
                          style: TextStyle(
                              fontSize: 15,),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/mediaverse/icons/arrow.svg',
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
            
            
            
            
                //BTN Tools 4
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.textToImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: '2563EB'.toColor(),
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: Center(
                            child: SvgPicture.string(
                              """
                              <svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12.166 1.66669H5.49935C3.6584 1.66669 2.16602 3.15907 2.16602 5.00002V15C2.16602 16.841 3.6584 18.3334 5.49935 18.3334H15.4993C17.3403 18.3334 18.8327 16.841 18.8327 15V8.33335M16.3327 1.66669V6.66669M18.8327 4.16669L13.8327 4.16669M18.8327 11.6667L16.3835 9.90328C15.1109 8.98697 13.3716 9.08167 12.2059 10.1308L8.79275 13.2026C7.62711 14.2517 5.88785 14.3464 4.61519 13.4301L2.16602 11.6667M9.66602 7.08335C9.66602 8.23395 8.73328 9.16669 7.58268 9.16669C6.43209 9.16669 5.49935 8.23395 5.49935 7.08335C5.49935 5.93276 6.43209 5.00002 7.58268 5.00002C8.73328 5.00002 9.66602 5.93276 9.66602 7.08335Z" stroke="#F5F5F5" stroke-linecap="round"/>
</svg>

            """,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Text to Image',
                          style: TextStyle(
                            fontSize: 15,),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 0.5,
                  width: Get.width,
                ),

                //BTN Tools 5
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    runCustomAIPromptToolsTextAsset(controller);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: '2563EB'.toColor(),
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: Center(
                            child: SvgPicture.string(
                              """<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12.4887 4.85928L15.6408 8.01137M3 17.5L6.06065 16.9174C6.7096 16.7938 7.30641 16.478 7.77353 16.0109L17.3198 6.46461C18.2267 5.55765 18.2267 4.08718 17.3198 3.18022C16.4128 2.27326 14.9423 2.27326 14.0354 3.18022L4.48913 12.7265C4.02201 13.1936 3.70617 13.7904 3.58263 14.4393L3 17.5Z" stroke="#F5F5F5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

            """,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'AI Prompt',
                          style: TextStyle(
                            fontSize: 15,),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/mediaverse/icons/arrow.svg',
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 0.5,
                  width: Get.width,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
void runCustomAIPromptToolsTextAsset(DetailController controller) {
  Get.bottomSheet(
    elevation: 0,
    isScrollControlled: true,
    StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: 100.w,

          decoration: BoxDecoration(
            color: "#0F0F26".toColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset('assets/mediaverse/icons/arrow.svg'),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'What to do?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 24),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  TextField(



                    controller: controller.prefixEditingController,
                    maxLines: 3,
                    style: TextStyle(
                      decorationColor: Colors.transparent,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'What should I do?',
                      hintStyle: TextStyle(color: '9C9CB8'.toColor()),
                      fillColor: '#17172E'.toColor(),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Material(
                      color: '2563EB'.toColor(),
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        splashColor: Colors.white.withOpacity(0.03),
                        onTap: () {
                          Get.back();
                          controller.textToText();
                        },
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}