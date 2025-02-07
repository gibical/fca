import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

class DestionationEmptyState extends StatelessWidget {
  const DestionationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/all/icons/my_channel_9.svg"),
            SizedBox(
              height: 1.h ,
            ),
            Text(
              "my_channel_40".tr,
              style: TextStyle(
                  color: "#9C9CB8".toColor(), fontSize: 9.sp),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
