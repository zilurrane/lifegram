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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBRmecvXcwOYRPfpGvLtxA5LuQQsqNuoBU',
    appId: '1:504082815816:web:97b4269da2f83411d7f17d',
    messagingSenderId: '504082815816',
    projectId: 'lifegram-1',
    authDomain: 'lifegram-1.firebaseapp.com',
    storageBucket: 'lifegram-1.appspot.com',
    measurementId: 'G-LKM1K8HK41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWN27zYTsHsEThGmYe94O9EzejM_a7mDg',
    appId: '1:504082815816:android:a72d1d7986694c91d7f17d',
    messagingSenderId: '504082815816',
    projectId: 'lifegram-1',
    storageBucket: 'lifegram-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBa5K9itZE1UCH55KrPJLuuPtfDFkg1-KM',
    appId: '1:504082815816:ios:b786dce2166b398bd7f17d',
    messagingSenderId: '504082815816',
    projectId: 'lifegram-1',
    storageBucket: 'lifegram-1.appspot.com',
    androidClientId: '504082815816-jqo6rmefevtgcll8b7o86gce1rno6o82.apps.googleusercontent.com',
    iosClientId: '504082815816-ee29on6ta10s2krevu4oqnm7dsa1psmv.apps.googleusercontent.com',
    iosBundleId: 'com.lifegram',
  );
}
