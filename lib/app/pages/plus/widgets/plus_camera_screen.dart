import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/logic.dart';
import 'package:mediaverse/app/pages/plus/widgets/perimisson_bottom_sheet.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/appbar_btn.dart';


class PlusCameraScreen extends StatefulWidget {
  bool isImage;

  PlusCameraScreen(this.isImage);

  @override
  State<PlusCameraScreen> createState() => _PlusPageState();
}

class _PlusPageState extends State<PlusCameraScreen> {




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String tag =  "new-${widget.isImage?"image":"video"}-${DateTime.now()}";
    final PlusLogic logic = Get.put(PlusLogic(widget.isImage?PostType.image:PostType.video,tag),tag: tag);
    logic.initCamera();

    return GetBuilder<PlusLogic>(
        init: logic,
        tag: tag,
        builder: (logic) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: Container(
              width: 100.w,
              child: Column(
                children: [

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: "151311".toColor(),

                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 3.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppbarBTNWidgetAll(
                              iconName: 'remove', color: Colors.transparent,
                              onTap: () {
                                Get.back();
                              }),
                          Column(

                            children: [
                              Text(
                                "add_asset_1_${(!widget.isImage)?"0":"1"}".tr,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2.h,),
                              Obx(() {
                                return Visibility(
                                  visible: logic.isRecordingTimeVisible.value,
                                  child: Text(
                                    logic.recordingTime.value,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              }),
                            ],
                            mainAxisSize: MainAxisSize.min,
                          ),
                          AppbarBTNWidgetAll(
                              iconName: 'setting', color: Colors.transparent,
                              onTap: () {
                                Get.back();
                              }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FocusDetector(
                        onFocusGained: () {},
                        onFocusLost: () {
                          logic.controller == null;
                        },
                        child:(logic.controller==null)?Container(): CameraPreview(logic.controller!,child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: "151311".toColor(),

                                ),
                                child: Stack(
                                  children: [
                                    Align(

                                      child: Container(

                                        child: Row(

                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(

                                              child: GestureDetector(
                                                onTap: (){
                                                  logic.selectFileFromGallery(widget.isImage);
                                                },
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Image.asset(
                                                      "assets/all/images/tumnial.png"),
                                                ),
                                              ),
                                              height: 4.h,
                                            ),
                                            Container(
                                              height: 10.h,
                                              width: 10.h,
                                              child: MaterialButton(
                                                padding: EdgeInsets.all(2.w),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(500)
                                                ),
                                                onPressed: (){
                                                  if (!widget.isImage) {
                                                    logic.startOrStopMediaRecording();
                                                  }else{
                                                    logic.takePicture();
                                                  }
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/all/icons/Shutter_${widget.isImage?"1":"0"}.svg",
                                                height: 10.h,width: 10.h,),
                                              ),
                                            ),
                                            Container(
                                              height: 5.h,
                                              child: Image.asset(
                                                  "assets/all/images/camera_switch.png"),
                                            ),

                                          ],
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 6.h
                                        ),
                                      ),
                                      alignment: Alignment.bottomCenter,
                                    )
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),)),
                  ),


                ],
              ),
            ),
          );
        });
  }
}
