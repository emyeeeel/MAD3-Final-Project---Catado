import 'package:finals/controllers/auth_controller.dart';
import 'package:finals/routing/router.dart';
import 'package:finals/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String route = '/home';
  static const String name = "Home Screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Home Page')),
          MaterialButton(
            color: Colors.blueGrey,
            onPressed: (){
              GlobalRouter.I.router.go(LoginScreen.route);
            }
          ),
          MaterialButton(
            color: Colors.blueGrey,
            onPressed: (){
              AuthController.I.logout();
            },
            child: Text('Log out'),
          ),
                      MaterialButton(
              color: Colors.blueAccent,
              onPressed: () async {
                 if(FirebaseAuth.instance.currentUser != null){
                  print("Current user: ${FirebaseAuth.instance.currentUser!.email}");
                 }else{
                  print("No user signed in");
                 }
              },
              child: Text('Check current user'),
            ),
        ],
      ),
    );
  }
}