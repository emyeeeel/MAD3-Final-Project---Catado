import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/controllers/auth_controller.dart';
import 'package:finals/routing/router.dart';
import 'package:finals/screens/auth/login_screen.dart';
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
              Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Column(
                          children: [
                            SizedBox(height: 10,),
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
              const Center(child: Text('Home Page')),
              MaterialButton(
                color: Colors.blueGrey,
                onPressed: (){
                  AuthController.I.logout();
                },
                child: Text('Log out'),
              ),
              MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: () async {
                     if(FirebaseAuth.instance.currentUser != null){
                      print("Current user: ${FirebaseAuth.instance.currentUser!.email}");
                     }else{
                      print("No user signed in");
                     }
                  },
                  child: Text('Check current user'),
              ),
              Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white)
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('posts').where('user', isEqualTo: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid)).snapshots(), //where user ref userId should be current authenticated user uid
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
                        final String postId = doc.id;
                        final Timestamp postTime = doc.get('time');
                        final DocumentReference userRef = doc.get('user');
                        // final DocumentSnapshot userData = userRef.
                        final String url = doc.get('photoUrl');
                        return SizedBox(
                          child: Column(
                            children: [
                              Image.network(url, fit: BoxFit.cover,),
                              Row(
                                children: [
                                  Icon(Icons.favorite),
                                  Icon(Icons.comment),
                                  Icon(Icons.send),
                                ],
                              ),
                              Text('${userRef}')
                            ],
                          ),
                        );
                      }, 
                    );
                  },
                  ),
                )
            ],
          );
        }
      ),
    );
  }
}