import 'package:finals/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../routing/router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String route = '/profile/settings';
  static const String name = "Settings Screen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            GlobalRouter.I.router.go(ProfileScreen.route);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text("Settings and Activity"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.search),
                  SizedBox(width: 5,),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 18
                        )
                      ),
                    ),
                  )
                ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(width: 1, color: Colors.white)
              // ),
              child: Column(
                children: [
                  Text('Your account'),
                  Row(
                    children: [
                      Icon(Icons.person),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Accounts Center'),
                          Text('Password, security, personal details, ad preferences')
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text('Manage your connected experiences and account settings across Meta Technologies. Learn more')
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Divider(thickness: 5,),
            const SizedBox(height: 10,),
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(width: 1, color: Colors.white)
              // ),
              child: Column(
                children: [
                  Text('How you use Instagram'),
                  Row(
                    children: [
                      Icon(Icons.saved_search),
                      Text('Saved'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.saved_search),
                      Text('Saved'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.saved_search),
                      Text('Saved'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.saved_search),
                      Text('Saved'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.saved_search),
                      Text('Saved'),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                AuthController.I.logout();
              },
              child: Text('Log out', style: TextStyle(color: Colors.red, fontSize: 18),))
          ],
        ),
      )
    );
  }
}
