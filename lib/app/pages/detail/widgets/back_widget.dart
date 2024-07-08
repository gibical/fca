import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibical/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      child: SafeArea(
        child: Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: "000033".toColor()
          ),
          margin: EdgeInsets.all(16),
          child: MaterialButton(
              padding: EdgeInsets.all(8),
              onPressed: (){

                Get.back();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5000)
              ),
              child: Icon(Icons.arrow_back,color: Colors.white,)),

        ),
      ),
      alignment: Alignment.topLeft,
    );
  }
}
