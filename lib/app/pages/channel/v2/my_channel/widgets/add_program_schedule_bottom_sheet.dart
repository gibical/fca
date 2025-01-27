import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../detail/logic.dart';

class AddProgramScheduleBottomSheet extends StatefulWidget {
  const AddProgramScheduleBottomSheet({super.key});

  @override
  State<AddProgramScheduleBottomSheet> createState() => _AddProgramScheduleBottomSheetState();
}

class _AddProgramScheduleBottomSheetState extends State<AddProgramScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void runSelectDateSheet(DetailController detailController) {
    detailController.fetchChannels();

    Get.bottomSheet(
      elevation: 0,
      isScrollControlled: true,
      StatefulBuilder(builder: (context, setState) {
        return Container(
          width: double.infinity,

          decoration: BoxDecoration(
            color: "#0F0F26".toColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assets/mediaverse/icons/arrow.svg' , width: 24 , height: 24,),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Select date',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // Calendar Section
                  TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2050),
                    focusedDay: detailController.selectedDate.value ?? DateTime.now(),
                    currentDay: detailController.selectedDate.value ,
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
                      leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
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
                        detailController.selectedDate.value  = selectedDay;
                        detailController.isSeletedDate.value = true;
                      });
                    },
                  ),
                  SizedBox(height: 2.h),
                  //Continue btn
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Material(
                      color: '2563EB'.toColor(),
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        splashColor: Colors.white.withOpacity(0.03),
                        onTap: () {
                          runSelectTimeSheet(detailController);
                        },
                        child: Center(
                          child: Text('Continue'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void runSelectTimeSheet(DetailController controller) {
    Get.bottomSheet(
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      StatefulBuilder(builder: (context, setState) {
        TimeOfDay selectedTime = TimeOfDay.now();

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: "#0F0F26".toColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 3.h),
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                            'assets/mediaverse/icons/arrow.svg', width: 24, height: 24),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Select time',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 3.h),
                // Time Picker Section
                SizedBox(
                  height: 200,
                  child: TimePickerSpinner(
                    isShowSeconds: true,
                    isForce2Digits: true,

                    highlightedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                    ),
                    normalTextStyle: TextStyle(

                        color: '9C9CB8'.toColor(),
                        fontSize: 25
                    ),
                    is24HourMode: false,
                    time: DateTime(selectedTime.hour, selectedTime.minute),
                    onTimeChange: (time) {
                      setState(() {
                        selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);

                        final currentDate = controller.selectedDate.value ?? DateTime.now();
                        final updatedDateTime = DateTime(
                          currentDate.year,
                          currentDate.month,
                          currentDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        controller.selectedDate.value = updatedDateTime;
                        controller.isSeletedDate.value = true;
                      });
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                // Confirm Button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: Material(
                    color: '2563EB'.toColor(),
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      splashColor: Colors.white.withOpacity(0.03),
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
