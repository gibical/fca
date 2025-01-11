import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaverse/app/common/app_extension.dart';
export 'package:mediaverse/flavors.dart';

double withSize = 0;
double hightSize = 0;

TextStyle fontStyle(double fontSize, fontWeight) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

class AppTheme {
  var box = GetStorage();


  static ThemeData get lightMode => ThemeData(
        useMaterial3: true,
        // brightness: Brightness.light,
        scaffoldBackgroundColor: AppColor.whiteColor,
        fontFamily: "Ravi",
        colorScheme: ColorScheme(
          primary: AppColor.primaryDarkColor,
          brightness: Brightness.dark,
          background: AppColor.grayLightColor,
          onBackground: AppColor.primaryDarkColor,
          onPrimary: AppColor.whiteColor,
          surface: AppColor.grayLightColor,
          onSurface: AppColor.whiteColor,
          secondary: Colors.white.withOpacity(0.88),
          error: Colors.red,
          onError: Colors.red,
          onSecondary: Colors.black,
        ),
        textTheme: TextTheme(
          headlineMedium: fontStyle(20, FontWeight.w700),
          titleLarge: fontStyle(14, FontWeight.w400),
          titleMedium: fontStyle(14, FontWeight.w400),
          headlineSmall: fontStyle(14, FontWeight.w600),
          bodySmall: fontStyle(12, FontWeight.w400),
          bodyLarge: fontStyle(16, FontWeight.w400),
          bodyMedium: fontStyle(14, FontWeight.w400),
        ),
      );

  static ThemeData get darkMode => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: "Ravi",

        /// brightness: Brightness.dark,
        colorScheme: ColorScheme(
          primary: AppColor.primaryLightColor,
          brightness: Brightness.dark,
          background: AppColor.primaryDarkColor,
          onBackground: AppColor.primaryDarkColor,
          onPrimary: AppColor.primaryDarkColor,
          surface: AppColor.blueDarkColor,
          onSurface: AppColor.whiteColor,
          secondary: Color(0xff0E0E12).withOpacity(0.5),
          error: Colors.red,
          onError: Colors.red,
          onSecondary: Colors.black,
        ),
        textTheme: TextTheme(
          headlineMedium: fontStyle(20, FontWeight.w700),
          titleLarge: fontStyle(14, FontWeight.w400),
          titleMedium: fontStyle(14, FontWeight.w400),
          headlineSmall: fontStyle(14, FontWeight.w600),
          bodySmall: fontStyle(12, FontWeight.w400),
          bodyLarge: fontStyle(16, FontWeight.w400),
          bodyMedium: fontStyle(14, FontWeight.w400),
        ),
      );

  ThemeMode getCurrentTheme() {
    return ThemeMode.dark;


  }

  static changeTheme(ThemeMode mode) {
    var box = GetStorage();

    box.write("themeisDark", mode == ThemeMode.dark ? true : false);
    Get.changeThemeMode(mode);
  }
}

class AppColor {
  static late Color grayLightColor;
  static late Color backgroundColor;
  static late Color blueDarkColor;
  static late Color whiteColor;
  static late Color primaryLightColor;
  static  Color primaryColor = '#2563EB'.toColor();
  static late Color primaryDarkColor;
  static late Color errorColor;
  static  Color secondaryDark = '#000018'.toColor();


  static void init() {
    switch (F.appFlavor) {
      case Flavor.gibical:
        backgroundColor = const Color(0xff000018);
        grayLightColor = const Color(0xffF5F7F9);
        blueDarkColor = const Color(0xff010224);
        whiteColor = const Color(0xffffffff);
        primaryLightColor = const Color(0xff5A7AFA);
        primaryDarkColor = const Color(0xff000033);
        errorColor = const Color(0xffE01818);
        break;

      case Flavor.ravi:
        backgroundColor = const Color(0xff000018);

        grayLightColor = const Color(0xffF5F7F9);
        blueDarkColor = const Color(0xff00332f);
        whiteColor = const Color(0xffffffff);
        primaryLightColor = const Color(0xff13a89e);
        primaryDarkColor = const Color(0xff00332f);
        errorColor = const Color(0xffE01818);
        break;

      case Flavor.mediaverse:
      default:
      backgroundColor = const Color(0xff000018);

      grayLightColor = const Color(0xffF5F7F9);
        blueDarkColor = const Color(0xff010224);
        whiteColor = const Color(0xffffffff);
        primaryLightColor = const Color(0xff5A7AFA);
        primaryColor = const Color(0xff2563EB);
        primaryDarkColor = const Color(0xff000033);
        errorColor = const Color(0xffE01818);
        break;
    }

    whiteColor = const Color(0xffffffff);
  }
}
