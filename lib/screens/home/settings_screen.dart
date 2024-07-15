import 'package:finals/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

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
          children: [
            
          ],
        ),
      )
    );
  }
}
