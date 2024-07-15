import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/home/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';
import '../../routing/router.dart';

class EditBio extends StatefulWidget {
  const EditBio({super.key});

  static const String route = '/edit/bio';
  static const String name = "Edit Bio Screen";

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  late UserDataController userDataController;
  TextEditingController bio = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDataController = UserDataController();
    userDataController.listen(FirebaseAuth.instance.currentUser?.uid ?? 'unknown');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GlobalRouter.I.router.go(EditProfileScreen.route);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            const Spacer(),
            const Text(
              "Bio",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
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
                    'bio': bio.text.trim(),
                  });
                  print('Bio updated successfully');
                  Navigator.pop(context);
                } catch (e) {
                  print('Error updating bio: $e');
                  Navigator.pop(context);
                }
                GlobalRouter.I.router.go(EditProfileScreen.route);
              },
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            )
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: userDataController,
        builder: (context, _) {
          String bioText = userDataController.userData?['bio'] ?? '';
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: bio,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: bioText,
              ),
              maxLines: null,
            ),
          );
        },
      ),
    );
  }
}
