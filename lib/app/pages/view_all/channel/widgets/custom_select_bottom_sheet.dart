
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediaverse/app/common/app_extension.dart';
import 'package:sizer/sizer.dart';

void runCustomSelectBottomSheet(Map<String, String> languageMap, TextEditingController? textEditingController, String title, Function(String) filterCallback) {
  Get.bottomSheet(Container(
    width: 100.w,
    height: 50.h,
    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
    decoration: BoxDecoration(
      color: "474755".toColor(),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3.h),
        Expanded(
          child: ListView.builder(
            itemBuilder: (s, p) {
              final language = languageMap.keys.toList()[p];
              final languageFullName = languageMap[language];
              return InkWell(
                onTap: () {
                  try {
                    textEditingController!.text = language;
                    filterCallback(language);
                  } catch (e) {
                    // TODO
                  }
                  Get.back();
                },
                child: Container(
                  width: 100.w,
                  height: 4.h,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languageFullName!,
                        style: TextStyle(color: Colors.white.withOpacity(0.4)),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 100.w,
                        height: 1,
                        color: Colors.white.withOpacity(0.15),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: languageMap.length,
          ),
        )
      ],
    ),
  ));
}


