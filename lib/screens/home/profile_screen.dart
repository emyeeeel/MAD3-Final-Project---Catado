import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatefulWidget {

  static const String route = '/profile';
  static const String name = "Profile Screen";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late UserDataController userDataController;
  @override
  void initState() {
    super.initState();
    userDataController = UserDataController();
    userDataController
        .listen(FirebaseAuth.instance.currentUser?.uid ?? 'unknown');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userDataController,
      builder: (context, _) {
        return Column(
          children: [
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Row(
                children: [
                  Icon(Icons.lock_outline_rounded),
                  SizedBox(width: 10,),
                  Text('${userDataController.userData!['displayName']}'), 
                  Icon(Icons.keyboard_arrow_down_rounded),
                  Spacer(),
                  Icon(Icons.add_box_rounded),
                  SizedBox(width: 25,),
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
                    backgroundImage: userDataController.userData?['profileImageUrl'] != null &&
                            userDataController.userData!['profileImageUrl'] != ''
                        ? NetworkImage(userDataController.userData!['profileImageUrl'])
                        : const NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                    radius: 50,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('${userDataController.userData!['posts'].length}'), 
                      Text("posts")
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('${userDataController.userData!['followers'].length}'), 
                      Text("followers")
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text('${userDataController.userData!['following'].length}'), 
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
    );
  }
}