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
    apiKey: 'AIzaSyCud0pgdbjonWSqSuCsvUoG7p0kYcFw-l4',
    appId: '1:1049799905726:web:92537a28e192e6c967e9ef',
    messagingSenderId: '1049799905726',
    projectId: 'shopping-flutter-project',
    authDomain: 'shopping-flutter-project.firebaseapp.com',
    storageBucket: 'shopping-flutter-project.appspot.com',
    measurementId: 'G-8ZLDGVVLFS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9s-0Ox18Yq03I0iUggiRUVulPv6yzKqY',
    appId: '1:1049799905726:android:821949b8fe7fc5ce67e9ef',
    messagingSenderId: '1049799905726',
    projectId: 'shopping-flutter-project',
    storageBucket: 'shopping-flutter-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-AkFmnH8rDtu0aHZuB7okaF69yl5oAh0',
    appId: '1:1049799905726:ios:de5a51c710600d4c67e9ef',
    messagingSenderId: '1049799905726',
    projectId: 'shopping-flutter-project',
    storageBucket: 'shopping-flutter-project.appspot.com',
    androidClientId: '1049799905726-7om8t01jbrj3gtci3mgoh1n6faccgglt.apps.googleusercontent.com',
    iosClientId: '1049799905726-teid5klrcflfkqekm8ampud0310v5ud1.apps.googleusercontent.com',
    iosBundleId: 'com.example.shopMart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-AkFmnH8rDtu0aHZuB7okaF69yl5oAh0',
    appId: '1:1049799905726:ios:e7e17572aaf579b267e9ef',
    messagingSenderId: '1049799905726',
    projectId: 'shopping-flutter-project',
    storageBucket: 'shopping-flutter-project.appspot.com',
    androidClientId: '1049799905726-7om8t01jbrj3gtci3mgoh1n6faccgglt.apps.googleusercontent.com',
    iosClientId: '1049799905726-d64r0pr0269fj4pqqnqars6217peopo2.apps.googleusercontent.com',
    iosBundleId: 'com.example.shopMart.RunnerTests',
  );
}
