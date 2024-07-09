import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {

  static const String route = '/notification';
  static const String name = "Notification Screen";

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notification Screen'),
    );
  }
}