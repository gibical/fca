import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaverse/app/pages/channel/widgets/addChanelCardCalanderWidget.dart';
import 'package:mediaverse/app/pages/channel/widgets/add_channel_card_widget.dart';
import 'package:mediaverse/app/pages/channel/widgets/card_channel_widget.dart';
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
  late DateTime _viewMonth;
  List<DateTime> selectedDates = [
  ]; // List of selected dates

  @override
  void initState() {
    super.initState();
    _viewMonth = DateTime.now();
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
    DateTime(_viewMonth.year, _viewMonth.month).weekday == 7
        ? 0
        : DateTime(_viewMonth.year, _viewMonth.month).weekday;
    for (int i = 1; i <= 35; i++) {
      _calender.add(
        DateTime(_viewMonth.year, _viewMonth.month, i - startWeekDay + 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
                        child: SvgPicture.asset(AppIcon.downIcon , color: Colors.white, height: 9),
                      ),
                      value: _viewMonth.month,
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
                          _viewMonth = DateTime(_viewMonth.year, newValue!);
                          viewCalender();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    DropdownButton<int>(

                      underline: Container(),
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AppIcon.downIcon , color: Colors.white, height: 9),
                      ),
                      value: _viewMonth.year,

                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(

                          value: DateTime.now().year - 5 + index,
                          child: Text((DateTime.now().year - 5 + index).toString()),
                        );
                      }),
                      onChanged: (int? newValue) {
                        setState(() {
                          _viewMonth = DateTime(newValue!, _viewMonth.month);
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
                        (index) => Expanded(
                      child: Text(
                          weekNames[index],
                          textAlign: TextAlign.center,
                          style: FontStyleApp.bodyMedium.copyWith(
                              color: AppColor.grayLightColor.withOpacity(0.5)
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
                              (index1) => Padding(
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
                                        setState(() {
                                          if (selectedDates
                                              .contains(calenderDateTime)) {
                                            selectedDates
                                                .remove(calenderDateTime);
                                          } else {
                                            selectedDates
                                                .add(calenderDateTime);
                                          }
                                        });

                                        print(calenderDateTime);
                                      },
                                      child: AnimatedContainer(

                                        curve: Curves.decelerate,
                                        duration: Duration(milliseconds: 500),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selectedDates.contains(
                                              calenderDateTime)
                                              ?  AppColor.primaryLightColor
                                              : null,
                                        ),
                                        child: Column(
                                          children: [
                                            if (isFirstMonth)
                                              Text(
                                                monthNames[calenderDateTime.month -
                                                    1],
                                                style: textTheme.bodyText2!
                                                    .copyWith(
                                                  color: isFirstMonth
                                                      ? Colors.white
                                                      : theme.primary
                                                      .withOpacity(0.6),
                                                  fontSize: 10,
                                                ),
                                              ),
                                            Text(
                                                calenderDateTime.day.toString(),
                                                textAlign: TextAlign.center,
                                                style: FontStyleApp.bodyMedium.copyWith(
                                                    color: AppColor.grayLightColor.withOpacity(0.5)
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
                        AddChannelCalanderCardWidget(),
                        CardChannelWidget(title: 'New Channel' , date: DateTime.now().toString()),
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
  }
}