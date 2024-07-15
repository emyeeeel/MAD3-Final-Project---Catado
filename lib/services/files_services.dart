
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FilesServices {
  Future<PlatformFile?> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return result.files.first;
  }

  Future<String> uploadFile(PlatformFile pickedFile) async {
    final path = 'posts/${pickedFile.name}';
    final file = File(pickedFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    await uploadTask.whenComplete(() {});
    final urlDownload = await ref.getDownloadURL();
    print('Download URL: $urlDownload');
    return urlDownload;
  }

  Future<void> storeFileInfoToFirestore(String fileName, String urlDownload) async {
    // Example of adding to Firestore
    try {
      // Assuming you have a 'reels' collection in Firestore
      await FirebaseFirestore.instance.collection('reels').add({
        'fileName': fileName,
        'reelsvideo': urlDownload,
        'time': DateTime.now(),
      });
      print('File info added to Firestore');
    } catch (e) {
      print('Error adding file info to Firestore: $e');
      // Handle error
    }
  }

  String getFileExtension(String fileName) {
    List<String> parts = fileName.split('.');
    return parts.isNotEmpty ? parts.last.toUpperCase() : '';
  }

}