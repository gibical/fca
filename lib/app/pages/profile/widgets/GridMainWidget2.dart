import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/pages/media_suit/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/app_route.dart';
import '../../share_account/logic.dart';

class GridPostViewForDetails extends StatefulWidget {

  dynamic model;


  GridPostViewForDetails(this.model);

  @override
  State<GridPostViewForDetails> createState() => _GridPostViewForDetailsState();

}

class _GridPostViewForDetailsState extends State<GridPostViewForDetails> {

  bool isSelected = false;
  void toggleSelection() {
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
        widget.model['name'].toString(),
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
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;




    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap:Get.arguments == 'edit_screen' ? toggleSelection:Get.arguments == 'onTapChannelManagement' ? (){
          Get.find<ShareAccountLogic>().setModelShareData(widget.model['name'].toString() ,widget.model['file_id']);

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
                              Text(
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
                            child: Text(widget.model['name'])),
                      ],
                    ),
                    decoration:
                    (widget.model['thumbnails'].toString().length>3)?
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        image: DecorationImage(image: NetworkImage('${widget.model['thumbnails']['origin']}' ) ,
                          fit: BoxFit.cover ,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.55), BlendMode.hardLight),
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
    print('_GridPostViewState._getRouteAndPushIt 3  = ${widget.model} -  ${widget.model['media_type']} - ${model}');
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
