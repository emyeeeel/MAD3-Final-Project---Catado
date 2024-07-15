import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostDataController with ChangeNotifier {
  List<PostData> _posts = []; // Define a list to hold posts

  List<PostData> get posts => _posts; // Getter for posts

  int count = 0; // Variable to count posts by current user

  listen() async {
    try {
      _posts.clear(); // Clear existing posts when fetching new ones

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
          Timestamp postTime = doc.get('time');
          DocumentReference userRef = doc.get('user');
          String url = doc.get('photoUrl');

          // Fetch user document data
          DocumentSnapshot userSnapshot = await userRef.get();
          if (userSnapshot.exists) {
            // Check if the post belongs to the current user
            if (userSnapshot.get('userId') == FirebaseAuth.instance.currentUser!.uid) {
              count++; // Increment count for posts by current user
              // Create a PostData object and add to _posts list
              _posts.add(PostData(
                postId: postId,
                postTime: postTime,
                url: url,
                userName: userSnapshot.get('displayName'),
                userProfileImageUrl: userSnapshot.get('profileImageUrl'),
              ));
            }
          } else {
            print('User document not found for reference: $userRef');
          }
        }
      } else {
        print('No posts found');
      }

      notifyListeners(); // Notify listeners after updating posts
    } catch (e) {
      print('Error fetching posts: $e');
      // Handle error
    }
  }
  
}

// Model class to represent each post
class PostData {
  final String postId;
  final Timestamp postTime;
  final String url;
  final String userName;
  final String userProfileImageUrl;

  PostData({
    required this.postId,
    required this.postTime,
    required this.url,
    required this.userName,
    required this.userProfileImageUrl,
  });
}
