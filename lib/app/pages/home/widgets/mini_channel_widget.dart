import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/FromJsonGetChannelsShow.dart';

class MiniChannelWidget extends StatelessWidget {

  bool _isPermiuim = true;
  double? height;

  ChannelsModel model;
  MiniChannelWidget({this.height,required this.model});

  @override
  Widget build(BuildContext context) {
    print('MiniChannelWidget.build = ${model.thumbnails}');
    return Container(


      width: 100.w,
      child: Row(

        children: [
          Container(
            width: 20.w,
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
                      child: model.thumbnails.toString().length>10? CachedNetworkImage(imageUrl: model.thumbnails['226x226'],fit: BoxFit.cover,):Image.asset("assets/${F.assetTitle}/images/mainLogo.png"),
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
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${ model.name}",style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Expanded(
                  child: Text(model.description??"",
                    style: TextStyle(
                    fontWeight: FontWeight.w300,color: "#9C9CB8".toColor()
                  ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
class ShimmerMiniChannelWidget extends StatelessWidget {

  bool _isPermiuim = true;
  double? height;

  ChannelsModel model;
  MiniChannelWidget({this.height,required this.model});

  @override
  Widget build(BuildContext context) {
    print('MiniChannelWidget.build = ${model.thumbnails}');
    return Container(


      width: 100.w,
      child: Row(

        children: [
          Container(
            width: 20.w,
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
                      child: model.thumbnails.toString().length>10? CachedNetworkImage(imageUrl: model.thumbnails['226x226'],fit: BoxFit.cover,):Image.asset("assets/${F.assetTitle}/images/mainLogo.png"),
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
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${ model.name}",style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Expanded(
                  child: Text(model.description??"",
                    style: TextStyle(
                    fontWeight: FontWeight.w300,color: "#9C9CB8".toColor()
                  ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
