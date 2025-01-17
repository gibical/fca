import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/home/widgets/home_image_widget.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';

class AssetMiniTabWidget extends StatelessWidget {
  ContentModel  model;

  AssetMiniTabWidget({super.key ,required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 10.h,

      margin: EdgeInsets.fromLTRB(16, 1.h, 16, 0),
      child: Row(
        children: [
          Container(
            width: 8.h,
            height: 8.h,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: HomeImageWidget(model.thumbnails!.x226??""),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    child: SvgPicture.asset("assets/all/icons/mini_icon_${_getNameByPostType()}.svg",height: 1.5.h,),
                  ),
                )

              ],
            ),
          ),
          SizedBox(width: 3.w,),
          Expanded(child: Container(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(model.name??"",style: TextStyle(fontWeight: FontWeight.bold),)),
                Expanded(
                    flex: 2,child: Text(model.description??"",style: TextStyle(fontSize:9.sp,fontWeight: FontWeight.w300,color: "#9C9CB8".toColor()),)),
                Expanded(
                    flex: 1,child: Text(model.user!.username??"",style: TextStyle(fontSize:9.sp,fontWeight: FontWeight.w300,color: "#9C9CB8".toColor()),)),
              ],
            ),
          ))
        ],
      ),
    );
  }

  _getNameByPostType() {
    switch(model.postType){

      case PostType.image:
        return "image";
      case PostType.video:
        return "video";

      case PostType.audio:
        return "audio";
      case PostType.text:
        return "text";
      case PostType.channel:
        return "channel";
    }
  }
}
