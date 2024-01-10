
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_extension.dart';


double withSize = 0;
double hightSize = 0;


class AppTheme{
  var box  = GetStorage();

  static var lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.white,
    brightness: Brightness.light,
      hintColor: "#758299".toColor(),
      cardColor: "#E2E7F2".toColor(),disabledColor: "E2E7F2".toColor(),
      textTheme: TextTheme(
          displayMedium: TextStyle(color:Colors.white ),
          displaySmall: TextStyle(color: Colors.white )
      )

  );
  static var darkTheme =  ThemeData.dark().copyWith(
    primaryColor:Colors.white,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.black,
    brightness: Brightness.dark,
    cardColor: "#111920".toColor(),
    hintColor: "#162532".toColor(),disabledColor: "#111920".toColor(),
    textTheme: TextTheme(
      displayMedium: TextStyle(color:Colors.white),
      displaySmall: TextStyle(color:Colors.white )
    )

  );

  ThemeMode getCurrentTheme() {

    print('AppTheme.getCurrentTheme = ${box.read("themeisDark") != null}');
    if (box.read("themeisDark") != null) {
      bool themeisDark = box.read("themeisDark") ?? false;
      return themeisDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  static changeTheme(ThemeMode mode) {
    var box  = GetStorage();

    box.write("themeisDark", mode==ThemeMode.dark?true:false);
    Get.changeThemeMode(mode);


  }
}
