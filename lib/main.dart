import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/common/app_color.dart';
import 'app/common/app_route.dart';
import 'app/common/base/localization_service.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return const MyApp();
  }));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MediaVerse',
      getPages: PageRoutes.routes,
      initialRoute: PageRoutes.SPLASH,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      locale: LocalizationService().getCurrentLocale(),
      fallbackLocale:LocalizationService.fallBackLocale,
      themeMode: AppTheme().getCurrentTheme(),
      theme: AppTheme.lightTheme,
      darkTheme:  AppTheme.darkTheme,

    );
  }
}
