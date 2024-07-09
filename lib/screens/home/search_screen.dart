import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {

  static const String route = '/search';
  static const String name = "Search Screen";

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen'),
    );
  }
}