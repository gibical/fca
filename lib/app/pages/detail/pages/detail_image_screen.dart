import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/detail/widgets/back_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';
import '../../../common/widgets/appbar_btn.dart';
import '../../media_suit/logic.dart';
import '../logic.dart';
import '../widgets/custom_comment_single_pageWidget.dart';
import '../widgets/details_bottom_widget.dart';
import '../widgets/report_botton_sheet.dart';
import '../widgets/youtube_bottomsheet.dart';
import 'detail_video_screen.dart';



class DetailImageScreen extends StatelessWidget {
  DetailImageScreen({super.key});


  var imageController = Get.put(DetailController(2),tag: "${DateTime.now().microsecondsSinceEpoch}");

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
              if (imageController.isLoadingImages.value ||
                  imageController.imageDetails!.isEmpty) {
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
                                'Image',
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
                                'Image',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              AppbarBTNWidget(
                                  iconName: 'menu',
                                  onTap: () {
                                    imageController.isEditAvaiblae.isTrue
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
                                            imageController
                                                .sendToEditProfile(
                                                PostType.image);
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
                                                                imageController.
                                                                deleteAsset(id:imageController
                                                                    .imageDetails?['id'] );
                                                              },
                                                              child:  Obx(() {
                                                                if (imageController.isLoadingDeleteAsset.value) {
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
                                                  if (imageController.isLoadingDeleteAsset.value) {
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
                                        :  showMenu(
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
                                                ReportBottomSheet2(imageController));
                                          },
                                          child: SizedBox(
                                            width: 130,
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/mediaverse/icons/report.svg' , ),
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
                                  imageUrl: imageController
                                      .imageDetails?['user']['image_url'] ??
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
                                  '${imageController.imageDetails?['user']['username']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '${imageController.imageDetails?['user']['full_name']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              '${imageController.formatDateString(imageController.imageDetails?['created_at'])}',
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                              color: '17172E'.toColor(),
                              borderRadius: BorderRadius.circular(14.sp)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.sp),
                              child: CachedNetworkImage(
                                imageUrl: imageController.imageDetails?[
                                'thumbnails'] !=
                                    null &&
                                    imageController.imageDetails!['thumbnails']
                                    is Map<String, dynamic>
                                    ? imageController.imageDetails!['thumbnails']
                                ['525x525'] ??
                                    ''
                                    : '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Center(child: Transform.scale(
                                    scale: 0.5,
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                      backgroundColor: AppColor.primaryColor.withOpacity(0.3),
                                    ),
                                  ),);
                                },
                                errorWidget: (context, url, error) {
                                  return Center(child: Transform.scale(
                                    scale: 0.5,
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                      backgroundColor: AppColor.primaryColor.withOpacity(0.3),
                                    ),
                                  ),);
                                },
                              )),
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
                          children: [
                            buildCustomDetailBTNWidget(
                                iconName: 'Magic',
                                onTap: () {
                                  runCustomSelectBottomToolsImageAsset(
                                      imageController);
                                },
                                name: 'Tools'),
                            SizedBox(
                              width: 8,
                            ),
                            buildCustomDetailBTNWidget(
                                iconName: 'globe',
                                onTap: () {
                                  runCustomPublishSheet(imageController);
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
                          '${imageController.imageDetails?['name']}',
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
                                  text: imageController
                                      .imageDetails?['description'] ==
                                      null
                                      ? ''
                                      : imageController.isExpandedViewBodyText
                                      ? imageController
                                      .imageDetails!['description']
                                      : imageController
                                      .imageDetails![
                                  'description']
                                      .length >
                                      80
                                      ? imageController.imageDetails![
                                  'description']
                                      .substring(0, 80) +
                                      ' '
                                      : imageController
                                      .imageDetails?['description'],
                                  style: TextStyle(
                                    color: '#9C9CB8'.toColor(),
                                  ),
                                ),
                                if (imageController
                                    .imageDetails!['description'] !=
                                    null &&
                                    !imageController.isExpandedViewBodyText &&
                                    imageController.imageDetails!['description']
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
                    ),
                    //--

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Obx(() {
                              if (imageController.isLoadingComment.value) {
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
                              } else if (imageController.commentsData == null ||
                                  imageController.commentsData!.isEmpty) {
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
                                        ' (${imageController.commentsData!['data'].length})',
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
                            controller: imageController.commentTextController,
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
                                        imageController.postComment();
                                        imageController
                                            .commentTextController.text = '';
                                        imageController.isLoadingComment.value =
                                        true;
                                        await Future.delayed(
                                            Duration(seconds: 1));
                                        imageController.fetchMediaComments();
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
                      if (imageController.isLoadingComment.value) {
                        return SliverToBoxAdapter(
                            child: Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColor.primaryColor,
                                )));
                      } else if (imageController.commentsData == null ||
                          imageController.commentsData!.isEmpty) {
                        return SliverToBoxAdapter(child: SizedBox());
                      } else {
                        return SliverList.builder(
                            itemCount:
                            imageController.commentsData!['data'].length,
                            itemBuilder: (context, index) {
                              final comment =
                              imageController.commentsData?['data'][index];
                              return CommentBoxWidget(
                                data: comment,logic: imageController,
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


void runCustomSelectBottomToolsImageAsset(DetailController controller) {
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
                SizedBox(

                  height: 0.5,
                  width: Get.width,
                ),
                SizedBox(height: 2.h),
                //BTN Tools 1
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.find<MediaSuitController>().setDataEditImage(controller.imageDetails?['name'] ?? '' , controller.imageDetails?['file']['url'] , controller.imageDetails!['file_id'].toString());
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
                            fontSize: 15, ),
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
                SizedBox(height: 4.h),

              ],
            ),
          ),
        );
      },
    ),
  );
}