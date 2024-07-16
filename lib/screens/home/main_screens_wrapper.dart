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
        items: [
          BottomNavigationBarItem(
            icon: Icon(index == 0 ? Icons.home : Icons.home_outlined, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(index == 1 ? Icons.search : Icons.search_outlined, color: Colors.white),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(index == 2 ? Icons.add : Icons.add_outlined, color: Colors.white),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(index == 3 ? Icons.movie_creation : Icons.movie_creation_outlined, color: Colors.white),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(index == 4 ? Icons.person : Icons.person_outline, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}