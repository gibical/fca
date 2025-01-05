import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../flavors.dart';

class LoginButtonWidget extends StatelessWidget {

  Color backgroundColor;

  Widget placeHolder;
  Rx<bool> isloading;
  Function onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.h,
      height: 6.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(500)
      ),
      child: MaterialButton(
        onPressed: (){
          onpressed.call();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4500)
        ),
        child: Center(
          child:isloading.value?Lottie.asset("assets/${F.assetTitle}/json/Y8IBRQ38bK.json"):placeHolder,
        ),
        
      ),
    );
  }

  LoginButtonWidget({required this.backgroundColor, required this.placeHolder, required this.isloading, required this.onpressed});
}
