import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  static const String route = '/profile';
  static const String name = "Profile Screen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,0),
          child: Row(
            children: [
              Icon(Icons.lock_outline_rounded),
              Text("display_name"),
              Icon(Icons.keyboard_arrow_down_rounded),
              Spacer(),
              Icon(Icons.add_box),
              Spacer(),
              Icon(Icons.add_box_rounded),
              Spacer(),
              Icon(Icons.menu)
            ],
          ),
        ),
        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20,0,20,0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 50,
              ),
              Spacer(),
              Column(
                children: [
                  Text("#"),
                  Text("posts")
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text("#"),
                  Text("followers")
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text("#"),
                  Text("following")
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.black)
              ),
              child: Center(child: Text("Edit Profile")),
            ),
            const SizedBox(width: 15,),
            Container(
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.black)
              ),
              child: Center(child: Text("Share Profile")),
            ),
            const SizedBox(width: 15,),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.black)
              ),
              child: Icon(Icons.person_add),
            )
          ],
        ),
        Row(
          children: [
            Spacer(),
            Icon(Icons.view_comfy, size: 50,),
            Spacer(),
            Icon(Icons.view_comfy, size: 50),
            Spacer(),
            Icon(Icons.view_comfy, size: 50),
            Spacer(),
          ],
        ),
        const Center(
          child: Text('Profile Screen'),
        ),
      ],
    );
  }
}