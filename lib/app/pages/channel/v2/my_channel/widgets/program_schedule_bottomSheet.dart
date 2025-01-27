import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/logic.dart';
import 'package:mediaverse/app/pages/channel/v2/my_channel/widgets/programs_schedule_empty_state.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetChannelsShow.dart';
import 'package:mediaverse/gen/model/json/FromJsonGetProgramSchedules.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../common/app_color.dart';
import '../../../../../common/widgets/appbar_btn.dart';

class ProgramScheduleBottomsheet extends StatefulWidget {
  ProgramScheduleBottomsheet(this.programs, {super.key});

  Programs programs;

  @override
  State<ProgramScheduleBottomsheet> createState() =>
      _ProgramScheduleBottomsheetState();
}

class _ProgramScheduleBottomsheetState
    extends State<ProgramScheduleBottomsheet> {
  DateTime dateTime = DateTime.now();
  MyChannelController logic = Get.find<MyChannelController>();
  List<ProgramSchedulesModel> modelList = [];
  var isloading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: Obx(() {
        return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            body: isloading.value ? Center(
              child: Lottie.asset(
                "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                height: 10.h,
              ),
            ) : Stack(
              children: [
                SizedBox.expand(
                  child: modelList.isEmpty
                      ? ProgramsScheduleEmptyState(widget.programs)
                      : Container(
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
                              "",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container()
                          ],
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: modelList.length,
                                itemBuilder: (s, i) {
                                  ProgramSchedulesModel programSch = modelList.elementAt(i);
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 1.h),
                                    child: Container(
                                      width: 100.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                          color: "0f0f26".toColor(),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: MaterialButton(
                                        onPressed: (){

                                        },
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            Expanded(child: Text(DateFormat('d MMMM, h:mm a').format(DateTime.parse(programSch.startsAt??"")),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 11.sp),)),
                                            GestureDetector(

                                              child: SvgPicture.asset("assets/all/icons/trash.svg"),
                                              onTap: (){

                                                _deleteSchedule(programSch);

                                              },)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),

                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 100.w,
                    height: 5.h,
                    margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 16),
                    decoration: BoxDecoration(
                        color: AppColor.primaryLightColor,
                        borderRadius: BorderRadius.circular(500)
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        runSelectDateSheet();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(500)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/all/icons/my_channel_4.svg"),
                          SizedBox(width: 1.5.w,),
                          Text("my_channel_39".tr,
                            style: TextStyle(fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        );
      }),
    );
  }

  void _getSchedule() async {
    isloading(true);
    modelList = await Get.find<MyChannelController>()
        .getProgramSchedule(widget.programs);
    isloading(false);
  }

  void runSelectDateSheet() {
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
                            'assets/mediaverse/icons/arrow.svg', width: 24,
                            height: 24,),
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
                          runSelectTimeSheet();
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

  void runSelectTimeSheet() {
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
                            'assets/mediaverse/icons/arrow.svg', width: 24,
                            height: 24),
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
                    time: DateTime.now(),
                    onTimeChange: (time) {
                      setState(() {
                        selectedTime =
                            TimeOfDay(hour: time.hour, minute: time.minute);
                        dateTime = dateTime.copyWith(hour: selectedTime.hour,
                            minute: selectedTime.minute);
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
                      onTap: () async{
                       var s = await logic.addProgramSchedule(dateTime, widget.programs);
                       if(s==true){
                         _getSchedule();
                       }
                      },
                      child: Obx(() {
                        return Center(
                          child: logic.isloadingAddSchedule.value ? Lottie
                              .asset(
                              "assets/${F.assetTitle}/json/Y8IBRQ38bK.json",
                              height: 4.h) : Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
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

  void _deleteSchedule(ProgramSchedulesModel programSch) {
    modelList.removeWhere((test)=>test.id.toString().contains(programSch.id.toString()));
    setState(() {

    });
    logic.removeSchedule(programSch.id.toString());
  }
}
