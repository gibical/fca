
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gibical/app/common/utils/firebase_controller.dart';
import 'package:gibical/app/pages/channel/view.dart';
import 'package:gibical/app/pages/wrapper/logic.dart';
import 'package:gibical/app/pages/wrapper/state.dart';
import 'package:sizer/sizer.dart';

import 'app/common/app_color.dart';
import 'app/common/app_route.dart';
import 'app/common/base/localization_service.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var details = await FlutterLocalNotificationsPlugin()
      .getNotificationAppLaunchDetails();

  if (details!=null&&details.didNotificationLaunchApp) {
    print(details!.notificationResponse!.payload);
  }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceInformation();
    FirebaseAnalytics.instance.logEvent(name: "Entered The app");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'gibical',
      getPages: PageRoutes.routes,

      initialRoute: PageRoutes.SPLASH,
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

  void getDeviceInformation()async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
    }  catch (e) {
      // TODO
    }
    try {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      print('Running on ${iosDeviceInfo.model}');
    }  catch (e) {
      // TODO
    }

  }
}
