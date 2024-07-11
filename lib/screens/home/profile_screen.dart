import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/data_controller.dart';
import '../../routing/router.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';
  static const String name = "Profile Screen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserDataController userDataController;

  @override
  void initState() {
    super.initState();
    userDataController = UserDataController();
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
    userDataController.listen(userId);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userDataController,
      builder: (context, _) {
        if (userDataController.userData == null) {
            return const Center(
              child: CircularProgressIndicator(), 
            );
        }
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Row(
                  children: [
                    const Icon(Icons.lock_outline_rounded),
                    const SizedBox(width: 10,),
                    Text('${userDataController.userData!['displayName'] ?? 'Unknown'}'), 
                    const Icon(Icons.keyboard_arrow_down_rounded),
                    const Spacer(),
                    const Icon(Icons.add_box_rounded),
                    const SizedBox(width: 25,),
                    const Icon(Icons.menu)
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: userDataController.userData!['profileImageUrl'] != ''
                              ? NetworkImage(userDataController.userData!['profileImageUrl'])
                              : const NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('${userDataController.userData!['posts']?.length ?? 0}'), 
                        const Text("posts")
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('${userDataController.userData!['followers']?.length ?? 0}'), 
                        const Text("followers")
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('${userDataController.userData!['following']?.length ?? 0}'), 
                        const Text("following")
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: Row(
                        children: [
                          Text('${userDataController.userData!['name'] ?? ''}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: Row(
                        children: [
                          Text('${userDataController.userData!['bio'] ?? ''}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: Row(
                        children: [
                          Text('${userDataController.userData!['links'] ?? ''}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      GlobalRouter.I.router.go(EditProfileScreen.route);
                    },
                    child: Container(
                      width: 150,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.white)
                      ),
                      child: const Center(child: Text("Edit Profile")),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Container(
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.white)
                    ),
                    child: const Center(child: Text("Share Profile")),
                  ),
                  const SizedBox(width: 15,),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.white)
                    ),
                    child: const Icon(Icons.person_add),
                  )
                ],
              ),
              const Row(
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
          ),
        );
      },
    );
  }
}
