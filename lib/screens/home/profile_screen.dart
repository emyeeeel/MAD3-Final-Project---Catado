import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/home/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/data_controller.dart';
import '../../routing/router.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';
  static const String name = "Profile Screen";

  const ProfileScreen({super.key});

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
          appBar: AppBar(
            title: Row(
              children: [
                const Icon(Icons.lock_outline_rounded),
                const SizedBox(width: 10,),
                Text('${userDataController.userData!['displayName'] ?? 'Unknown'}'), 
                const Icon(Icons.keyboard_arrow_down_rounded),
                const Spacer(),
                const Icon(Icons.add_box_rounded),
                const SizedBox(width: 25,),
                GestureDetector(
                  onTap: (){
                    GlobalRouter.I.router.go(SettingsScreen.route);
                  },
                  child: const Icon(Icons.menu))
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
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
                            InkWell(child: Text('${userDataController.userData!['links'] ?? ''}', style: const TextStyle(
                              color: Colors.blue,
                            ),),),
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
                    MaterialButton(
                      onPressed: (){
                        GlobalRouter.I.router.go(EditProfileScreen.route);
                      },
                      minWidth: 150,
                      height: 35,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: const Color.fromARGB(255, 40, 40, 40),
                      child: const Text("Edit Profile"),
                    ),
                    const SizedBox(width: 15,),
                    MaterialButton(
                      onPressed: (){
                        
                      },
                      minWidth: 150,
                      height: 35,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: const Color.fromARGB(255, 40, 40, 40),
                      child: const Text("Share Profile"),
                    ),
                    const SizedBox(width: 15,),
                    MaterialButton(
                      onPressed: (){
                        
                      },
                      minWidth: 35,
                      height: 35,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: const Color.fromARGB(255, 40, 40, 40),
                      child: const Icon(Icons.person_add),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white)
                  ),
                  child: const Row(
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
                                    backgroundColor: Color.fromARGB(255, 40, 40, 40),
                                    radius: 25,
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  bottom: 15,
                                  child: Icon(Icons.add, size: 30,))
                              ],
                            ),
                          ),
                          Text("New")
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text('Profile Screen'),
                ),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white)
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('posts').where('user', isEqualTo: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(); 
                      }
                      List<DocumentSnapshot> sortedDocs = snapshot.data!.docs.toList()
                      ..sort((a, b) => b.get('time').compareTo(a.get('time')));
                      return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, 
                            mainAxisSpacing: 8.0, 
                            crossAxisSpacing: 8.0, 
                          ),
                          itemCount: sortedDocs.length, 
                          itemBuilder: (context, index) {
                            final doc = sortedDocs[index];
                            return Image.network(doc['photoUrl'], fit: BoxFit.cover,);
                          }, 
                        );
                    }
                  )
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
