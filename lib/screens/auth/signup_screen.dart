import 'package:finals/controllers/auth_controller.dart';
import 'package:finals/screens/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../routing/router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String route = '/signup';
  static const String name = "Signup Screen";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isPassClicked = false;
  bool isConfirmClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text('Sign up Screen')),
            const SizedBox(height: 50,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width *.80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
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
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextField(
                obscureText: isPassClicked ? false : true,
                controller: password,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  border: InputBorder.none,
                  hintText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        isPassClicked = !isPassClicked;
                       });
                      },
                    child: Icon(isPassClicked ? Icons.visibility : Icons.visibility_off)),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width *.80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(8)
              ),
              child: TextField(
                obscureText: isConfirmClicked ? false : true,
                controller: confirmPassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  border: InputBorder.none,
                  hintText: 'Confirm Password',
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        isConfirmClicked = !isConfirmClicked;
                       });
                      },
                    child: Icon(isConfirmClicked ? Icons.visibility : Icons.visibility_off)),
                ),
              ),
            ),
            const SizedBox(height: 20,),
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
                if(password.text.trim() == confirmPassword.text.trim()){
                  try{
                    await AuthController.I.register(email.text.trim(), password.text.trim());
                    Navigator.pop(context);
                  }catch(e){
                    AlertDialog(
                      title: const Text('Error occured!'),
                      content: Text('$e'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Okay'),
                          child: const Text('Okay'),
                        ),
                      ],
                    );
                  }
                }
                else{
                  AlertDialog(
                      title: const Text('Sign up error'),
                      content: const Text('Password do not match!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Okay'),
                          child: const Text('Okay'),
                        ),
                      ],
                    );
                }
              },
              child: const Text("Sign up", style: TextStyle(color: Colors.white),),
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
                  Text("Sign up with Google"),
                ],
              )
            ),
            RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(fontWeight: FontWeight.normal, color:  Colors.white), 
                      ),
                      TextSpan(
                        text: "Sign in",
                        style: const TextStyle(fontWeight: FontWeight.bold, color:  Colors.blue), 
                        recognizer: TapGestureRecognizer()..onTap = () {
                          print('button tapped!');
                          GlobalRouter.I.router.go(LoginScreen.route);
                        },
                      ), 
                    ],
                  ),
                ),
            // MaterialButton(
            //   color: Colors.greenAccent,
            //   onPressed: () async {
            //      try{
            //       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
            //      } catch (e) {
            //       print(e.toString());
            //     }
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
          ],
        ),
      );
  }
}
