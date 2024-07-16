import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class ReelsItem extends StatefulWidget {
  final Map<String, dynamic> snapshot;
  const ReelsItem(this.snapshot, {Key? key}) : super(key: key);

  @override
  State<ReelsItem> createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  late VideoPlayerController controller;
  bool play = true;
  String name = '';
  String userProfilePic = '';
  int likes = 0;

  void getUserData() async {
    DocumentReference reelsDocRef =
    FirebaseFirestore.instance.collection('reels').doc(widget.snapshot['reelsId']);
    DocumentSnapshot reelsDoc = await reelsDocRef.get();
    DocumentReference userRef = reelsDoc.get('user');
    DocumentSnapshot userDoc = await userRef.get();

    if (userDoc.exists) {
      setState(() {
        name = userDoc['displayName'];
        userProfilePic = userDoc['profileImageUrl'];
        likes = userDoc['likes'];
      });
    } else {
      print('User document does not exist');
    }
  }

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
    getUserData();
  }

  @override
  void didUpdateWidget(covariant ReelsItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.snapshot['reelsId'] != widget.snapshot['reelsId']) {
      getUserData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Center(
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
              Icon(
                    Icons.favorite,
                    size: 24,
                  ),
                  SizedBox(height: 3),
              Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Icon(
                Icons.comment,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(height: 3),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Icon(
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
                    backgroundImage: userProfilePic.isNotEmpty
                        ? NetworkImage(userProfilePic)
                        : const NetworkImage(
                            'https://th.bing.com/th/id/OIP.0CZd1ESLnyWIHdO38nyJDAHaGF?rs=1&pid=ImgDetMain'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
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
}
