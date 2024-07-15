import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  static Future storeUser(String email, String uid) async {
    return FirebaseFirestore.instance.collection("users").doc(uid).set({
      "userId": uid,
      "email": email,
      "displayName": getEmailUsername(email),
      "followers": [],
      "following": [],
      "posts": [],
      "profileImageUrl": '',
      "bio": ''
    }, SetOptions(merge: true));
  }

  static Future<Map<String, dynamic>?> getUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (!user.exists) {
      throw Exception("The user $uid does not exist in database");
    }
    return user.data();
  }


  static String getEmailUsername(String email) {
    int indexOfAt = email.indexOf('@');
    return email.substring(0, indexOfAt);
  }
}