import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/widgets/appbar_btn.dart';

class ChannelsTitleWidget extends StatelessWidget {

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppbarBTNWidget(
              iconName: 'back1',
              onTap: () {
                Get.back();
              }),
          Text(
            title,
            style: TextStyle(
                fontSize: 11.sp, fontWeight: FontWeight.w600),
          ),
          Container(
            width: 10.w,
          )

        ],
      ),
    );
  }

  ChannelsTitleWidget(this.title);
}
