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
    apiKey: 'AIzaSyAmrIQE9ZBodjvH7NLfLdqgodTBm7HXK_Y',
    appId: '1:224678654533:web:5cb18df31e021587cba92c',
    messagingSenderId: '224678654533',
    projectId: 'reddit-clone-2c517',
    authDomain: 'reddit-clone-2c517.firebaseapp.com',
    storageBucket: 'reddit-clone-2c517.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB4rDhPKa2sXURzEbN8BSPFy2sXm1oCFVI',
    appId: '1:224678654533:android:06722773635f8f5fcba92c',
    messagingSenderId: '224678654533',
    projectId: 'reddit-clone-2c517',
    storageBucket: 'reddit-clone-2c517.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDox0YYnkrdIZHIOjBswRv_TCpjy7E1V3Y',
    appId: '1:224678654533:ios:468030d8f40568c4cba92c',
    messagingSenderId: '224678654533',
    projectId: 'reddit-clone-2c517',
    storageBucket: 'reddit-clone-2c517.appspot.com',
    iosClientId:
        '224678654533-jk3tri2bqegm0qbo9skjkqvqq6kg52cp.apps.googleusercontent.com',
    iosBundleId: 'com.example.redditClone',
  );
}
