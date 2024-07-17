import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/home/profile/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../controllers/data_controller.dart';
import '../../../routing/router.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  static const String route = '/edit/name';
  static const String name = "Edit Name Screen";

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {

  late UserDataController userDataController;

  TextEditingController name = TextEditingController();

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
            const Text("Name", style: TextStyle(
              fontSize: 18,
            ),),
            const Spacer(),
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text('Are you sure you want to change your name?'),
                    content: const Text('You only change your name twice for 14 days after this.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          showDialog(
                            context: context, 
                            builder: (context) {
                              return const Center(child: CircularProgressIndicator());
                            }
                          );
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          try {
                            await FirebaseFirestore.instance.collection('users').doc(uid).update({
                              'name': name.text.trim(),
                            });
                            print('Name updated successfully');
                            Navigator.pop(context);
                          } catch (e) {
                            print('Error updating name: $e');
                            Navigator.pop(context);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                );
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
          String nameText = userDataController.userData?['name'] ?? '';
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
                              controller: name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: nameText
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: (){
                              name.clear();
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
                    width: MediaQuery.of(context).size.width - 80,
                    height: 70,
                    child: const Text("Help people discover your account by using the name you're known by: either full name, nickname or business name.",
                    style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  SizedBox(width: 20,),
                  Text('You can only change your name twice within 14 days.', style: TextStyle(fontSize: 16),),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}