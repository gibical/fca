import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:mediaverse/app/pages/channel/tab/single_channel_logic.dart';
import 'package:mediaverse/app/pages/detail/widgets/back_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/buy_card_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/card_mark_singlepage_widget.dart';
import 'package:mediaverse/app/pages/detail/widgets/custom_app_bar_detail_video_and_image.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../media_suit/logic.dart';
import '../widgets/card_channel_widget.dart';


class DetailChannelScreen extends StatefulWidget {
  DetailChannelScreen({super.key});

  @override
  State<DetailChannelScreen> createState() => _DetailChannelScreenState();
}

class _DetailChannelScreenState extends State<DetailChannelScreen> {
  ChannelsModel channelsModel = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    SingleChannelLogic logic = Get.put(SingleChannelLogic(channelsModel));

    return WillPopScope( //
      onWillPop: () async {
        return true;
      },
      child: Scaffold(

          backgroundColor: AppColor.primaryDarkColor,

          body: Obx(() {
            return (logic.isloading.value) ? Center(
              child: CircularProgressIndicator(),) : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 27.h,
                        //  color: Colors.red,
                        child: Stack(
                          children: [
                            Container(
                              height: 27.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(25.sp),
                                    bottomRight: Radius.circular(25.sp)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      channelsModel.thumbnails ?? ""),
                                  fit: BoxFit.cover, //
                                ),
                              ),
                              child: Opacity(opacity: 0),
                            ),

                            Container(
                              height: 27.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25.sp),
                                      bottomRight: Radius.circular(25.sp)),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.66),
                                        Colors.black.withOpacity(0.3),
                                        Colors.transparent,

                                      ])

                              ),
                            ),
                            Positioned(
                                bottom: 15,
                                left: 25,
                                child: SvgPicture.asset(
                                  AppIcon.imageIcon, color: Colors.white60,))
                          ],
                        ),
                      ),

                      Container(
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('${channelsModel.name}',
                                    style: FontStyleApp.titleMedium.copyWith(
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w600
                                    ),),

                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(channelsModel.description ?? "",
                                    style: FontStyleApp.bodyMedium.copyWith(
                                      color: AppColor.grayLightColor
                                          .withOpacity(0.8),
                                    ),),

                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('details_39'.tr,
                                    style: FontStyleApp.titleMedium.copyWith(
                                        color: AppColor.whiteColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800
                                    ),),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.white,),
                                    onPressed: () {},)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  ...(logic.channelsModel.programs ?? [])
                                      .asMap()
                                      .entries
                                      .map((toElement) {
                                    return CustomCardChannelWidget(
                                      title: toElement.value.name ?? "",
                                      date: toElement.value.createdAt
                                          .toString(),);
                                  }).toList()
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('details_40'.tr,
                                    style: FontStyleApp.titleMedium.copyWith(
                                        color: AppColor.whiteColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800
                                    ),),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.white,),
                                    onPressed: () {
                                      logic.addDestination();
                                    },)
                                ],
                              ),
                            ),
                            GetBuilder<SingleChannelLogic>(
                                init: logic,
                                builder: (logic) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    ...(logic.channelsModel.destinations ?? [])
                                        .asMap()
                                        .entries
                                        .map((toElement) {
                                      return CustomCardChannelWidget(
                                          title: toElement.value.name ?? "",
                                          date: toElement.value.createdAt
                                              .toString(),
                                          onDelete: () {
                                            logic.deleteDestionationModel(
                                                toElement.value);

                                            ///
                                          });
                                    }).toList()
                                  ],
                                ),
                              );
                            }),
                            SizedBox(
                              height: 30.h,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                BackWidget(idAssetMedia: false,)

              ],
            );
          })


      ),
    );
  }
}

class ChannelHeader extends StatelessWidget {
  final String imageUrl;

  ChannelHeader({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 27.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.sp),
              bottomRight: Radius.circular(25.sp),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl), //
              fit: BoxFit.cover,
            ),
          ),
          child: Opacity(opacity: 0),
        ),
        Container(
          height: 27.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.sp),
              bottomRight: Radius.circular(25.sp),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.66),
                Colors.black.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 25,
          child: SvgPicture.asset(AppIcon.imageIcon, color: Colors.white60),
        ),
      ],
    );
  }
}

class ChannelDetails extends StatelessWidget {
  final String name;
  final String description;

  const ChannelDetails({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Text(
            name,
            style: FontStyleApp.titleMedium.copyWith(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            description,
            style: FontStyleApp.bodyMedium.copyWith(
              color: AppColor.grayLightColor.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
