import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:sizer/sizer.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({super.key, required this.elementAt});
  dynamic elementAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
            width: 40.w,
            height: 20.h,
            decoration: BoxDecoration(
                color: theme.onBackground.withOpacity(0.1),
                border: Border.symmetric(
                    horizontal: BorderSide(
                  width: 0.9,
                  color: theme.onBackground.withOpacity(
                    0.2,
                  ),
                )),
                borderRadius: BorderRadius.all(Radius.circular(20.sp))),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox.expand(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.sp),
                    child: (elementAt['asset']['thumbnails'].toString().length >
                            3)
                        ? Image.network(
                            "${elementAt['asset']['thumbnails']['336x366']}",
                            fit: BoxFit.cover)
                        : Image.asset("assets/images/tum_sound.jpeg",
                            fit: BoxFit.cover),
                  ),
                ),
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                          ])),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 10),
                  child: SvgPicture.asset("assets/icons/picure_icon.svg",
                      color: AppColor.grayLightColor.withOpacity(0.5),
                      height: 1.8.h),
                )
              ],
            )),
        Container(
          width: 40.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    elementAt['name'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF666680),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Row(
                children: [
                  Image.asset(
                    "assets/images/avatar.jpeg",
                    width: 4.w,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    elementAt['asset']['user']['username'],
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Color(0xFF666680),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
