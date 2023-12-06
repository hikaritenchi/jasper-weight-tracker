// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDTuZzJogmJfwZB-C9KfSV33yo8MXTbI0I',
    appId: '1:521690390995:web:c1b762191efd570aa20f26',
    messagingSenderId: '521690390995',
    projectId: 'jasper-weight-tracker',
    authDomain: 'jasper-weight-tracker.firebaseapp.com',
    storageBucket: 'jasper-weight-tracker.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBm1g0x0o3q2X1WnEe8ibxsog1qvD9RLA',
    appId: '1:521690390995:android:cfcb83d24f25c284a20f26',
    messagingSenderId: '521690390995',
    projectId: 'jasper-weight-tracker',
    storageBucket: 'jasper-weight-tracker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHSQQEf4runnjix9MtEUYaF5ZGiAoe89g',
    appId: '1:521690390995:ios:895b14d2b102460ba20f26',
    messagingSenderId: '521690390995',
    projectId: 'jasper-weight-tracker',
    storageBucket: 'jasper-weight-tracker.appspot.com',
    iosBundleId: 'com.example.jasperWeightTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHSQQEf4runnjix9MtEUYaF5ZGiAoe89g',
    appId: '1:521690390995:ios:bf2420138238d065a20f26',
    messagingSenderId: '521690390995',
    projectId: 'jasper-weight-tracker',
    storageBucket: 'jasper-weight-tracker.appspot.com',
    iosBundleId: 'com.example.jasperWeightTracker.RunnerTests',
  );
}