import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/pages/channel/widgets/addChanelCardCalanderWidget.dart';
import 'package:mediaverse/app/pages/channel/widgets/add_channel_card_widget.dart';
import 'package:mediaverse/app/pages/channel/widgets/card_channel_widget.dart';
import 'package:mediaverse/app/pages/share_account/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';
import '../../../common/app_icon.dart';
import '../../../common/font_style.dart';


class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({Key? key}) : super(key: key);

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  final List<DateTime> _calender = [];

  ShareAccountLogic logic = Get.find<ShareAccountLogic>();

  @override
  void initState() {
    super.initState();

    viewCalender();
  }

  List<String> weekNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  void viewCalender() {
    _calender.clear();
    final int startWeekDay =
    DateTime(logic.viewMonth.year,logic. viewMonth.month).weekday == 7
        ? 0
        : DateTime(logic.viewMonth.year,logic. viewMonth.month).weekday;
    for (int i = 1; i <= 35; i++) {
      _calender.add(
        DateTime(logic.viewMonth.year, logic.viewMonth.month, i - startWeekDay + 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    return GetBuilder<ShareAccountLogic>(
        init:logic,
        builder: (logic) {
          print('_CustomCalendarWidgetState.build');
          return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<int>(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                              AppIcon.downIcon, color: Colors.white, height: 9),
                        ),
                        value: logic.viewMonth.month,
                        iconEnabledColor: Colors.transparent,
                        underline: Container(),
                        items: List.generate(12, (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text(monthNames[index]),
                          );
                        }),
                        onChanged: (int? newValue) {
                          setState(() {
                            logic.getShareSchedules();
                            logic.viewMonth = DateTime(logic.viewMonth.year, newValue!);
                            viewCalender();
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      DropdownButton<int>(

                        underline: Container(),
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                              AppIcon.downIcon, color: Colors.white, height: 9),
                        ),
                        value: logic.viewMonth.year,

                        items: List.generate(10, (index) {
                          return DropdownMenuItem<int>(

                            value: DateTime
                                .now()
                                .year - 5 + index,
                            child: Text((DateTime
                                .now()
                                .year - 5 + index).toString()),
                          );
                        }),
                        onChanged: (int? newValue) {
                          setState(() {
                            logic.getShareSchedules();
                            logic. viewMonth = DateTime(newValue!, logic.viewMonth.month);
                            viewCalender();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    ...List.generate(
                      7,
                          (index) =>
                          Expanded(
                            child: Text(
                                weekNames[index],
                                textAlign: TextAlign.center,
                                style: FontStyleApp.bodyMedium.copyWith(
                                    color: AppColor.grayLightColor.withOpacity(
                                        0.5)
                                )
                            ),
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            5,
                                (index1) =>
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      ...List.generate(7, (index2) {
                                        final DateTime calenderDateTime =
                                        _calender[index1 * 7 + index2];

                                        bool isFirstMonth =
                                            calenderDateTime.day == 1;
                                        return Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              logic.onSelcetedDate(
                                                  calenderDateTime);

                                              print(calenderDateTime);
                                            },
                                            child: AnimatedContainer(

                                              curve: Curves.decelerate,
                                              duration: Duration(
                                                  milliseconds: 500),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: logic.selectedDates ==
                                                    (calenderDateTime)
                                                    ? AppColor.primaryLightColor
                                                    : null,
                                              ),
                                              child: Column(
                                                children: [
                                                  if (isFirstMonth)
                                                    Text(
                                                      monthNames[calenderDateTime
                                                          .month -
                                                          1],
                                                      style: textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                        color: isFirstMonth
                                                            ? Colors.white
                                                            : theme.primary
                                                            .withOpacity(0.6),
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  Text(
                                                      calenderDateTime.day
                                                          .toString(),
                                                      textAlign: TextAlign
                                                          .center,
                                                      style: FontStyleApp
                                                          .bodyMedium.copyWith(
                                                          color: AppColor
                                                              .grayLightColor
                                                              .withOpacity(0.5)
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  side: BorderSide(
                                      color: Colors.white.withOpacity(0.4),
                                      width: 0.7)),
                              height: 6.h,
                              minWidth: double.infinity,
                              onPressed: () {
                                logic.showAddUpComingBottomSheet();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'channel_21'.tr,
                                    style: FontStyleApp.bodyMedium.copyWith(
                                      color: AppColor.grayLightColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Icon(Icons.add,
                                      color: AppColor.grayLightColor
                                          .withOpacity(0.5), size: 20),
                                ],
                              ),
                            ),
                          ),

                          ...logic.todayModels.asMap().entries.map((e) =>    CardChannelWidget(title: e.value.type.toString(),
                              date: DateTime.parse(e.value.time??"").toString()),).toList()
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      );
    });
  }
}