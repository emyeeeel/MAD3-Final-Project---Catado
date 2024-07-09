import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  static const String route = '/profile';
  static const String name = "Profile Screen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}