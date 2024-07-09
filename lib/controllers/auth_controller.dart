import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../enum/enum.dart';

class AuthController with ChangeNotifier {
  // Static method to initialize the singleton in GetIt
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  // Static getter to access the instance through GetIt
  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();

  AuthState state = AuthState.unauthenticated;

  late StreamSubscription<User?> currentAuthedUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  listen() {
    currentAuthedUser =
        FirebaseAuth.instance.authStateChanges().listen(handleUserChanges);
  }

  void handleUserChanges(User? user) {
    if (user == null) {
      state = AuthState.unauthenticated;
      notifyListeners();
    } else {
      state = AuthState.authenticated;
      notifyListeners();
      // FirestoreService.storeUser(user.email ?? "No email available", user.uid);
    }
  }

  login(String userName, String password) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userName, password: password);
    } on FirebaseAuthException catch(e){
      print("${e.code}: ${e.message}");
      throw Exception(e);
    }
    // User? user  = userCredential.user;
  }

  register(String userName, String password) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userName, password: password);
    } on FirebaseAuthException catch(e){
      print("${e.code}: ${e.message}");
      throw Exception(e);
    }
    // User? user  = userCredential.user;
  }

  signInWithGoogle() async {
    GoogleSignInAccount? gSign = await _googleSignIn.signIn();
    if (gSign == null) throw Exception("No Signed in account");
    GoogleSignInAuthentication googleAuth = await gSign.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  ///write code to log out the user and add it to the home page.
  logout() {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.signOut();
    }
    return FirebaseAuth.instance.signOut();
  }

  ///must be called in main before runApp
  ///
  loadSession() async {
    listen();
    User? user = FirebaseAuth.instance.currentUser;
    handleUserChanges(user);
  }
}