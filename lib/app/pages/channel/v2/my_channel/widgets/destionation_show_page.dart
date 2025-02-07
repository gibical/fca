import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/add_destionation_bottom_sheet.dart';
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
import 'destination_empty_state.dart';

class DestionationTabWidget extends StatefulWidget {
  @override
  State<DestionationTabWidget> createState() => _DestionationTabWidgetState();
}

class _DestionationTabWidgetState extends State<DestionationTabWidget> {
  MyChannelController logic = Get.find<MyChannelController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyChannelController>(
        init: logic,
        builder: (logic) {
          return Container(
            height: 100.h,
            child: Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: (logic.destinations ?? []).isEmpty
                          ? DestionationEmptyState()
                          : SingleChildScrollView(
                              child: Column(
                                children: (logic.destinations ?? [])
                                    .asMap()
                                    .entries
                                    .map((toElement) {
                                  final GlobalKey _containerKey = GlobalKey();

                                  bool _isEnable = logic
                                      .getStatusToDestionation(toElement.value);
                                  return Container(
                                    height: 5.h,
                                    width: 100.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                toElement.value.name ?? "")),
                                        Switch(
                                            inactiveThumbColor: Colors.white,
                                            inactiveTrackColor:
                                                "9c9cb8".toColor(),
                                            value: _isEnable,
                                            onChanged: (s) {
                                              logic.onSetDestionation(
                                                  toElement.value, _isEnable);
                                            }),
                                        Container(
                                          child: MaterialButton(
                                            child: SvgPicture.asset(
                                              "assets/all/icons/menu-circle-vertical.svg",
                                              height: 1.5.h,
                                            ),
                                            onPressed: () {
                                              final RenderBox renderBox =
                                                  _containerKey.currentContext
                                                          ?.findRenderObject()
                                                      as RenderBox;
                                              final Offset offset = renderBox
                                                  .localToGlobal(Offset.zero);
                                              showMenu(
                                                position: RelativeRect.fromLTRB(
                                                  offset.dx,
                                                  offset.dy,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      offset.dx -
                                                      renderBox.size.width,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      offset.dy -
                                                      renderBox.size.height,
                                                ),
                                                color: '#0F0F26'.toColor(),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.sp)),
                                                context: context,
                                                items: [
                                                  PopupMenuItem(
                                                    value: 1,
                                                    onTap: () {
                                                      Get.bottomSheet(
                                                          AddOrEditDestionationBottomSheet(
                                                        true,
                                                        destinations:
                                                            toElement.value,
                                                      ));
                                                    },
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/mediaverse/icons/edit.svg'),
                                                          Text('Edit'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 1,
                                                    onTap: () {
                                                      logic
                                                          .removeDestionationFromChannel(
                                                              toElement.value);
                                                    },
                                                    child: SizedBox(
                                                      width: 130,
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/mediaverse/icons/delete.svg'),
                                                          Text('Delete'),
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
                                            },
                                            padding: EdgeInsets.zero,
                                          ),
                                          width: 4.w,
                                          key: _containerKey,
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 100.w,
                        height: 5.h,
                        margin: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                            color: AppColor.primaryLightColor,
                            borderRadius: BorderRadius.circular(500)),
                        child: MaterialButton(
                          onPressed: () {
                            Get.bottomSheet(
                                AddOrEditDestionationBottomSheet(false));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  "assets/all/icons/my_channel_4.svg"),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Text(
                                "my_channel_42".tr,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
