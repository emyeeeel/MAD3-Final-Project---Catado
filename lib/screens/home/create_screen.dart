import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class CreateScreen extends StatefulWidget {

  static const String route = '/create';
  static const String name = "Create Screen";

  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if(result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'posts/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete((){});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download URL: ${urlDownload}');
  }


  @override
  Widget build(BuildContext context) {      
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            if(pickedFile != null)
              Container(
                width: 500,
                height: 500,
                child: Center(
                  child: Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: selectFile,
                child: Text("Select File"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: uploadFile,
                child: Text("Upload File"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}