import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../flavors.dart';

class LoginButtonWidget extends StatelessWidget {

  Color backgroundColor;

  Widget placeHolder;
  Rx<bool> isloading;
  Function onpressed;
  Function? onFocusGained;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: (){
        try {
          onFocusGained!.call();
        }  catch (e) {
          // TODO
        }
      },
      child: Container(
        width: 100.h,
        height: 6.h,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(500)
        ),
        child: MaterialButton(
          onPressed: () {
            onpressed.call();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4500)
          ),
          child: Obx(() {
            return Center(
              child: isloading.value ? Lottie.asset(
                  "assets/${F.assetTitle}/json/Y8IBRQ38bK.json") : placeHolder,
            );
          }),
      
        ),
      ),
    );
  }

  LoginButtonWidget(
      {required this.backgroundColor, required this.placeHolder, required this.isloading, required this.onpressed,this.onFocusGained});
}
