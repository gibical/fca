import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class ShareAccountBottomSheet extends StatefulWidget {
  ShareAccountLogic logic;

  ShareAccountBottomSheet(this.logic);

  @override
  State<ShareAccountBottomSheet> createState() =>
      _ShareAccountBottomSheetState();
}

class _ShareAccountBottomSheetState extends State<ShareAccountBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(4.w
      ),
      height: 25.h,
      decoration: BoxDecoration(
          color: AppColor.primaryLightColor,
          border: Border(
            left: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 1),
            bottom: BorderSide(
                color: Colors.grey.withOpacity(0.3),
                width: 0.4),
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("share_16".tr, style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 3.h,),
          Container(
            width: 100.w,
            height: 6.h,
            decoration: BoxDecoration(
                color: "2f2f3b".toColor(),
                borderRadius: BorderRadius.circular(10)
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)

              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.logic.signInWithGoogle();
              },
              child: Center(
                child: Text("share_17".tr, style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          Container(
            width: 100.w,
            height: 6.h,
            decoration: BoxDecoration(
                color: "2f2f3b".toColor(),
                borderRadius: BorderRadius.circular(10)
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)

              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                widget.logic.getTwitterAuth();
              },
              child: Obx(() {
                return Center(
                  child: widget.logic.isloadingTwitterApp.value ? Lottie.asset(
                      "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                      height: 10.h) : Text("share_17_1".tr, style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold
                  ),),
                );
              }),
            ),
          ),
          SizedBox(height: 1.5.h,),

        ],
      ),
    );
  }
}
