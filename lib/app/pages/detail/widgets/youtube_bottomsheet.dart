import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class YoutubeShareBottomSheet extends StatelessWidget {


  DetailController detailController;

  YoutubeShareBottomSheet(this.detailController);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
        init: detailController,
        builder: (logic) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  const Text("Share To Youtube"),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color:
                        Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 6.h,
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      10),
                  color: Colors.black54),
              child: Row(
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  const Text(
                    "Title",
                    style: TextStyle(
                        color:
                        Colors.white54),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                    height: 28,
                    width: 1.5,
                    color: AppColor
                        .whiteColor
                        .withOpacity(0.2),
                  ),
                   Expanded(
                    child: TextField(
                      controller: logic.titleEditingController,
                      decoration:
                      InputDecoration(
                        border:
                        OutlineInputBorder(
                          borderSide:
                          BorderSide
                              .none,
                        ),
                        hintText:
                        "Insert Title...",
                        hintStyle:
                        TextStyle(
                          color: Colors
                              .white60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 6.h,
              width: 100.w,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      10),
                  color: Colors.black54),
              child: Row(
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  const Text(
                    "Descriptions",
                    style: TextStyle(
                        color:
                        Colors.white54),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                    height: 28,
                    width: 1.5,
                    color: AppColor
                        .whiteColor
                        .withOpacity(0.2),
                  ),
                   Expanded(
                    child: TextField(
                      controller: logic.titleEditingController,
                      decoration:
                      InputDecoration(
                        border:
                        OutlineInputBorder(
                          borderSide:
                          BorderSide
                              .none,
                        ),
                        hintText:
                        "Insert Descriptions...",
                        hintStyle:
                        TextStyle(
                          color: Colors
                              .white60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            SizedBox(
              height: 1.h,
            ),

            Builder(
              builder: (context) {
                bool _isEnabled =  logic.isSeletedNow;
                return Opacity(opacity:_isEnabled?1:0.5,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 16,
                  vertical: 8),
                  height: 7.h,
                  decoration: BoxDecoration(
                    color:_isEnabled? "1C1C23".toColor().withOpacity(0.75):Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: "597AFF".toColor(),

                    )
                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      logic.isSeletedNow = true;
                      logic.update();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text("Now",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),);
              }
            ),
            Builder(
              builder: (context) {
                bool _isEnabled =  !logic.isSeletedNow;
                return Opacity(opacity:_isEnabled?1:0.5,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 16,
                  vertical: 8),
                  height: 7.h,
                  decoration: BoxDecoration(
                    color:_isEnabled? "1C1C23".toColor().withOpacity(0.75):Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: "597AFF".toColor(),

                    )
                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      logic.isSeletedNow = false;
                      logic.update();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text("Later",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),);
              }
            ),
           if(!logic.isSeletedNow) Builder(
              builder: (context) {
                bool _isEnabled =  true;
                return Opacity(opacity:_isEnabled?1:0.5,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 16,
                  vertical: 8),
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: "26262e".toColor(),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                     showDialogPicker(context, logic);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text( logic.isSeletedDate?"${logic.dateTime.year}-${logic.dateTime.month}-${logic.dateTime.day}":"Choose Date",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),);
              }
            ),
           if(!logic.isSeletedNow) Builder(
              builder: (context) {
                bool _isEnabled =  true;
                return Opacity(opacity:_isEnabled?1:0.5,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.symmetric(horizontal: 16,
                  vertical: 8),
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: "26262e".toColor(),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                     showDialogTimePicker(context, logic);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text( logic.isSeletedDate?"${logic.dateTime.hour}-${logic.dateTime.minute}":"Choose time",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),);
              }
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 5.h,
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 5.h,
                shape:
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                        100)),
                onPressed: () async {},
                color: Colors.black54,
                child: const Text("Add"),
              ),
            )
          ],
        ),
      );
    });
  }
  void showDialogPicker(BuildContext context,DetailController controller){
  var  selectedDate = showDatePicker(
      context: context,
      helpText: 'Your Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme:  ColorScheme.light(
                // primary: MyColors.primary,
                primary: Theme.of(context).colorScheme.primary,
                onPrimary: AppColor.primaryDarkColor,
                surface: "02063d".toColor(),
                onSurface: Colors.white,
              ),
              //.dialogBackgroundColor:Colors.blue[900],
            ),
            child: child!,
          ),
        );
      },
    );
    selectedDate.then((value) {
      controller.dateTime =value!;
      controller.isSeletedDate=true;
      controller.update();
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void showDialogTimePicker(BuildContext context,DetailController controller){
   var selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme:  ColorScheme.light(
                // primary: MyColors.primary,
                primary: Theme.of(context).colorScheme.primary,
                onPrimary: AppColor.primaryDarkColor,
                surface: "02063d".toColor(),
                onSurface: Colors.white,
              ),
              //.dialogBackgroundColor:Colors.blue[900],
            ),
            child: child!,
          ),
        );
      },
    );
    selectedTime.then((value) {


      controller.dateTime = controller.dateTime.copyWith(
        hour: value?.hour,
        minute: value?.minute,
      );
      controller.isSeletedDate=true;
      controller.update();
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

}
