import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/common/app_color.dart';
import 'app/common/app_route.dart';
import 'app/common/base/localization_service.dart';
import 'flavors.dart';
import 'pages/my_home_page.dart';

class App extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    print('_AppState.build = ${AppColor.primaryLightColor}');
    return GetMaterialApp(
      title:F.title,
      getPages: PageRoutes.routes,

      initialRoute: PageRoutes.SPLASH,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,

      locale:F.appFlavor==Flavor.ravi?LocalizationService.fallBackLocale2: LocalizationService().getCurrentLocale(),
      fallbackLocale:LocalizationService.fallBackLocale,
      themeMode: AppTheme().getCurrentTheme(),
      theme: AppTheme.darkMode,
      darkTheme:  AppTheme.darkMode,


       navigatorObservers: <NavigatorObserver>[

        if(Platform.isAndroid) App.observer

       ],

    );

  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
        child: child,
        location: BannerLocation.topStart,
        message: F.name,
        color: Colors.green.withOpacity(0.6),
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 1.0),
        textDirection: TextDirection.ltr,
      )
          : Container(
        child: child,
      );
}
