import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../../../firebase_options.dart';
import '../RequestInterface.dart';
import '../app_api.dart';

class FirebaseController extends GetxController implements RequestInterface {

  var box=GetStorage();
  late ApiRequster apiRequster;

   init()async {

    onReady();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }

    if (box.read("islogin")??false) {
      String? token = await FirebaseMessaging.instance.getToken();
      print('FirebaseController.init = ${token}');
      box.write("firebaseToken", token);
      var body = {
      "token":token
    };
      apiRequster.request("push-notifications/firebase-tokens", ApiRequster.MHETOD_POST, 1,useToken: true,body: body);
    }


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    apiRequster = ApiRequster(this,develperModel: true);

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
  }

  void logOut() {

   // apiRequster.request("api/u-crm/sessions/firebase", ApiRequster.METHOD_DELETE, 1,useToken: true,);
    
  }


}