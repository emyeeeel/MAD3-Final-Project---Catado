import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/home/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';
import '../../routing/router.dart';

class EditUsername extends StatefulWidget {
  const EditUsername({super.key});

  static const String route = '/edit/username';
  static const String name = "Edit Username Screen";

  @override
  State<EditUsername> createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {

  late UserDataController userDataController;

  TextEditingController username = TextEditingController();

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
            GlobalRouter.I.router.go(EditProfileScreen.route);
          },
          child: const Icon(Icons.arrow_back_ios)),
        title: Row(
          children: [
            const Spacer(),
            const Text("Username", style: TextStyle(
              fontSize: 18,
            ),),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return const Center(child: CircularProgressIndicator());
                  }
                );
                String uid = FirebaseAuth.instance.currentUser!.uid;
                          try {
                            await FirebaseFirestore.instance.collection('users').doc(uid).update({
                              'displayName': username.text.trim(),
                            });
                            print('Username updated successfully');
                            Navigator.pop(context);
                          } catch (e) {
                            print('Error updating username: $e');
                            Navigator.pop(context);
                          }
              },
              child: const Text('Done', style: TextStyle(
                fontSize: 18,
                color: Colors.blue
              ),),
            )
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: userDataController,
        builder: (context, _) {
          String usernameText = userDataController.userData?['displayName'] ?? '';
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      const Row(
                        children: [
                          SizedBox(width: 20,),
                          Text("Name"),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          Expanded(
                            child: TextField(
                              controller: username,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: usernameText
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              username.clear();
                            },
                            child: const Icon(Icons.close_rounded)
                          ),
                          const SizedBox(width: 20,),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const SizedBox(width: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 70,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        children: [
                          const TextSpan(
                            text: "In most cases, you'll be able to change your username back to ",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: usernameText,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          const TextSpan(
                            text: " for another 14 days. ",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          const TextSpan(
                            text: "Learn more",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ],
          );
        }
      ),
    );
  }
}