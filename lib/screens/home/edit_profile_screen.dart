
import 'package:finals/screens/home/edit_bio.dart';
import 'package:finals/screens/home/edit_name.dart';
import 'package:finals/screens/home/edit_username.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controllers/data_controller.dart';
import '../../routing/router.dart';

class EditProfileScreen extends StatefulWidget {

  static const String route = '/edit';
  static const String name = "Edit Profile Screen";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late UserDataController userDataController;

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController pronouns = TextEditingController();
  TextEditingController bio = TextEditingController();
  bool isSelected = true;
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

          String imageURL = userDataController.userData?['profileImageUrl'] ?? 'https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain';
          String nameText = userDataController.userData?['name'] ?? 'Name';
          String usernameText = userDataController.userData?['displayName'] ?? 'Username';
          String pronounsText = userDataController.userData?['pronouns'] ?? 'Pronouns';
          String bioText = userDataController.userData?['bio'] ?? 'Bio';
          String linkText = userDataController.userData?['links'] ?? 'Add Links';
          String genderText = userDataController.userData?['gender'] ?? 'Gender';
          return SingleChildScrollView(
            child: Column(
              children: [
                const Divider(),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(imageURL),
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
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      context: context, 
                      builder: (context) =>  Container(
                        height: MediaQuery.of(context).size.height/2,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            Center(
                              child: Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(100)
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Spacer(),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(imageURL),
                                      radius: 40,
                                    ),
                                    const SizedBox(height: 15,),
                                    isSelected ? Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                    ) : Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                                      radius: 40,
                                    ),
                                    const SizedBox(height: 15,),
                                    !isSelected ? Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                    ) : Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer()
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  },
                  child: const Text("Edit picture or avatar", style: TextStyle(color: Colors.blue),)
                ),
                Column(
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Row(
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(fontSize: 18),
                          ), 
                          const Spacer(),
                          SizedBox(
                            width: 280,
                            child: GestureDetector(
                              onTap: (){
                                GlobalRouter.I.router.go(EditName.route);
                              },
                              child: Text(
                                nameText,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Row(
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(fontSize: 18),
                          ), 
                          const Spacer(),
                          SizedBox(
                            width: 280,
                            child: GestureDetector(
                              onTap: (){
                                GlobalRouter.I.router.go(EditUsername.route);
                              },
                              child: Text(
                                usernameText,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Row(
                        children: [
                          const Text(
                            'Pronouns',
                            style: TextStyle(fontSize: 18),
                          ), 
                          const Spacer(),
                          SizedBox(
                            width: 280,
                            child: Text(
                              pronounsText,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Row(
                        children: [
                          const Text(
                            'Bio',
                            style: TextStyle(fontSize: 18),
                          ), 
                          const Spacer(),
                          SizedBox(
                            width: 280,
                            child: GestureDetector(
                              onTap: (){
                                GlobalRouter.I.router.go(EditBio.route);
                              },
                              child: Text(
                                bioText,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),  
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Row(
                        children: [
                          const Text(
                            'Links',
                            style: TextStyle(fontSize: 18),
                          ), 
                          const Spacer(),
                          SizedBox(
                            width: 260,
                            child: Text(
                              linkText,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,20,10),
                      child: Row(
                        children: [
                          const Text(
                            'Gender',
                            style: TextStyle(fontSize: 18),
                          ), 
                          const Spacer(),
                          SizedBox(
                            width: 260,
                            child: Text(
                              genderText,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
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
            ),
          );
        }
      ),
    );
  }

}