import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediaverse/app/common/app_config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../media_suit/logic.dart';

class GridPostView extends StatefulWidget {

  dynamic model;


  GridPostView(this.model);

  @override
  State<GridPostView> createState() => _GridPostViewState();

}

class _GridPostViewState extends State<GridPostView> {
  bool isSelected = false;
  void toggleSelection() {
    double videoLength =
    ( widget.model[
    'file']['info']['time'] ??
        0)
        .toDouble();
    print('=======================================================');
    print('=======================================================');
    print('=======================================================');
    print(videoLength);
    print(videoLength);
    print(videoLength);
    print('=======================================================');
    print('=======================================================');
    print('=======================================================');
    setState(() {
      isSelected = !isSelected;
    });

    if (isSelected) {

      Get.find<MediaSuitController>().addItemToTempList(
        widget.model['media']['name'].toString(),
        widget.model['file']['url'],
        videoLength,
        widget.model['file_id'].toString(),
        widget.model['media_type'],
      );
    } else {
      Get.find<MediaSuitController>().removeItemFromTempList(
        widget.model['file_id'].toString(),
      );
    }
    Get.find<MediaSuitController>().update();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap:Get.arguments == 'edit_screen'  ? toggleSelection
            :Get.arguments == 'onTapChannelManagement' ? (){

          Get.find<ShareAccountLogic>().setModelShareData(widget.model['media']['name'].toString() ,widget.model['file_id']);

          Get.back();

        }:(){
          _getRouteAndPushIt(widget.model['id']);
        },
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
                  child: Image.asset("assets/${F.assetTitle}/images/text_bg.png",fit: BoxFit.fill,),
                ),
                if(widget. model['media_type'] == 1)  SizedBox.expand(
                  child: Container(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        children: [
                       if(widget. model['media_type'] == 1)   Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                             widget. model['media']['name'],
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
                          if(widget. model['media_type']==1)    Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.    model['description']??" ",
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
                              Image.asset("assets/${F.assetTitle}/images/avatar.jpeg",width: 4.w,),
                              SizedBox(width: 3.w,),
                              Expanded(
                                child: Text(
                                  widget.   model['user_id'].toString(),
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
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                if(widget. model['media_type'] != 1)  SizedBox.expand(
                  child:   Container(
                    height: 27.h,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(

                          child: Padding(
                            padding: const EdgeInsets.only(right: 15 , bottom: 10),
                            child: SvgPicture.asset(_getIcon() , color: AppColor.grayLightColor.withOpacity(0.5)  , height: 1.8.h),
                          ),
                          alignment: Alignment.bottomRight,
                        ),
                        Positioned(
                            bottom: 10,
                            left: 20,
                            child: Text(widget.model['media']['name'])),
                      ],
                    ),
                    decoration:
                    (widget.model['thumbnails'].toString().length>3)?
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        image: DecorationImage(image: NetworkImage('${widget.model['thumbnails']['226x226']}' ) ,
                          fit: BoxFit.cover ,

                        )
                    ):BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        image: DecorationImage(image: AssetImage('assets/${F.assetTitle}/images/${_getBackground()}.jpeg' ) ,
                          fit: BoxFit.cover ,

                        )
                    ),
                  ),
                ),
                if (isSelected)
                  if (isSelected)
                    SizedBox.expand(
                      child: Container(color: Colors.black.withOpacity(0.5),),
                    ),
                if (isSelected)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.check_circle,
                      color: AppColor.primaryLightColor,
                      size: 20.sp,
                    ),
                  ),
              ],
            )
        ),
      ),
    );
  }

  String _getIcon() {
    switch(widget.model['media_type']){
      case 1:
        return AppIcon.textIcon;
      case 2:
        return AppIcon.imageIcon;
      case 3:
        return AppIcon.soundIcon;
      case 4:
        return AppIcon.videoIcon;
    }
    return AppIcon.videoIcon;
  }

  _getBackground() {
    //tum_video
    switch(widget.model['media_type']){
      case 1:
        return "tum_sound";
      case 2:
        return "tum_image";
      case 3:
        return "tum_sound";
      case 4:
        return "tum_video";
    }
    return "tum_image";
  }

  void _getRouteAndPushIt(model) {
    String route = "";
    print('_GridPostViewState._getRouteAndPushIt 1  = ${widget.model} -  ${widget.model['media_type']} - ${model}');
    switch(widget.model['media_type']){
      case 1:
        route = PageRoutes.DETAILTEXT;
        break;
      case 2:
        route = PageRoutes.DETAILIMAGE;
        break;
        case 3:
          route = PageRoutes.DETAILMUSIC;
          break;
          case 4:
            route = PageRoutes.DETAILVIDEO;
            break;
    }
     Get.toNamed(route, arguments: {'id': model});

  }
}
class GridPostView2 extends StatefulWidget {

  dynamic model;
  bool isSubscribation;


  GridPostView2(this.model,this.isSubscribation);

  @override
  State<GridPostView2> createState() => _GridPostView2State();

}

class _GridPostView2State extends State<GridPostView2> {
  bool isSelected = false;
  void toggleSelection() {
    if ( widget.isSubscribation&&!(widget.model['forkability_status'].toString().contains("2"))) {
      Constant.showMessege("This Asset Not Selectable");
      return;
    }
    setState(() {
      isSelected = !isSelected;
    });
    double videoLength =
    ( widget.model[
    'file']['info']['time'] ??
        0)
        .toDouble();
    print('=======================================================');
    print('=======================================================');
    print('=======================================================');
    print(videoLength);
    print(videoLength);
    print(videoLength);
    print('=======================================================');
    print('=======================================================');
    print('=======================================================');
    if (isSelected) {

      Get.find<MediaSuitController>().addItemToTempList(
        widget.model['media']['name'].toString(),
        widget.model['file']['url'],
        videoLength,
        widget.model['file_id'].toString(),
        widget.model['media_type'],
      );
    } else {
      Get.find<MediaSuitController>().removeItemFromTempList(
        widget.model['file_id'].toString(),
      );
    }
    Get.find<MediaSuitController>().update();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    String processTitle(String title) {
      String processedTitle = title.length > 8
          ? '${title.substring(0, 8)} ...'
          : title;

      return processedTitle;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(


        onTap:

        (){
      if(Get.arguments == 'edit_screen'){
        toggleSelection();
      }
//       if(Get.arguments == 'edit_screen'){
//         if (widget.model['media_type'].toString().contains("4")) {
//
//         Get.find<ShareAccountLogic>().setModelShareData(widget.model['media']['name'].toString() ,widget.model['file_id']);
//         }else{
//           Constant.showMessege("Please Select Video ");
//         }
// //
//         Get.back();
//       }
      else if(Get.arguments == 'onTapNewProgram'){
        if (widget.model['media_type'].toString().contains("4")) {

//
          Get.back(result: [jsonEncode(widget.model)]);
        }else{
          Constant.showMessege("Please Select Video ");
        }
      }else{
        _getRouteAndPushIt(widget.model['id']);
      }

    }
    ,
        child: Container(
            width: 45.w,
            height: 45.w,

            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox.expand(
                  child: Image.asset("assets/${F.assetTitle}/images/text_bg.png",fit: BoxFit.fill,),
                ),
                if(widget. model['media_type'] == 1)  SizedBox.expand(
                  child: Container(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        children: [
                       if(widget. model['media_type'] == 1)   Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                             widget. model['media']['name'],
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
                          if(widget. model['media_type']==1)    Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.    model['description']??" ",
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

                              Image.asset("assets/${F.assetTitle}/images/avatar.jpeg",width: 4.w,),
                              SizedBox(width: 3.w,),
                              Text(
                                widget.   model['views_count'].toString(),
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
                ),
                if(widget. model['media_type'] != 1)  SizedBox.expand(
                  child:   Container(
                    height: 27.h,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(

                          child: Padding(
                            padding: const EdgeInsets.only(right: 15 , bottom: 10),
                            child: SvgPicture.asset(_getIcon() , color: AppColor.grayLightColor.withOpacity(0.5)  , height: 1.8.h),
                          ),
                          alignment: Alignment.bottomRight,
                        ),
                        Positioned(
                            bottom: 10,
                            left: 20,
                            child: 
                            Text(processTitle(widget.model['media']['name']))
                          //  Text(widget.model['media']['name'])
                        ),
                      ],
                    ),
                    decoration:
                    (widget.model['thumbnails'].toString().length>3)?
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        image: DecorationImage(image: NetworkImage('${widget.model['thumbnails']['226x226']}' ) ,
                          fit: BoxFit.cover ,

                        )
                    ):BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        image: DecorationImage(image: AssetImage('assets/${F.assetTitle}/images/${_getBackground()}.jpeg' ) ,
                          fit: BoxFit.cover ,
                        )
                    ),
                  ),
                ),
                if (isSelected)
                  SizedBox.expand(
                    child: Container(color: Colors.black.withOpacity(0.5),),
                  ),
                if (isSelected)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      Icons.check_circle,
                      color: AppColor.primaryLightColor,
                      size: 20.sp,
                    ),
                  ),
              ],
            )
        ),
      ),
    );
  }

  String _getIcon() {
    switch(widget.model['media_type']){
      case 1:
        return AppIcon.textIcon;
      case 2:
        return AppIcon.imageIcon;
      case 3:
        return AppIcon.soundIcon;
      case 4:
        return AppIcon.videoIcon;
    }
    return AppIcon.videoIcon;
  }

  _getBackground() {
    //tum_video
    switch(widget.model['media_type']){
      case 1:
        return "tum_sound";
      case 2:
        return "tum_image";
      case 3:
        return "tum_sound";
      case 4:
        return "tum_video";
    }
    return "tum_image";
  }

  void _getRouteAndPushIt(model) {
    String route = "";
    print('_GridPostViewState._getRouteAndPushIt 2  = ${widget.model} -  ${widget.model['media_type']} - ${model}');
    switch(widget.model['media_type']){
      case 1:
        route = PageRoutes.DETAILTEXT;
        break;
      case 2:
        route = PageRoutes.DETAILIMAGE;
        break;
        case 3:
          route = PageRoutes.DETAILMUSIC;
          break;
          case 4:
            route = PageRoutes.DETAILVIDEO;
            break;
    }
     Get.toNamed(route, arguments: {'id': model});

  }
}
