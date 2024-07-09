import 'package:finals/screens/home/create_screen.dart';
import 'package:finals/screens/home/notification_screen.dart';
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
  List<String> routes = [HomeScreen.route, SearchScreen.route, CreateScreen.route, NotificationScreen.route, ProfileScreen.route];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child ?? const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
            // GoRouter.of(context).go(routes[i]);
            GlobalRouter.I.router.go(routes[i]);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.black), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.black), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications, color: Colors.black), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: 'Profile'),
        ]
      ),
    );
  }
}