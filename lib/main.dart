import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mediaverse/app/common/app_color.dart';
import 'package:sizer/sizer.dart';
import 'app.dart';
import 'app/common/utils/firebase_controller.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  var details = await FlutterLocalNotificationsPlugin()
      .getNotificationAppLaunchDetails();

  if (details!=null&&details.didNotificationLaunchApp) {
    print(details!.notificationResponse!.payload);
  }
  //await FirebaseController().init();
  AppColor.init();
  runApp(Sizer(builder: (context, orientation, deviceType) {
    return const App();
  }));}