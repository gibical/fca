

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_icon.dart';

class CustomAppBarVideoAndImageDetailWidget extends StatelessWidget {
  const CustomAppBarVideoAndImageDetailWidget({
    super.key,
    required this.selectedItem, required this.isVideo,
  });

  final  selectedItem;
  final bool isVideo;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: 27.h,
            width: double.infinity,
            child: Transform.scale(
                scale: 0.15,
                child:isVideo ? SvgPicture.asset(AppIcon.playIcon) : Container()),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp) , bottomRight: Radius.circular(25.sp)),
              image: DecorationImage(image: NetworkImage(selectedItem['asset']['thumbnails']['336x366']), fit: BoxFit.cover ,),

            ),
          ),
          Container(
            height: 27.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp) , bottomRight: Radius.circular(25.sp)),
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
              child: SvgPicture.asset(isVideo ? AppIcon.videoIcon : AppIcon.imageIcon , color: Colors.white60,))
        ],
      ),
    );
  }
}