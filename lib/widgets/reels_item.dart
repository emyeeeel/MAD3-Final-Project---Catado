import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

import '../controllers/data_controller.dart';

class ReelsItem extends StatefulWidget {
  final Map<String, dynamic> snapshot;
  const ReelsItem(this.snapshot, {super.key});

  @override
  State<ReelsItem> createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  late VideoPlayerController controller;
  UserDataController userDataController = UserDataController();
  bool play = true;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.snapshot['reelsvideo'])
      ..initialize().then((value) {
        setState(() {
          controller.setLooping(true);
          controller.setVolume(1);
          controller.play();
        });
      });
    userDataController
        .listen(FirebaseAuth.instance.currentUser?.uid ?? 'unknown');
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userDataController,
      builder: (context, snapshot) {
        return FutureBuilder<DocumentSnapshot>(
          future: widget.snapshot['user'].get(),
          builder: (context, snapshot) {
            final userData = snapshot.data!;
            return Stack(
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
                    width: double.infinity,
                    height: double.infinity,
                    child: VideoPlayer(controller),
                  ),
                ),
                if (!play)
                  const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white30,
                      radius: 35,
                      child: Icon(
                        Icons.play_arrow,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                  bottom: 100,
                  right: 15,
                  child: Column(
                    children: [
                      const Icon(
                            Icons.favorite,
                            size: 24,
                          ),
                      const SizedBox(height: 3),
                      Text(
                        widget.snapshot['likes'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Icon(
                        Icons.comment,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.snapshot['comments']?.length == null ? '0' : '${widget.snapshot['comments']!.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 10,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(userData['profileImageUrl'] ?? 'https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain')
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${userData['displayName']}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          userDataController.userData!['following'].contains(widget.snapshot['user']) ? const Text('') :
                          GestureDetector(
                            onTap: () async {
                              try{
                                DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
                                List<DocumentReference> existingPosts = List.from(userDocSnapshot.get('following') ?? []);
                                existingPosts.add(widget.snapshot['user']);
                                await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'following': existingPosts});
                                try{
                                  DocumentSnapshot userSnapshot = await widget.snapshot['user'].get();
                                  List<DocumentReference> existingFollowers = List.from(userSnapshot.get('followers') ?? []);
                                  existingFollowers.add(FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid));
                                  await widget.snapshot['user'].update({'followers': existingFollowers});
                                  print('Followers added!');
                                  Map<String, dynamic> documentData = userSnapshot.data() as Map<String, dynamic>;
                                  print('Display: ${documentData['name']}');
                                }catch (e){
                                  print('Error 2: $e');
                                }
                              }catch (e){
                                print('Error: $e');
                              }

                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                'Follow',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.snapshot['caption'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        );
      }
    );
  }
}
