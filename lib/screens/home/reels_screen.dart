import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  static const String route = '/notification';
  static const String name = "Notification Screen";

  const ReelsScreen({Key? key}) : super(key: key);

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String url = '';
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: VideoPlayer(_controller),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // Remove the floating action button that toggles play/pause
    );
  }
}
