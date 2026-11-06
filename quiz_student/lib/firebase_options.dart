import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        // Fallback until platform-specific FlutterFire configuration is added.
        return web;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCEUE_DkH1AujUPho93CH4vCpMlR8pxjLg',
    appId: '1:416138549404:web:e5cae450bf1dc996587559',
    messagingSenderId: '416138549404',
    projectId: 'caquizapp-29419',
    authDomain: 'caquizapp-29419.firebaseapp.com',
    storageBucket: 'caquizapp-29419.firebasestorage.app',
    measurementId: 'G-RBVZVS4LMB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqpN6_ETmvCjNGEh-DrL9hWdXwE7yB3YU',
    appId: '1:416138549404:android:98580f564bdc328f587559',
    messagingSenderId: '416138549404',
    projectId: 'caquizapp-29419',
    storageBucket: 'caquizapp-29419.firebasestorage.app',
  );

}