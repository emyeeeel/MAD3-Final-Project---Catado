import 'package:cloud_firestore/cloud_firestore.dart';
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

  void getUserData() async {
    // Assume you have the document reference of the reels document
    DocumentReference reelsDocRef = FirebaseFirestore.instance.collection('reels').doc('65jmSjUpoBKcLGXY5q03');

    // Get the reels document
    DocumentSnapshot reelsDoc = await reelsDocRef.get();

    // Extract the user reference
    DocumentReference userRef = reelsDoc.get('user');

    // Fetch the user document
    DocumentSnapshot userDoc = await userRef.get();

    // Now you can access the data from the user document
    if (userDoc.exists) {
      print('User name: ${userDoc['name']}');
      print('User email: ${userDoc['email']}');
      // Access other fields as needed
    } else {
      print('User document does not exist');
    }
  }

  List<String> postUrl = [];
  int count = 0;

  Future<void> getPosts() async {
    try {
      // Query Firestore collection "posts"
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .get();

      // Process query results
      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through each document snapshot
        for (DocumentSnapshot doc in querySnapshot.docs) {
          // Access document ID
          String postId = doc.id;
          postId = doc.id;
          // Access other fields as needed
          Timestamp postTime = doc.get('time');
          // Assuming "user" field is a reference to users collection
          DocumentReference userRef = doc.get('user');

          String url = doc.get('photoUrl');

          // Fetch user document data
          DocumentSnapshot userSnapshot = await userRef.get();
          if (userSnapshot.exists) {
            if(userSnapshot.get('userId') == FirebaseAuth.instance.currentUser!.uid){
              count++;
              postUrl.add(url);
              // Access user document fields
              String userName = userSnapshot.get('displayName');
              String userProfileImageUrl = userSnapshot.get('profileImageUrl');
              
              // Print or process user data as needed
              print('Post ID: $postId, Time: $postTime');
              print('Post URL: $url');
              print('User: $userName, Profile Image URL: $userProfileImageUrl');
            }else{
              print('Did not match');
            }
          } else {
            print('User document not found for reference: $userRef');
          }
        }
      } else {
        // Handle case where no posts are found
        print('No posts found');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          children: [
            Text('Search Screen'),
            MaterialButton(
              onPressed: () {
                getUserData();
              },
              color: Colors.blue[100],
            ),
          ],
        ),
      ),
    );
  }
}


