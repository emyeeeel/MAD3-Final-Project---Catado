import 'package:finals/routing/router.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';

class EditProfileScreen extends StatefulWidget {

  static const String route = '/edit';
  static const String name = "Edit Profile Screen";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GlobalRouter.I.router.go(ProfileScreen.route);
          },
          child: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("Edit Profile"),
      ),
      body: ListenableBuilder(
        listenable: userDataController,
        builder: (context, _) {
          if (userDataController.userData == null) {
            return const Center(
              child: CircularProgressIndicator(), 
            );
          }
          return Column(
            children: [
              const Divider(),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: userDataController.userData!['profileImageUrl'] != ''
                        ? NetworkImage(userDataController.userData!['profileImageUrl'])
                        : const NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                    radius: 40,
                  ),
                  const SizedBox(width: 20,),
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                    radius: 40,
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              const Text("Edit picture or avatar", style: TextStyle(color: Colors.blue),),
              Column(
                children: [
                  const Divider(),
                  rowContent('Name', 'name'),
                  rowContent('Username', 'displayName'),
                  rowContent('Pronouns', 'pronouns'),
                  rowContent('Bio', 'bio'),
                  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Text('Links', style: TextStyle(fontSize: 18),), 
                      Spacer(),
                      SizedBox(
                        width: 280,
                        child: Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add Links',
                              suffixIcon: Icon(Icons.arrow_forward_ios_rounded)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                  const Divider(),
                  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Text('Gender', style: TextStyle(fontSize: 18),), 
                      Spacer(),
                      SizedBox(
                        width: 280,
                        child: Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add Links',
                              suffixIcon: Icon(Icons.arrow_forward_ios_rounded)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Text('Switch to professional account', style: TextStyle(fontSize: 20, color: Colors.blue),),
                    ],
                  ), 
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Text('Personal information settings', style: TextStyle(fontSize: 20, color: Colors.blue),),
                    ],
                  ), 
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  const Row(
                    children: [
                      SizedBox(width: 20,),
                      Text('Show your profile is verified', style: TextStyle(fontSize: 20, color: Colors.blue),),
                    ],
                  ), 
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  Widget rowContent(String label, String content) {
    return Center(
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(fontSize: 18),
          ), 
          const Spacer(),
          SizedBox(
            width: 280,
            child: Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '${userDataController.userData![content]}'
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

}