import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Replace these values with your actual Firebase project configuration
    return FirebaseOptions(
        apiKey: "AIzaSyC9Lji8w2yPJn6DLUrdT_HOwFK5USZCWK0",
        authDomain: "apdp-d27dd.firebaseapp.com",
        projectId: "apdp-d27dd",
        storageBucket: "apdp-d27dd.appspot.com",
        messagingSenderId: "542592964746",
        appId: "1:542592964746:web:db4f4fa22be951b1627573",
        measurementId: "G-XZT258J9MR"
    );
  }
}