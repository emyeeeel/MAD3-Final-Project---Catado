import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/controllers/data_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

  static const String route = '/search';
  static const String name = "Search Screen";

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

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
            centerTitle: true,
            title: Container(
              height: 45,
              width: MediaQuery.of(context).size.width - 80,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(Icons.search),
                  SizedBox(width: 5,),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 18
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: SizedBox(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('posts').where('user', isNotEqualTo: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)).snapshots(),
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
              
                          }
                  );
                }
              ),
            ),
          ),
        );
      }
    );
  }
}


