import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static Future storeUser(String email, String uid,
      {DateTime? signInTime}) async {
    return FirebaseFirestore.instance.collection("users").doc(uid).set({
      "uid": uid,
      "email": email,
      if (signInTime != null) "lastSignIn": signInTime
    }, SetOptions(merge: true));
  }
}