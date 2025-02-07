import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/plus/logic.dart';
import 'package:mediaverse/gen/model/enums/post_type_enum.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../channel/v2/widgets/channels_title_widget.dart';

class PlusAudioRecordingPage extends StatefulWidget {
  const PlusAudioRecordingPage({super.key});

  @override
  State<PlusAudioRecordingPage> createState() => _PlusAudioRecordingPageState();
}

class _PlusAudioRecordingPageState extends State<PlusAudioRecordingPage> {
  String tag =  "new-audio-${DateTime.now()}";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PlusLogic logic = Get.put(PlusLogic(PostType.audio,tag),tag:tag );
    logic.initAudio();

    return GetBuilder<PlusLogic>(
        init: logic,
        tag: tag,
        builder: (logic) {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: SafeArea(
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChannelsTitleWidget("add_asset_20".tr),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                logic.getFormattedRecordingDuration(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: logic.recordingDuration.inSeconds > 0
                                        ? Colors.white
                                        : "#9C9CB8".toColor()),

                              ),
                              SizedBox(height: 3.h,),
                              Container(
                                width: 50.w,
                                height: 50.w,
                                child: Stack(children: [
                                  SizedBox.expand(
                                    child: SvgPicture.asset(
                                        "assets/all/icons/add_audio_btn.svg"),
                                  ),
                                  Align(
                                    child: SvgPicture.asset(
                                        "assets/all/icons/${logic.isRecording
                                            ? "pause"
                                            : "mic"}.svg"
                                    ),
                                  ),
                                  Align(
                                    child: Container(
                                        width: 30.w,
                                        height: 30.w,
                                        child: MaterialButton(onPressed: () {
                                          logic.startOrStopRecording();
                                        },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(500)
                                          ),
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        )
                                    ),
                                  )
                                ],),
                              ),
                              SizedBox(height: 3.h,),

                              Text("add_asset_21".tr, style: TextStyle(
                                  color: "#9C9CB8".toColor(),
                                  fontSize: 10.sp
                              ),),
                              SizedBox(height: 2.h,),

                              Obx(() {
                                return Opacity(
                                  opacity: logic.filePath.toString().length>10?0.3:1,
                                  child: Container(
                                    width: logic.isShowFileFromPath.value
                                        ? 80.w
                                        : 30.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                        color: "0f0f26".toColor(),
                                        borderRadius: BorderRadius.circular(500)
                                    ),
                                    child: MaterialButton(onPressed: () {
                                      logic.pickFileWithPermissionCheck();
                                    }, shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(500)
                                    ), child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/all/icons/upload.svg"),
                                        SizedBox(width: 1.5.w,),
                                        Expanded(
                                          child: Text(
                                            logic.isShowFileFromPath.value?
                                                logic.selectedFile!.path.split("/").last
                                                :"add_asset_22".tr,maxLines: 1,overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),),
                                        )
                                      ],
                                    ),),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          height: 6.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color:
                              (logic.uploadedFilePath.length>5||logic.selectedFile!=null)?
                              AppColor.primaryLightColor:
                                  "9c9cb8".toColor()
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            onPressed: () {
                              if (!logic.isRecording) {
                                logic.goToMainForm();
                              }
                            },
                            child: Center(
                              child: Text("add_asset_23".tr),
                            ),
                          ),
                        )
                      ]),
                )),
          );
        });
  }
}
