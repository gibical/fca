import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/common/widgets/appbar_btn.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:sizer/sizer.dart';

class MyChannelManagementBottomSheet extends StatefulWidget {
  ChannelsModel baseModel;

  MyChannelManagementBottomSheet(this.baseModel);

  @override
  State<MyChannelManagementBottomSheet> createState() =>
      _MyChannelManagementBottomSheetState();
}

class _MyChannelManagementBottomSheetState
    extends State<MyChannelManagementBottomSheet>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late MyChannelController logic;

  @override
  void initState() {
    super.initState();
    logic = Get.put(MyChannelController(widget.baseModel));

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        logic.selectedTabIndex = _tabController.index;
      });
      if (logic.selectedTabIndex == 0) {}
      if (logic.selectedTabIndex == 1) {}
    });
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
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).viewPadding.top + 4.h,
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
                          logic.baseModel.name ?? "",
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
                                          onTap: () {},
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
                                          onTap: () {},
                                          child: SizedBox(
                                            width: 130,
                                            child: Row(
                                              children: [
                                                Obx(() {
                                                  if (true) {
                                                    return Transform.scale(
                                                      scale: 0.5,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.redAccent,
                                                        backgroundColor: Colors
                                                            .redAccent
                                                            .withOpacity(0.2),
                                                      ),
                                                    );
                                                  }
                                                  return SvgPicture.asset(
                                                      'assets/mediaverse/icons/delete.svg');
                                                }),
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
                    Container(
                      child: Row(
                        children:
                            logic.tabListModel.asMap().entries.map((toElement) {
                          bool _isSelected =
                              logic.selectedTabIndex == toElement.key;
                          return Expanded(
                            child: Container(
                              height: 3.5.h,
                              child: MaterialButton(
                                onPressed: (){
                                  logic.selectedTabIndex = toElement.key;
                                  logic.pageController.animateToPage(logic.selectedTabIndex, duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
                                  logic.update();
                                },
                                padding: EdgeInsets.zero,

                                child: Column(
                                  children: [
                                    SizedBox(height: 6,),
                                    Expanded(
                                      child: Text(
                                        toElement.value.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: _isSelected
                                              ? Colors.white
                                              : "#9C9CB8".toColor(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: _isSelected
                                              ? AppColor.primaryLightColor
                                              : Colors.transparent),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: logic.pageController,
                        onPageChanged: (s){
                          logic.selectedTabIndex = s;
                          logic.update();
                        },
                        children: logic.tabListModel.asMap().entries.map((toElement){
                          return toElement.value.widget;
                      
                        }).toList(),
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
