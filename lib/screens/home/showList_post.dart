import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/routing/router.dart';
import 'package:finals/screens/home/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';
import '../../widgets/post_item.dart';

class ShowUserPostsScreen extends StatefulWidget {
  static const String route = '/profile/showPostList';
  static const String name = "ShowPostList Screen";
  const ShowUserPostsScreen({super.key});
  @override
  State<ShowUserPostsScreen> createState() => _ShowUserPostsScreenState();
}

class _ShowUserPostsScreenState extends State<ShowUserPostsScreen> {
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
            title: Column(
              children: [
                Text('${userDataController.userData!['displayName']}', style: const TextStyle(fontSize: 16),),
                const Text('Posts', style: TextStyle(fontSize: 16),)
              ],
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
             child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('posts').where('user', isEqualTo: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator(); 
                }
                List<DocumentSnapshot> sortedDocs = snapshot.data!.docs.toList()
                  ..sort((a, b) => b.get('time').compareTo(a.get('time')));
                return ListView.builder(
                  itemCount: sortedDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final doc = sortedDocs[index];
                    DocumentReference userRef = doc['user']; 
                    return FutureBuilder<DocumentSnapshot>(
                      future: userRef.get(), 
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(); 
                        } else if (userSnapshot.hasError) {
                          return Text('Error: ${userSnapshot.error}');
                        } else {
                          final user = userSnapshot.data!;
                          return PostItem(postSnapshot: doc, userSnapshot: user);
                        }
                      },
                    );
                  },
                );
              },
            ),
            )
        );
      }
    );
  }
}