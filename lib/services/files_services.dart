
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FilesServices {
  Future<PlatformFile?> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return result.files.first;
  }

  Future<String> uploadFile(PlatformFile pickedFile, String caption) async {
    final path = 'posts/${pickedFile.name}';
    final file = File(pickedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() {});
    final urlDownload = await ref.getDownloadURL();
    print('Download URL: $urlDownload');
    await storePostToFirestore(urlDownload, caption);
    return urlDownload;
  }

  Future<String> uploadReels(PlatformFile pickedFile, String caption) async {
    final path = 'reels/${pickedFile.name}';
    final file = File(pickedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() {});
    final urlDownload = await ref.getDownloadURL();
    print('Download URL: $urlDownload');
    await storeReelsToFirestore(urlDownload, caption);
    return urlDownload;
  }

  Future<String> uploadProfilePhoto(PlatformFile pickedFile) async {
    final path = 'posts/${pickedFile.name}';
    final file = File(pickedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() {});
    final urlDownload = await ref.getDownloadURL();
    print('Download URL: $urlDownload');
    return urlDownload;
  }

  Future<void> storeReelsToFirestore(String url, String caption) async {
    try {

      DocumentReference reelsRef = await FirebaseFirestore.instance.collection('reels').add({
        'reelsvideo': url,
        'caption': caption,
        'user': FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid),
        'time': FieldValue.serverTimestamp(),
        'comments': [],
        'likes': 0
      });

      await reelsRef.update({'reelsId': reelsRef.id});

      DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      List<DocumentReference> existingReels = List.from(userDocSnapshot.get('reels') ?? []);
      existingReels.add(reelsRef);
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({'reels': existingReels});
      print('File info added to Firestore');
    } catch (e) {
      print('Error adding file info to Firestore: $e');
    }
  }


  Future<void> storePostToFirestore(String url, String caption) async {
    try {

      DocumentReference postRef = await FirebaseFirestore.instance.collection('posts').add({
        'photoUrl': url,
        'caption': caption,
        'user': FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid),
        'time': FieldValue.serverTimestamp(),
      });

      await postRef.update({'postId': postRef.id});

      DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      List<DocumentReference> existingPosts = List.from(userDocSnapshot.get('posts') ?? []);
      existingPosts.add(postRef);
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({'posts': existingPosts});
      print('File info added to Firestore');
    } catch (e) {
      print('Error adding file info to Firestore: $e');
    }
  }

  String getFileExtension(String fileName) {
    List<String> parts = fileName.split('.');
    return parts.isNotEmpty ? parts.last.toUpperCase() : '';
  }

}