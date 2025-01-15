import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:sizer/sizer.dart';

class HomeImageWidget extends StatelessWidget {
String imageUrl;

HomeImageWidget(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl,fit: BoxFit.cover,
    errorWidget: (s,p,q){
      return Container(
        color: AppColor.backgroundColor,
        child: Center(
          child: Text("home_21".tr,style: TextStyle(color: CupertinoColors.white,fontSize: 6.sp),),
        ),
      );
    },);
  }
}
