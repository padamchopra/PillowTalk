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
    apiKey: 'AIzaSyC4polf-Nl6ENqWpZEx05JgmjqH84wFoz4',
    appId: '1:818796853809:web:13e6ee310272af988a3310',
    messagingSenderId: '818796853809',
    projectId: 'pillowtalk-20220806',
    authDomain: 'pillowtalk-20220806.firebaseapp.com',
    storageBucket: 'pillowtalk-20220806.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAw1Hm9iCrz--XTNbts1po3BJQ9aNPKJQw',
    appId: '1:818796853809:android:103dbe83185b17658a3310',
    messagingSenderId: '818796853809',
    projectId: 'pillowtalk-20220806',
    storageBucket: 'pillowtalk-20220806.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9HpEEhG5DfHWX5KRL5inU5KpNREhiTAE',
    appId: '1:818796853809:ios:32955ceb782f84ae8a3310',
    messagingSenderId: '818796853809',
    projectId: 'pillowtalk-20220806',
    storageBucket: 'pillowtalk-20220806.appspot.com',
    iosClientId: '818796853809-5d1h2n5gu90kof0grq39kl3kii5cg7tf.apps.googleusercontent.com',
    iosBundleId: 'me.padamchopra.pillowtalk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9HpEEhG5DfHWX5KRL5inU5KpNREhiTAE',
    appId: '1:818796853809:ios:32955ceb782f84ae8a3310',
    messagingSenderId: '818796853809',
    projectId: 'pillowtalk-20220806',
    storageBucket: 'pillowtalk-20220806.appspot.com',
    iosClientId: '818796853809-5d1h2n5gu90kof0grq39kl3kii5cg7tf.apps.googleusercontent.com',
    iosBundleId: 'me.padamchopra.pillowtalk',
  );
}
