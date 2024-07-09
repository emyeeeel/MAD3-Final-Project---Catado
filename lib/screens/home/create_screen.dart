import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {

  static const String route = '/create';
  static const String name = "Create Screen";

  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Create Screen'),
    );
  }
}