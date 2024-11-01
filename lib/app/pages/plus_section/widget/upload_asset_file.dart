import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus_section/logic.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class UploadAssetPage extends StatefulWidget {
  const UploadAssetPage({super.key});

  @override
  State<UploadAssetPage> createState() => _UploadAssetPageState();
}

class _UploadAssetPageState extends State<UploadAssetPage> {

  PlusSectionLogic logic = Get.arguments[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.uploadFileWithDio();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlusSectionLogic>(
        init: logic,
        builder: (logic) {
      return WillPopScope(
        onWillPop: ()async=>true,
        child: Scaffold(
          backgroundColor: "#02073D".toColor(),

          body: SafeArea(
            child: Container(
              height: 100.h,
              child: Stack(
                children: [
                  Align(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("plus_36".tr, style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),),

                        SizedBox(height: 4.h,),
                        Lottie.asset("assets/json/upload.json",),

                        SizedBox(height: 4.h,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            margin: EdgeInsets.all(16),
                            duration: Duration(
                                milliseconds: 400
                            ),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * (logic.uploadedCount / 100),
                            height: 6,
                            decoration: BoxDecoration(
                                color: "#5A7CF6".toColor(),
                              borderRadius: BorderRadius.circular(500)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
