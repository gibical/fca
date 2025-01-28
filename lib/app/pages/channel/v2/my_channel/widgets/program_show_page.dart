import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/add_program_bottonsheet.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/program_schedule_bottomSheet.dart';
import 'package:mediaverse/app/pages/home/widgets/home_image_widget.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/widgets/appbar_btn.dart';
import '../../../../stream/view.dart';
import '../logic.dart';
import 'delete_programs_dialog.dart';

class ProgramShowPage extends StatefulWidget {
  Programs programs;

  ProgramShowPage(this.programs);

  @override
  State<ProgramShowPage> createState() => _ProgramShowPageState();
}

class _ProgramShowPageState extends State<ProgramShowPage> {
  MyChannelController logic = Get.find<MyChannelController>();


  TextEditingController _scheduleEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('_ProgramShowPageState.initState= ${widget.programs.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .viewPadding
                    .top + 4.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarBTNWidgetAll(
                      iconName: 'remove',
                      onTap: () {
                        Get.back();
                      }),
                  Text(
                    widget.programs.name ?? "",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  AppbarBTNWidget(
                      iconName: 'menu', //
                      onTap: () {
                        true
                            ? showMenu(
                          color: '#0F0F26'.toColor(),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12.sp)),
                          context: context,
                          position:
                          RelativeRect.fromLTRB(100, 80, 0, 0),
                          items: [
                            PopupMenuItem(
                              value: 1,
                              onTap: () {

                                Get.bottomSheet(AddProgramBottonsheet(true,programModel: widget.programs,),isScrollControlled: true);
                              },
                              child: SizedBox(
                                width: 130,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/mediaverse/icons/edit.svg'),
                                    Text('my_channel_20'.tr),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              onTap: () async{
                                await Get.dialog(DeleteProgramsDialog(widget.programs));

                                Get.back();
                              },
                              child: SizedBox(
                                width: 130,
                                child: Row(
                                  children: [
                                    Obx(() {
                                      var s = false.obs;
                                      if (s.value) {
                                        return Transform.scale(
                                          scale: 0.5,
                                          child:
                                          CircularProgressIndicator(
                                            color: AppColor.primaryLightColor,
                                            backgroundColor: AppColor
                                                .primaryLightColor
                                                .withOpacity(0.2),
                                          ),
                                        );
                                      }
                                      return SvgPicture.asset(
                                          'assets/mediaverse/icons/delete.svg');
                                    }),
                                    Text('my_channel_21'.tr),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ).then((value) {
                          if (value != null) {
                            print('$value');
                          }
                        })
                            : showMenu(
                          color: '#0F0F26'.toColor(),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12.sp)),
                          context: context,
                          position:
                          RelativeRect.fromLTRB(100, 80, 0, 0),
                          items: [
                            PopupMenuItem(
                              value: 1,
                              onTap: () {},
                              child: SizedBox(
                                width: 130,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/mediaverse/icons/report.svg',
                                    ),
                                    Text('Report'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ).then((value) {
                          if (value != null) {
                            print('$value');
                          }
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Visibility(
                visible: widget.programs.source.toString().contains("file"),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset("assets/all/images/tumnial.png"),
                      ),
                    
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("A Journey Through the Wild",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                        MaterialButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "my_channel_18".tr, style: TextStyle(color: AppColor
                                  .primaryLightColor,),),
                              SizedBox(width: 2.w,),
                              SvgPicture.asset("assets/all/icons/maximize.svg")
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
//
                Get.bottomSheet(ProgramScheduleBottomsheet(widget.programs),isScrollControlled: true);
                },
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    width: 100.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: "0f0f26".toColor(),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _scheduleEditingController.text.length > 4
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _scheduleEditingController.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: "#9C9CB8".toColor()),
                        ),
                        SvgPicture.asset(
                            "assets/all/icons/add_channel_3.svg",
                            color: "#9C9CB8".toColor())
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Schedule".tr,
                          style: TextStyle(color: "#9C9CB8".toColor()),
                        ),
                        SvgPicture.asset(
                            "assets/all/icons/add_channel_3.svg",
                            color: "#9C9CB8".toColor())
                      ],
                    )),
              ),
              Visibility(
                visible: widget.programs.source.toString().contains("rtmp"),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),

                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("my_channel_23".tr,style: TextStyle(color: "#9C9CB8".toColor(),fontSize: 10.sp),)),
                    SizedBox(
                      height: 1.h,
                    ),
                    MaterialButton(
                      onPressed: () {
                    //
                         Clipboard.setData(ClipboardData(text: "${widget.programs.streamUrl}"));
                      },
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: 100.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: "0f0f26".toColor(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${widget.programs.streamUrl}".tr,
                                  style: TextStyle(color: "#9C9CB8".toColor()),
                                ),
                              ),
                              SvgPicture.asset(
                                  "assets/all/icons/copy.svg",
                                  color: "#9C9CB8".toColor())
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MaterialButton(
                      onPressed: () {
                    //
                         Clipboard.setData(ClipboardData(text: "${widget.programs.streamKey}"));
                      },
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: 100.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                              color: "0f0f26".toColor(),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${widget.programs.streamKey}".tr,
                                  style: TextStyle(color: "#9C9CB8".toColor()),
                                ),
                              ),
                              SvgPicture.asset(
                                  "assets/all/icons/copy.svg",
                                  color: "#9C9CB8".toColor())
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: 100.w,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: "#0F0F26".toColor(),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              "my_channel_24".tr,
                              style: TextStyle(color: "#9C9CB8".toColor()),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: "#0F0F26".toColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      width: 100.w,
                      height: 5.h,
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                          color: AppColor.primaryLightColor,
                          borderRadius: BorderRadius.circular(500)
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Get.to(StreamHomePage(),arguments: [widget.programs]);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500)),
                        child: Center(
                            child:  Text("my_channel_25".tr,
                              style: TextStyle(fontWeight: FontWeight.w500),)),
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 5.h,
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                          color: "0f0f26".toColor(),
                          borderRadius: BorderRadius.circular(500)
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Get.to(StreamHomePage(),arguments: [widget.programs]);

                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500)),
                        child: Center(
                            child:  Text("my_channel_26".tr,
                              style: TextStyle(fontWeight: FontWeight.w500),)),
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),
              Visibility(
                visible: !widget.programs.source.toString().contains("rtmp"),
                child: Container(
                  width: 100.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(500)
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      logic.startProgram(widget.programs);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500)),
                    child: Obx(() {
                      return Center(
                          child: logic.isloadingStartProgram.value ? Lottie.asset(
                              "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                              height: 5.h) : Text("my_channel_22".tr,
                            style: TextStyle(fontWeight: FontWeight.w500),));
                    }),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
