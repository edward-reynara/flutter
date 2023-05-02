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
    apiKey: 'AIzaSyAVvtXWSKmdzS2MZg9JMdKnKpazKbBM4Ps',
    appId: '1:606165047355:web:81be0b6b9fa7796bf5e41e',
    messagingSenderId: '606165047355',
    projectId: 'warranty-14c4f',
    authDomain: 'warranty-14c4f.firebaseapp.com',
    storageBucket: 'warranty-14c4f.appspot.com',
    measurementId: 'G-CD3G005JGG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzS6LtKUwRxeYv41BCemVDKGtbvjpaTpM',
    appId: '1:606165047355:android:ef80e598512aaad4f5e41e',
    messagingSenderId: '606165047355',
    projectId: 'warranty-14c4f',
    storageBucket: 'warranty-14c4f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC42Wi2XuIb4NEHam6M-XTB1H407Wi9x3s',
    appId: '1:606165047355:ios:c8ed3f37dda9ba5af5e41e',
    messagingSenderId: '606165047355',
    projectId: 'warranty-14c4f',
    storageBucket: 'warranty-14c4f.appspot.com',
    iosClientId: '606165047355-a36css0mjdij5lh1u6holdeshvlutfkq.apps.googleusercontent.com',
    iosBundleId: 'id.iwarranty.iwarranty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC42Wi2XuIb4NEHam6M-XTB1H407Wi9x3s',
    appId: '1:606165047355:ios:c8ed3f37dda9ba5af5e41e',
    messagingSenderId: '606165047355',
    projectId: 'warranty-14c4f',
    storageBucket: 'warranty-14c4f.appspot.com',
    iosClientId: '606165047355-a36css0mjdij5lh1u6holdeshvlutfkq.apps.googleusercontent.com',
    iosBundleId: 'id.iwarranty.iwarranty',
  );
}
