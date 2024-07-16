import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../services/files_services.dart';

class CreateScreen extends StatefulWidget {
  static const String route = '/create';
  static const String name = "Create Screen";

  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final FilesServices _filesServices = FilesServices(); 
  PlatformFile? pickedFile;
  TextEditingController caption = TextEditingController();

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
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      height: 400,
                      child: Image.file(
                        File(pickedFile!.path!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'File Type: ${_filesServices.getFileExtension(pickedFile!.name)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  PlatformFile? file = await _filesServices.selectFile();
                  if (file != null) {
                    setState(() {
                      pickedFile = file;
                    });
                  }
                },
                child: const Text("Select File"),
              ),
            ),
            TextField(
              controller: caption,
              decoration: InputDecoration(
                labelText: 'Caption here'
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  if (pickedFile != null) {
                    await _filesServices.uploadFile(pickedFile!, caption.text.trim());
                  }
                },
                child: const Text("Upload File"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
