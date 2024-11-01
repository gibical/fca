import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_route.dart';

class BackWidget extends StatelessWidget {
  bool? idAssetMedia;
   BackWidget({super.key,this.idAssetMedia});

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

                if(idAssetMedia!=null&&idAssetMedia==true){
                  Get.offAllNamed(PageRoutes.WRAPPER);
                }else{
                  Get.back();
                }
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
