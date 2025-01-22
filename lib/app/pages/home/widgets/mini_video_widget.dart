import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../gen/model/json/v2/FromJsonGetContentFromExplore.dart';
import '../../../common/app_route.dart';
import 'home_image_widget.dart';

class MiniVideoWidget extends StatelessWidget {


  double? height;
  bool? selectedAsset;

  ContentModel model;
  MiniVideoWidget({this.height,required this.model,this.selectedAsset});

  @override
  Widget build(BuildContext context) {
    bool _isPermiuim = model.licenseType!=0 ;
    return Container(


      child: MaterialButton(
        onPressed: (){
          Get.toNamed(PageRoutes.DETAILVIDEO, arguments: {'id': model.id});

        },
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(

          children: [

            Container(
              height:height?? 45.w,
              margin: EdgeInsets.only(
                right: 5
              ),
              decoration: BoxDecoration(

              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      SizedBox.expand(child:HomeImageWidget(model.thumbnails!.x226.toString())),
                     if(selectedAsset!=null&&selectedAsset==true) SizedBox.expand(child:Container(color: Colors.black.withOpacity(0.6),)),
                     if(selectedAsset!=null&&selectedAsset==true) Align(child:SvgPicture.asset("assets/all/icons/check-circle.svg") ,),
                     if(_isPermiuim) Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          child: SvgPicture.asset("assets/all/icons/mini_icon_permiuim.svg"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          child: SvgPicture.asset("assets/all/icons/mini_icon_video.svg"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          child: Text(
                            "8:24:02",
                            style: TextStyle(
                              color: Colors.white,fontSize: 8.sp
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 1.h,),
            Row(

              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Container(
                        width: 7.w,
                        height: 7.w,
                        child: Image.network(model.user!.imageUrl??"",fit: BoxFit.cover,))),
                SizedBox(width: 2.w,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${model.name}",style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                    Text("${model.user!.username}",style: TextStyle(fontWeight: FontWeight.w300,color: "#9C9CB8".toColor(),fontSize: 7.sp),maxLines: 1,overflow: TextOverflow.ellipsis),
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
class ShimmerMiniVideoWidget extends StatelessWidget {

  String mainColor = "00003e";
  String subMainColor = "000056";
  bool _isPermiuim = true;
  double? height;

  ShimmerMiniVideoWidget({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(


      child: Column(

        children: [


          Container(
            height:height?? 32.w,
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
                      SizedBox.expand(child: Image.network("https://placehold.co/600x400/png",fit: BoxFit.cover,)),
                     if(_isPermiuim) Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          child: SvgPicture.asset("assets/all/icons/mini_icon_permiuim.svg"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          child: SvgPicture.asset("assets/all/icons/mini_icon_video.svg"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          child: Text(
                            "8:24:02",
                            style: TextStyle(
                              color: Colors.white,fontSize: 8.sp
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(height: 1.h,),
          Row(

            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Container(
                      width: 7.w,
                      height: 7.w,
                      child: Shimmer.fromColors(
                          baseColor: mainColor.toColor(),
                          highlightColor: subMainColor.toColor(),child: Image.network("https://placehold.co/600x400/png",fit: BoxFit.cover,)))),
              SizedBox(width: 2.w,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                      baseColor: mainColor.toColor(),
                      highlightColor: subMainColor.toColor(),child: Text("Title",style: TextStyle(fontWeight: FontWeight.bold),)),
                  Shimmer.fromColors(
                      baseColor: mainColor.toColor(),
                      highlightColor: subMainColor.toColor(),child: Text("username",style: TextStyle(fontWeight: FontWeight.w300,color: "#9C9CB8".toColor(),fontSize: 7.sp),)),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
