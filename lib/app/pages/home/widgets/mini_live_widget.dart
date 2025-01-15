import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/FromJsonGetChannelsShow.dart';
import '../../../common/app_color.dart';

class MiniLiveWidget extends StatelessWidget {
  ChannelsModel model;

  MiniLiveWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 15.w+1.5.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5000),
                    child: Container(
                      width: 15.w,
                      height: 15.w,
                      child: model.thumbnails.toString().length>10?CachedNetworkImage(imageUrl: model.thumbnails['226x226'],fit: BoxFit.cover,
                        errorWidget: (s,p,q){
                          return Container(
                            color: AppColor.backgroundColor,

                          );
                        },):Image.asset("assets/${F.assetTitle}/images/mainLogo.png"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(

                    margin: EdgeInsets.only(
                      top: (15.w-(1.5.h/2))
                    ),
                    width: 7.w,
                    height: 1.5.h,
                    decoration: BoxDecoration(
                      color: "B71D18".toColor(),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child: Center(child: Text("Live",style: TextStyle(fontSize: 6.sp,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
          ),
          Text("${model.name}",maxLines: 1,style: TextStyle(fontSize: 8.sp),)
        ],
      ),
    );
  }
}
class ShimmerMiniLiveWidget extends StatelessWidget {
  String mainColor = "00003e";
  String subMainColor = "000056";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 15.w+1.5.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5000),
                    child: Shimmer.fromColors(
                      baseColor: mainColor.toColor(),
                      highlightColor: subMainColor.toColor(),
                      child: Container(
                        width: 15.w,
                        height: 15.w,
                        child: Image.asset("assets/${F.assetTitle}/images/mainLogo.png"),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(

                    margin: EdgeInsets.only(
                      top: (15.w-(1.5.h/2))
                    ),
                    width: 7.w,
                    height: 1.5.h,
                    decoration: BoxDecoration(
                      color: "B71D18".toColor(),
                      borderRadius: BorderRadius.circular(3)
                    ),
                    child: Center(child: Text("Live",style: TextStyle(fontSize: 6.sp,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
