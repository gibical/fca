import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mediaverse/app/common/app_route.dart';
import 'package:mediaverse/app/common/utils/firebase_options.dart';
import 'package:meta/meta.dart';

import '../../../flavors.dart';
import '../../pages/media_suit/logic.dart';
import '../RequestInterface.dart';
import '../app_api.dart';

class FirebaseController extends GetxController implements RequestInterface {
  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse response) {
    print('FirebaseController.initializeLocalNotifications 1 ');
    // Handle your notification response logic here
  }
  late FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var box = GetStorage();
  late ApiRequster apiRequster;

  init() async {
    onReady();
   if (true) {
     var s = F.appFlavor==Flavor.gibical? await Firebase.initializeApp(
       name: F.title,
       options: DefaultFirebaseConfig.firebaseOptions
      ):await Firebase.initializeApp(
         options: DefaultFirebaseConfig.firebaseOptions
     );
      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission();
      }
     
      _firebaseMessaging = FirebaseMessaging.instance;
      requestNotificationPermissions();
      initializeLocalNotifications();
      listenToFCMMessages();
      if (box.read("islogin") ?? false) {

        String? token = await FirebaseMessaging.instance.getToken();
        if(kDebugMode)log('FirebaseController.init token = ${token}');
        box.write("firebaseToken", token);
        var body = {"token": token};
        apiRequster.request(
            "push-notifications/firebase-tokens", ApiRequster.MHETOD_POST, 1,
            useToken: true, body: body);
        apiRequster.request("firebase?user_id=2", ApiRequster.MHETOD_GET, 500,
            useToken: true);
      }
   }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this, develperModel: false);
  }

  @override
  void onError(String content, int reqCode, bodyError) {
    // TODO: implement onError
  }

  @override
  void onStartReuqest(int reqCode) {
    // TODO: implement onStartReuqest

  }

  @override
  void onSucces(source, int reqCdoe) {
    // TODO: implement onSucces
    print('FirebaseController.onSucces Update Token ');
  }

  void logOut() {
    // apiRequster.request("api/u-crm/sessions/firebase", ApiRequster.METHOD_DELETE, 1,useToken: true,);
  }

  void requestNotificationPermissions() {
    _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void initializeLocalNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // handle if needed
        print('FirebaseController.initializeLocalNotifications onDidReceiveLocalNotification ');
      },
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            FirebaseController.onDidReceiveBackgroundNotificationResponse,
        onDidReceiveNotificationResponse: (s) {
    //  debugger();
      sendToAssetPage(s.payload ?? "");
    });
  }

  void listenToFCMMessages() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");

      FirebaseController.sendToAssetPage( jsonEncode(message.data));
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('FirebaseController.listenToFCMMessages = ${message} - ${Get.currentRoute}');
      if(Get.currentRoute.contains(PageRoutes.MEDIASUIT)){
        if (Get.find<MediaSuitController>().isloadingSubmit.value) {
          Get.find<MediaSuitController>().isloadingSubmit(false);
          sendToAssetPage(jsonEncode(message.data));
        }
        if (Get.find<MediaSuitController>().isWaitingAssetConvert.value) {
          Get.find<MediaSuitController>().isWaitingAssetConvert(false);

          Get.find<MediaSuitController>().setAssetLoadingValue(jsonEncode(message.data));
        }
      }else{
        showNotification(message);
      }
    });
  }

  void showNotification(RemoteMessage message) {
    print('FirebaseController.showNotification 1 ');
    //debugger();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'MediaVerse_0',
      'MediaVerse',
      channelDescription: 'MediaVerse Channel Notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    print('FirebaseController.showNotification 2 ');
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
 ;

    try {
      _flutterLocalNotificationsPlugin.show(
          0, // Notification ID
          message.notification?.title, // Notification Title
          message.notification!.body.toString(), // Notification Body
          platformChannelSpecifics,
          //   payload: message.data
          payload: jsonEncode(message.data));
      print('FirebaseController.showNotification 4 ');

    } catch (e) {
      print('FirebaseController.showNotification = ${e}');
      _flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        message.notification?.title, // Notification Title
        message.notification?.body, // Notification Body
        platformChannelSpecifics,
      );
    }
  }

  static void  sendToAssetPage(String s) {
    print('FirebaseController.sendToAssetPage = ${s}');
    // debugger();
    try {
      var json = jsonDecode(jsonDecode(s)['result']);
      var id = json['id'];

      print('FirebaseController.sendToAssetPage 2  = ${json}');
      String route = PageRoutes.DETAILIMAGE;
      switch ((json['media_type']).toString()) {
        case "text":
          route = PageRoutes.DETAILTEXT;
        case "image":
          route = PageRoutes.DETAILIMAGE;
        case "audio":
          route = PageRoutes.DETAILMUSIC;
        case "video":
          route = PageRoutes.DETAILVIDEO;
      }
      Get.toNamed(route, arguments: {'id': id}, preventDuplicates: false);
    } catch (e) {
      // TODO
      print('FirebaseController.sendToAssetPage = ${e}');
    }
  }
}
