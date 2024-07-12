import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../controllers/data_controller.dart';

class ReelsItem extends StatefulWidget {
  final snapshot;
  ReelsItem(this.snapshot, {super.key});

  @override
  State<ReelsItem> createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  late VideoPlayerController controller;
  bool play = true;
  bool isAnimating = false;
  String user = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserDataController userDataController;
  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!.uid;
    controller = VideoPlayerController.network(widget.snapshot['reelsvideo'])
      ..initialize().then((value) {
        setState(() {
          controller.setLooping(true);
          controller.setVolume(1);
          controller.play();
        });
      });
    userDataController = UserDataController();
    String userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
    userDataController.listen(userId);
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
      builder: (context, _) {
        if (userDataController.userData == null) {
            return const Center(
              child: CircularProgressIndicator(), 
            );
        }
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: VideoPlayer(controller),
            ),
            Positioned(
              bottom: 80,
              child: Row(
                children: [
                  SizedBox(width: 20,), 
                  SizedBox(
                    child: CircleAvatar(
                      backgroundImage: userDataController.userData!['profileImageUrl'] != ''
                          ? NetworkImage(userDataController.userData!['profileImageUrl'])
                          : const NetworkImage('https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                      radius: 20,
                    ),
                  ),
                  SizedBox(width: 15,), 
                  Text(userDataController.userData!['displayName'] ?? '', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),)
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Text(
                  "B-U-T-T-E-R F-L-Y BUTTERFLY", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                ),
              )
            ),
            Positioned(
              right: 15,
              bottom: 20,
              child: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Icon(Icons.favorite, size: 30,),
                    Spacer(),
                    Icon(Icons.comment, size: 30,),
                    Spacer(),
                    Icon(Icons.send, size: 30,),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 5, 
                          height: 5, 
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            borderRadius: BorderRadius.circular(15), 
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          width: 5, 
                          height: 5, 
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            borderRadius: BorderRadius.circular(15), 
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          width: 5,
                          height: 5, 
                          decoration: BoxDecoration(
                            color: Colors.white, 
                            borderRadius: BorderRadius.circular(15), 
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 50,
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Reels", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                    Icon(Icons.arrow_drop_down),
                    Spacer(),
                    Icon(Icons.camera),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}