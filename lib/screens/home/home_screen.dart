import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/widgets/post_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/data_controller.dart';

class HomeScreen extends StatefulWidget {

  static const String route = '/home';
  static const String name = "Home Screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Instagram"),
            Spacer(),
            Icon(Icons.favorite_outline_rounded),
            SizedBox(width: 20,),
            Icon(Icons.message),
          ],
        ),
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
              SizedBox(
                width: double.infinity,
                height: 110,
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    Column(
                          children: [
                            const SizedBox(height: 10,),
                            SizedBox(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                    child: CircleAvatar(
                                      backgroundImage: userDataController.userData!['profileImageUrl'] != ''
                              ? NetworkImage(userDataController.userData!['profileImageUrl'])
                              : const NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                                      radius: 25,
                                    ),
                                  ),
                                  Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 25,
                            height: 25,
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Text("Your Story")
                          ],
                        )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('posts').where('user', isNotEqualTo: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid)).snapshots(), 
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      if (snapshot.data!.docs.isEmpty) {
                        return Text('No posts found');
                      }
                      List<DocumentSnapshot> sortedDocs = snapshot.data!.docs.toList()
                      ..sort((a, b) => b.get('time').compareTo(a.get('time')));
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = sortedDocs[index];
                          final DocumentReference userRef = doc.get('user');

                          return SizedBox(
                            child: FutureBuilder<DocumentSnapshot>(
                            future: userRef.get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                              if (userSnapshot.hasError) {
                                return Text('Error retrieving user');
                              }
                              if (userSnapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (!userSnapshot.hasData) {
                                return Text('User not found');
                              }
                              final userData = userSnapshot.data!;
                              return PostItem(postSnapshot: doc, userSnapshot: userData);
                            },
                          ),
                          );
                        }, 
                      );
                    },
                    ),
                  ),
              )
            ],
          );
        }
      ),
    );
  }
}