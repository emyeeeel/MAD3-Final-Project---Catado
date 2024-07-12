import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {

  static const String route = '/create';
  static const String name = "Create Screen";

  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  File ? _selectedImage;

  @override
  Widget build(BuildContext context) {      
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  _pickImageFromGallery();
                },
                child: Text("Upload"),
              ),
            ),
            const SizedBox(height: 20,),
            _selectedImage != null ? Image.file(_selectedImage!) : const Text("Please select an image")
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}