// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAqPSvLxKnvtHN2fnVxsGrQwLE2hJdskZY',
    appId: '1:969138196401:web:2e9109910204c6dcf53790',
    messagingSenderId: '969138196401',
    projectId: 'plant-it-289da',
    authDomain: 'plant-it-289da.firebaseapp.com',
    storageBucket: 'plant-it-289da.appspot.com',
    measurementId: 'G-PGG0KLSNJG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCti_UcEqW4KL-ZSYvu4AwmyfXY4Jjx1g',
    appId: '1:969138196401:android:044a093fe221a4abf53790',
    messagingSenderId: '969138196401',
    projectId: 'plant-it-289da',
    storageBucket: 'plant-it-289da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaiJekF9eKF-EowMNi9bzvlrPaAaiKECI',
    appId: '1:969138196401:ios:2e12e9729ba0277bf53790',
    messagingSenderId: '969138196401',
    projectId: 'plant-it-289da',
    storageBucket: 'plant-it-289da.appspot.com',
    iosBundleId: 'com.example.plantIt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaiJekF9eKF-EowMNi9bzvlrPaAaiKECI',
    appId: '1:969138196401:ios:2e12e9729ba0277bf53790',
    messagingSenderId: '969138196401',
    projectId: 'plant-it-289da',
    storageBucket: 'plant-it-289da.appspot.com',
    iosBundleId: 'com.example.plantIt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAqPSvLxKnvtHN2fnVxsGrQwLE2hJdskZY',
    appId: '1:969138196401:web:45e210610e7c2d82f53790',
    messagingSenderId: '969138196401',
    projectId: 'plant-it-289da',
    authDomain: 'plant-it-289da.firebaseapp.com',
    storageBucket: 'plant-it-289da.appspot.com',
    measurementId: 'G-8RSTJNWEJS',
  );
}
