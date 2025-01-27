import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../common/app_color.dart';

class ChannelConductorTab extends StatefulWidget {
  const ChannelConductorTab({super.key});

  @override
  State<ChannelConductorTab> createState() => _ChannelConductorTabState();
}

class _ChannelConductorTabState extends State<ChannelConductorTab> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 3.h),
        child:  Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime(2050),
                focusedDay: DateTime.now(),
                currentDay: dateTime,
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                startingDayOfWeek: StartingDayOfWeek.sunday,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: Icon(
                      Icons.chevron_left, color: Colors.white),
                  rightChevronIcon: Icon(
                      Icons.chevron_right, color: Colors.white),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: '2563EB'.toColor(),
                    shape: BoxShape.circle,
                  ),
                  // selectedDecoration: BoxDecoration(
                  //   color: Colors.blue.shade700,
                  //   shape: BoxShape.circle,
                  // ),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    this.dateTime = selectedDay;
                  });
                },
              ),

              SizedBox(height: 2.h,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("my_channel_33".tr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13.sp),),
              ),
              SizedBox(height: 1.h,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("my_channel_41".tr,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 9.sp,color: "#9C9CB8".toColor()),),
              ),


            ],
          ),
        ),
      ),
    );;
  }
}
