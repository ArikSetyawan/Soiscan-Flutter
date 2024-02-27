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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCyhuS0TVeduASOWUmn2AcQ_X2rJxDSSg0',
    appId: '1:642314366675:web:6e052791fd597dde17ae26',
    messagingSenderId: '642314366675',
    projectId: 'soiscan-858cc',
    authDomain: 'soiscan-858cc.firebaseapp.com',
    storageBucket: 'soiscan-858cc.appspot.com',
    measurementId: 'G-PSFT8M2QG0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPi9bvLRiG8H7g9whJZflj4M53HjX8iUA',
    appId: '1:642314366675:android:751306728916b53f17ae26',
    messagingSenderId: '642314366675',
    projectId: 'soiscan-858cc',
    storageBucket: 'soiscan-858cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEH6ajWtLguLNPgKVcurAopRKELPt1R4s',
    appId: '1:642314366675:ios:66e9b982c9f7318f17ae26',
    messagingSenderId: '642314366675',
    projectId: 'soiscan-858cc',
    storageBucket: 'soiscan-858cc.appspot.com',
    iosBundleId: 'com.example.soiscan',
  );
}
