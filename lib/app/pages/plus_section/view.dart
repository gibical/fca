import 'dart:math';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus_section/widget/media_picker.dart';
import 'package:sizer/sizer.dart';

import 'logic.dart';

class PlusSectionPage extends StatefulWidget {
  @override
  State<PlusSectionPage> createState() => _PlusSectionPageState();
}

class _PlusSectionPageState extends State<PlusSectionPage> {
  final logic = Get.put(PlusSectionLogic());

  final state = Get
      .find<PlusSectionLogic>()
      .state;

  @override
  void initState() {
    super.initState();

  }
  late List<CameraDescription> _cameras;

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlusSectionLogic>(
        init: logic,
        builder: (logic) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: logic.getMainWidget(),
                ),



                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 120,
                      width: 100.w,

                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              SizedBox.expand(child: Image.asset(
                                  "assets/${F.assetTitle}/images/plus_base.png",fit: BoxFit.fitWidth,)),

                              Align(
                                alignment: Alignment.topCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    logic.middleClick();
                                    print(
                                        '_PlusSectionPageState.build');
                                  },

                                  onLongPressStart: (l){
                                    if(logic.mediaMode==MediaMode.image){
                                      logic.startVideoRecording();
                                    }
                                  },
                                  onLongPressEnd: (h){
                                    if(logic.mediaMode==MediaMode.image){
                                      logic.stopVideoRecording();
                                    }
                                  },
                                  child: Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: "#030340".toColor(),
                                          shape: BoxShape.circle
                                      ),
                                      margin: EdgeInsets.only(top: 15),
                                      child: Center(child: SvgPicture.asset(
                                          "assets/${F.assetTitle}/images/plus_${logic
                                              .getTopIcon()}.svg"))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                    margin: EdgeInsets.only(

                                        left: 35, bottom: 10),
                                    child: MaterialButton(
                                        onPressed: () {
                                          logic.getLeftClick();
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                6000)
                                        ),


                                        child: Center(child: SvgPicture.asset(
                                            "assets/${F.assetTitle}/images/plus_${logic
                                                .getLeftIcon()}.svg")))),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle
                                    ),
                                    margin: EdgeInsets.only(
                                        right: 35, bottom: 10),
                                    child: MaterialButton(
                                        onPressed: () {
                                          logic.getRightClick();
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                6000)
                                        ),


                                        child: Center(child: SvgPicture.asset(
                                            "assets/${F.assetTitle}/images/plus_${logic
                                                .getRightIcon()}.svg")))),
                              ),
                            ],
                          ))),

                )
              ],
            ),
          ),
        ),
      );
    });
  }

}
