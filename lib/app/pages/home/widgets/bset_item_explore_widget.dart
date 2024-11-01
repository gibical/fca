import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/pages/home/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetBestVideos.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannels.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetmostText.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/FromJsonGetBestModelVideows.dart';
import '../../../common/app_route.dart';

class BestItemExploreWidget extends GetView<HomeLogic> {
  BestItemExploreWidget(this.elementAt, {super.key});

  dynamic elementAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        String itemId = elementAt['id'];
        Get.toNamed(PageRoutes.DETAILVIDEO, arguments: {'id': itemId});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                width: 40.w,
                height: 20.h,
                decoration: BoxDecoration(
                    color: theme.onBackground.withOpacity(0.1),
                    border: Border.symmetric(
                        horizontal: BorderSide(
                      width: 0.9,
                      color: theme.onBackground.withOpacity(
                        0.2,
                      ),
                    )),
                    borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    //

                    //             ),
                    Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                          image: (elementAt['thumbnails'].toString().length > 3)
                              ? DecorationImage(
                                  image: NetworkImage(
                                    "${elementAt['thumbnails']['336x366']}",
                                  ),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: AssetImage(
                                    'assets/${F.assetTitle}/images/tum_image.jpeg',
                                  ),
                                  fit: BoxFit.cover),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.sp)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 10),
                      child: SvgPicture.asset(AppIcon.videoIcon,
                          color: AppColor.grayLightColor.withOpacity(0.5),
                          height: 1.8.h),
                    )
                  ],
                )),
            Container(
              width: 40.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        elementAt['media']['name'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xFF666680),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Row(
                    children: [
                      ClipRRect(
                        child: Container(
                          width: 4.w,
                          height: 4.w,
                          child: CachedNetworkImage(
                            imageUrl: elementAt['user']['image_url'] ?? " ",
                            errorWidget: (a, l, pl) {
                              return Image.asset(
                                "assets/${F.assetTitle}/images/avatar.jpeg",
                                width: 4.w,
                              );
                            },
                          ),
                        ),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        elementAt['user']['username'],
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Color(0xFF666680),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BestItemSongsWidget extends GetView<HomeLogic> {
  BestItemSongsWidget(this.elementAt, {super.key});

  dynamic elementAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        String itemId = elementAt['id'];

        Get.toNamed(PageRoutes.DETAILMUSIC, arguments: {
          'id': itemId,
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                width: 40.w,
                height: 20.h,
                decoration: BoxDecoration(
                    color: theme.onBackground.withOpacity(0.1),
                    border: Border.symmetric(
                        horizontal: BorderSide(
                      width: 0.9,
                      color: theme.onBackground.withOpacity(
                        0.2,
                      ),
                    )),
                    borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox.expand(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.sp),
                        child: (elementAt['thumbnails'].toString().length > 3)
                            ? Image.network(
                                "${elementAt['thumbnails']['336x366']}",
                                fit: BoxFit.cover)
                            : Image.asset("assets/${F.assetTitle}/images/tum_sound.jpeg",
                                fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.sp)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 10),
                      child: SvgPicture.asset("assets/${F.assetTitle}/icons/sound_vector.svg",
                          color: AppColor.grayLightColor.withOpacity(0.5),
                          height: 1.8.h),
                    )
                  ],
                )),
            Container(
              width: 40.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        elementAt['media']['name'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xFF666680),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Row(
                    children: [
                      ClipRRect(
                        child: Container(
                          width: 4.w,
                          height: 4.w,
                          child: CachedNetworkImage(
                            imageUrl: elementAt['user']['image_url'] ?? " ",
                            errorWidget: (a, l, pl) {
                              return Image.asset(
                                "assets/${F.assetTitle}/images/avatar.jpeg",
                                width: 4.w,
                              );
                            },
                          ),
                        ),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        elementAt['user']['username'],
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: Color(0xFF666680),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BestChannelsWidget extends GetView<HomeLogic> {
  BestChannelsWidget({required this.model});

  ChannelModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 40.w,
          height: 20.w,
          decoration: BoxDecoration(
              color: theme.onBackground.withOpacity(0.1),
              image: DecorationImage(
                  image: NetworkImage(
                    model.thumbnail ?? "",
                  ),
                  fit: BoxFit.cover),
              border: Border.symmetric(
                  horizontal: BorderSide(
                width: 0.9,
                color: theme.onBackground.withOpacity(
                  0.2,
                ),
              )),
              borderRadius: BorderRadius.all(Radius.circular(20.sp))),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                  // gradient: LinearGradient(
                  //     begin: Alignment.bottomCenter,
                  //     end: Alignment.topCenter,
                  //     colors: [
                  //       Colors.black.withOpacity(0.6),
                  //       Colors.black.withOpacity(0.4),
                  //      Colors.transparent,
                  //
                  // ])
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 10),
                child: SvgPicture.asset(AppIcon.videoIcon,
                    color: AppColor.grayLightColor.withOpacity(0.5),
                    height: 1.8.h),
              )
            ],
          )),
    );
  }
}

class BestTextWidget extends GetView<HomeLogic> {
  BestTextWidget({required this.model});

  dynamic model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    print('BestTextWidget.build = ${model['user']}');
    return GestureDetector(
      onTap: () {
        String itemId = model['id'];
        String fileId = model['file_id'];
        Get.toNamed(PageRoutes.DETAILTEXT,
            arguments: {'id': itemId, 'file_id': fileId});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 40.w,
            height: 20.w,
            decoration: BoxDecoration(
                // color: theme.onBackground.withOpacity(0.1),
                // border: Border.symmetric(horizontal: BorderSide(
                //   width: 0.9,
                //   color: theme.onBackground.withOpacity(0.2 , ),
                // )),
                // borderRadius: BorderRadius.all(Radius.circular(20.sp))
                ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox.expand(
                  child: Image.asset(
                    "assets/${F.assetTitle}/images/text_bg.png",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox.expand(
                  child: Container(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              model['media']['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                                color: Color(0xFFCCCCFF),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              model['media']['description'] ?? " ",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                                color: Color(0xFF666680),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              ClipRRect(
                                child: Container(
                                  width: 4.w,
                                  height: 4.w,
                                  child: CachedNetworkImage(
                                    imageUrl: model['user']['image_url'] ?? " ",
                                    errorWidget: (a, l, pl) {
                                      return Image.asset(
                                        "assets/${F.assetTitle}/images/avatar.jpeg",
                                        width: 4.w,
                                      );
                                    },
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                model['user']['username'] ?? " ",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme
                                  .of(context)
                                  .textTheme.bodySmall?.copyWith(
                                  color: Color(0xFF666680),
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                )
              ],
            )),
      ),
    );
  }
}
