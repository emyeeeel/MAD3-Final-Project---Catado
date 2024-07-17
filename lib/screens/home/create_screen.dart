import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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

  late VideoPlayerController controller;
  String filePath = '';
  bool play = true;

  @override
  void initState() {
    super.initState();
    if (filePath.isNotEmpty) {
      initializeController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void initializeController() {
  controller = VideoPlayerController.file(File(filePath))
    ..initialize().then((value) {
      setState(() {
        controller.setLooping(true);
        controller.setVolume(1);
        controller.play();
      });
    }).catchError((error) {
      print("Failed to initialize video player: $error");
    });
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
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          play = !play;
                        });
                        if (play) {
                          controller.play();
                        } else {
                          controller.pause();
                        }
                      },
                      child: SizedBox(
                        width: 400,
                        height: 400,
                        child: _filesServices.getFileExtension(pickedFile!.name).toLowerCase() == 'mp4' ? VideoPlayer(controller) : Image.file(
                          File(pickedFile!.path!),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
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
                      if (_filesServices.getFileExtension(file.name).toLowerCase() == 'mp4') {
                        filePath = file.path!;
                        initializeController();
                      }
                    });
                  }
                },
                child: const Text("Select File"),
              ),
            ),
            TextField(
              controller: caption,
              decoration: const InputDecoration(
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
                child: const Text("Upload Post"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  if (pickedFile != null) {
                    await _filesServices.uploadReels(pickedFile!, caption.text.trim());
                  }
                },
                child: const Text("Upload Reels"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
