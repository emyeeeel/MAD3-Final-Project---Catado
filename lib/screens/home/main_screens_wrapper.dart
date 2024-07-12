import 'package:finals/screens/home/create_screen.dart';
import 'package:finals/screens/home/reels_screen.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:finals/screens/home/search_screen.dart';
import 'package:flutter/material.dart';

import '../../routing/router.dart';
import 'home_screen.dart';

class Wrapper extends StatefulWidget {
  final Widget? child;
  const Wrapper({super.key, this.child});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int index = 0;
  List<String> routes = [HomeScreen.route, SearchScreen.route, CreateScreen.route, ReelsScreen.route, ProfileScreen.route];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child ?? const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            // GoRouter.of(context).go(routes[i]);
            GlobalRouter.I.router.go(routes[i]);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.white), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined, color: Colors.white), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white), label: 'Profile'),
        ]
      ),
    );
  }
}