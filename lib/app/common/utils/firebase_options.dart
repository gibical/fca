import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import '../../../flavors.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get firebaseOptions {
    if (Platform.isAndroid) {
      return _androidFirebaseOptions;
    } else if (Platform.isIOS) {
      return _iosFirebaseOptions;
    } else {
      throw UnsupportedError('This platform is currently not supported.');
    }
  }

  static FirebaseOptions get _androidFirebaseOptions {
    switch (F.appFlavor) {
      case Flavor.mediaverse:
        return const FirebaseOptions(
          apiKey: 'AIzaSyDg7cN6iKLoPzEXEbdAf-Oi6kEnY7qt-XY',
          appId: '1:772733695599:android:dcae904c45927083423f9a',
          messagingSenderId: '772733695599',
          projectId: 'mediaverse-14066',
          storageBucket: 'mediaverse-14066.firebasestorage.app',
        );
      case Flavor.gibical:
        return const FirebaseOptions(
          apiKey: 'AIzaSyCO2pr3YO3HFSePLrqBdx_EqbZPm_Bms2o',
          appId: '1:204876365682:ios:21a92c1bfe2df65a3c67eb',
          messagingSenderId: '204876365682',
          projectId: 'global-harmony-419616',
          storageBucket: 'global-harmony-419616.firebasestorage.app',
          iosClientId: '204876365682-dnkdul88ci375dlephj6c24odoul6inr.apps.googleusercontent.com',
          iosBundleId: 'app.gibical.app',
        );;
      case Flavor.ravi:
        return const FirebaseOptions(
          apiKey: 'AIzaSyDg7cN6iKLoPzEXEbdAf-Oi6kEnY7qt-XY',
          appId: '1:772733695599:android:dcae904c45927083423f9a',
          messagingSenderId: '772733695599',
          projectId: 'mediaverse-14066',
          storageBucket: 'mediaverse-14066.firebasestorage.app',
        );
      default:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
        );
    }
  }

  static FirebaseOptions get _iosFirebaseOptions {
    switch (F.appFlavor) {
      case Flavor.mediaverse:
        return const FirebaseOptions(
          apiKey: 'MEDIAVERSE_IOS_API_KEY',
          appId: 'MEDIAVERSE_IOS_APP_ID',
          messagingSenderId: 'MEDIAVERSE_IOS_SENDER_ID',
          projectId: 'MEDIAVERSE_IOS_PROJECT_ID',
          storageBucket: 'MEDIAVERSE_IOS_STORAGE_BUCKET',
          iosClientId: 'MEDIAVERSE_IOS_CLIENT_ID',
          iosBundleId: 'land.mediaverse.app',
        );
      case Flavor.gibical:
        return const FirebaseOptions(
          apiKey: 'AIzaSyCO2pr3YO3HFSePLrqBdx_EqbZPm_Bms2o',
          appId: '1:204876365682:ios:21a92c1bfe2df65a3c67eb',
          messagingSenderId: '204876365682',
          projectId: 'global-harmony-419616',
          storageBucket: 'global-harmony-419616.firebasestorage.app',
          iosClientId: '204876365682-dnkdul88ci375dlephj6c24odoul6inr.apps.googleusercontent.com',
          iosBundleId: 'app.gibical.app',
        );
      case Flavor.ravi:
        return const FirebaseOptions(
          apiKey: 'YOUR_RAVI_IOS_API_KEY',
          appId: 'YOUR_RAVI_IOS_APP_ID',
          messagingSenderId: 'YOUR_RAVI_IOS_SENDER_ID',
          projectId: 'YOUR_RAVI_IOS_PROJECT_ID',
          storageBucket: 'YOUR_RAVI_IOS_STORAGE_BUCKET',
          iosClientId: 'YOUR_RAVI_IOS_CLIENT_ID',
          iosBundleId: 'ir.app.ravi',
        );
      default:
        return const FirebaseOptions(
          apiKey: '',
          appId: '',
          messagingSenderId: '',
          projectId: '',
        );
    }
  }
}
