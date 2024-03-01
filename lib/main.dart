
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/utils/firebase_controller.dart';
import 'package:mediaverse/app/pages/channel/view.dart';
import 'package:sizer/sizer.dart';

import 'app/common/app_color.dart';
import 'app/common/app_route.dart';
import 'app/common/base/localization_service.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

 await FirebaseController().init();
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return const MyApp();
  }));
}
class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      title: 'MediaVerse',
      getPages: PageRoutes.routes,

      initialRoute: PageRoutes.VIDEOEDITOR,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale:LocalizationService.fallBackLocale,
      themeMode: AppTheme().getCurrentTheme(),
      theme: AppTheme.darkMode,
      darkTheme:  AppTheme.darkMode,
      // navigatorObservers: <NavigatorObserver>[MyApp.observer],

    );
  }
}
