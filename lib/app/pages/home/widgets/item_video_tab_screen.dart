import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_icon.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/font_style.dart';
import 'package:sizer/sizer.dart';

Widget ItemVideoTabScreen(dynamic model){
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7 ,vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 27.h,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(AppIcon.videoIcon),
                Positioned(
                    bottom: 10,
                    left: 20,
                    child: Text(model['name'])),
              ],
            ),
            decoration:
            (model['thumbnails'].toString().length>3)?
            BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                image: DecorationImage(image: NetworkImage('${model['thumbnails']['336x366']}' ) ,
                  fit: BoxFit.cover ,

                )
            ):BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                image: DecorationImage(image: AssetImage('assets/images/tum_video.jpeg' ) ,
                  fit: BoxFit.cover ,

                )
            ),
          ),
          if(model['description']!=null)SizedBox(height: 1.h,),
          Text(model['description']??"", style: FontStyleApp.bodyLarge.copyWith(
            color: AppColor.grayLightColor.withOpacity(0.6),

          ),),
          if(model['description']!=null)SizedBox(height: 2.3.h,),
          Row(
            children: [
              Image.asset("assets/images/avatar.jpeg",width: 4.w,),
              SizedBox(width: 3.w,),
              Text(model['user']['username'],style: TextStyle(fontSize: 8.sp,
                color: Color(0xFF666680),

              ),),

              Spacer(),
              Text('8:15' , style: FontStyleApp.bodySmall.copyWith(
                color: AppColor.grayLightColor.withOpacity(0.6),

              ),),
              SizedBox(width: 2.w,),
            ],
          )

        ],
      ),
    ),
  );
}