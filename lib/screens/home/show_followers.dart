import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/routing/router.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';

class ShowFollowersScreen extends StatefulWidget {
  static const String route = '/profile/followers';
  static const String name = "Show Followers Screen";
  const ShowFollowersScreen({super.key});
  @override
  State<ShowFollowersScreen> createState() => _ShowFollowersScreenState();
}

class _ShowFollowersScreenState extends State<ShowFollowersScreen> {
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
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                GlobalRouter.I.router.go(ProfileScreen.route);
              },
              child: const Icon(Icons.arrow_back_ios)),
            title: Text('${userDataController.userData!['displayName']}', style: const TextStyle(fontSize: 16),),
            centerTitle: true,
          ),
          body: userDataController.userData!['followers'].length == 0 ? const Center(child: Text('No followers'),) : SizedBox(
            width: double.infinity,
            height: double.infinity,
             child: ListView.builder(
              itemCount: userDataController.userData!['followers'].length,
              itemBuilder: (context, index) {
                return FutureBuilder<DocumentSnapshot>(
                  future: userDataController.userData!['followers'][index].get(),
                  builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(); 
                }
                Map<String, dynamic> documentData = snapshot.data!.data() as Map<String, dynamic>;
                    return SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,10,0,10),
                        child: Row(
                          children: [
                            const SizedBox(width: 20,),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(documentData['profileImageUrl']),
                            ),
                            const SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(documentData['displayName']),
                                Text(documentData['name']),
                              ],
                            ),
                            const Spacer(),
                            MaterialButton(
                              onPressed: (){
                                
                              },
                              minWidth: 100,
                              height: 30,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: const Color.fromARGB(255, 40, 40, 40),
                              child: const Text("Message", style: TextStyle(fontSize: 12),),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.circle, size: 5,),
                            const SizedBox(width: 3),
                            const Icon(Icons.circle, size: 5,),
                            const SizedBox(width: 3),
                            const Icon(Icons.circle, size: 5,),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ));
                  }
                );
              }
              )
            )
        );
      }
    );
  }
}