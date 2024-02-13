import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:mediaverse/app/pages/detail/logic.dart';
import 'package:sizer/sizer.dart';

import '../../../common/app_color.dart';

class TextToTextWidget extends StatelessWidget {


  DetailController detailController;

  TextToTextWidget(this.detailController);

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
                  const Text("Text To Text Convert"),
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
                    "Prefix",
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
                      controller: logic.prefixEditingController,
                      decoration:
                      InputDecoration(
                        border:
                        OutlineInputBorder(
                          borderSide:
                          BorderSide
                              .none,
                        ),
                        hintText:
                        "Insert Prefix...",
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
                onPressed: () async {
                  Get.back(result: true);

                },
                color: "5979fe".toColor(),
                child: const Text("Start Converting"),
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
