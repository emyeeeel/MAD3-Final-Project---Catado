import 'package:finals/controllers/auth_controller.dart';
import 'package:finals/routing/router.dart';
import 'package:finals/screens/auth/signup_screen.dart';
import 'package:finals/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = '/login';
  static const String name = "Login Screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Login Screen')),
            const SizedBox(height: 50,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width *.80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  hintText: 'Phone number, username, email',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width *.80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none,
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width *.80,
              child: const Row(
                children: [
                  Spacer(),
                  Text('Forgot password?', style: TextStyle(color: Color(0xFF0297FC)),),
                ],
              )
            ),
            MaterialButton(
              height: 50,
              minWidth: MediaQuery.of(context).size.width *.80,
              color: const Color(0xFF0297FC),
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(8)
              ),
              onPressed: () async {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return const Center(child: CircularProgressIndicator());
                  }
                );
                await AuthController.I.login(email.text.trim(), password.text.trim());
                Navigator.pop(context);
              },
              child: Text("Log in", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width *.80,
              child: Row(
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width *.75) / 2 ,
                    child: const Divider()
                  ),
                  const Spacer(),
                  const Text('OR'),
                  const Spacer(),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width *.75) / 2,
                    child: const Divider()
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *.80,
              height: 50,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //add network image here
                  Text("Log in with Google"),
                ],
              )
            ),
            RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(fontWeight: FontWeight.normal, color:  Colors.black), 
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(fontWeight: FontWeight.bold, color:  Colors.blue), 
                        recognizer: TapGestureRecognizer()..onTap = () {
                          print('button tapped!');
                          GlobalRouter.I.router.go(SignupScreen.route);
                        },
                      ), 
                    ],
                  ),
                ),
            // MaterialButton(
            //   color: Colors.greenAccent,
            //   onPressed: () async {
            //     GlobalRouter.I.router.go(SignupScreen.route);
            //   },
            //   child: Text('Create'),
            // ),
            // MaterialButton(
            //   color: Colors.yellowAccent,
            //   onPressed: () async {
            //     try{
            //       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
            //     } on FirebaseAuthException catch(e){
            //       print("${e.code}: ${e.message}");
            //     }
            //   },
            //   child: Text('Sign in'),
            // ),
            // MaterialButton(
            //   color: Colors.blueAccent,
            //   onPressed: () async {
            //      await FirebaseAuth.instance.signOut();
            //   },
            //   child: Text('Log out'),
            // ),
          ],
        ),
      );
  }
}
