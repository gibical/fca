import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../gen/model/json/FromJsonGetSchedules.dart';
import '../../../../../../common/app_color.dart';
import '../../logic.dart';
import '../program_show_page.dart';

class ChannelConductorTab extends StatefulWidget {
  const ChannelConductorTab({super.key});

  @override
  State<ChannelConductorTab> createState() => _ChannelConductorTabState();
}

class _ChannelConductorTabState extends State<ChannelConductorTab> {
  DateTime dateTime = DateTime.now();
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
          List<SchedulesModel> models= filterSchedulesByDate(dateTime, logic.schedulesList);
          return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 3.h),
          child: Container(
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
                  child: Text("my_channel_33".tr, style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13.sp),),
                ),
                SizedBox(height: 1.h,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("my_channel_41".tr, style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 9.sp,
                      color: "#9C9CB8".toColor()),),
                ),

                ...models.asMap().entries.map((toElement){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    child: Container(
                      width: 100.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                          color: "0f0f26".toColor(),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: MaterialButton(
                        onPressed: (){
                          Get.bottomSheet(ProgramShowPage(toElement.value.program!),isScrollControlled: true);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Expanded(child: Column(

                              children: [
                                Text(toElement.value.program!.name??""),
                                Text(DateFormat('d MMMM, h:mm a').format(DateTime.parse(toElement.value.program!.createdAt??"")),style: TextStyle(color: "#9C9CB8".toColor(),fontSize: 9.sp),),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )),

                          ],
                        ),
                      ),
                    ),
                  );
                }).toList()

              ],
            ),
          ),
        ),
      );
    });;
  }

  List<SchedulesModel> filterSchedulesByDate(DateTime date,
      List<SchedulesModel> schedules) {
    return schedules.where((schedule) {
      if (schedule.startsAt == null) return false;
      try {
        DateTime scheduleDate = DateTime.parse(schedule.startsAt!);
        return scheduleDate.year == date.year &&
            scheduleDate.month == date.month &&
            scheduleDate.day == date.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }
}
