import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import 'home_image_widget.dart';

class MiniImageWidget extends StatelessWidget {

  double? height;

  ContentModel model;
  MiniImageWidget({this.height,required this.model});
  @override
  Widget build(BuildContext context) {
    bool _isPermiuim = model.licenseType==2 ;
    bool _isSilver = model.licenseType==3 ;

    return           Container(
      margin: EdgeInsets.only(
          right: 5
      ),
      decoration: BoxDecoration(

      ),
      child: MaterialButton(
        onPressed: (){
          Get.toNamed(PageRoutes.DETAILIMAGE, arguments: {'id': model.id});

        },
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                SizedBox.expand(child:HomeImageWidget(model.thumbnails!.x1080.toString())),
                if(_isPermiuim) Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    child: SvgPicture.asset("assets/all/icons/mini_icon_permiuim.svg"),
                  ),
                ),
                if(_isSilver) Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    child: SvgPicture.asset("assets/all/icons/mini_icon_permiuim.svg",color: "c0c0c0".toColor(),),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.all(2.w),
                    child: SvgPicture.asset("assets/all/icons/mini_icon_image.svg"),
                  ),
                ),

              ],
            )),
      ),
    )
    ;
  }
}
class ShimmirMiniImageWidget extends StatelessWidget {
  String mainColor = "00003e";
  String subMainColor = "000056";
  bool _isPermiuim = true;
  @override
  Widget build(BuildContext context) {
    return Container(


      margin: EdgeInsets.only(
          right: 5
      ),
      decoration: BoxDecoration(

      ),
      child: Shimmer.fromColors(
        baseColor: mainColor.toColor(),
        highlightColor: subMainColor.toColor(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [

                SizedBox.expand(
                  child: Container(
                    color: AppColor.backgroundColor,
                  ),
                )

              ],
            )),
      ),
    );
  }
}
