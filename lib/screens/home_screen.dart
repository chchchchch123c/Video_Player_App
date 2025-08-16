import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/player_controls/video_view.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController videoPlayerController;
  bool isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(
      'assets/videos/Never_Gonna_Give_You_Up.mp4'
    )
    // videoPlayerController = VideoPlayerController.networkUrl(
    //     Uri.parse(rickRoll))
      ..initialize().then((_) {
        setState(() {});
      },);

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position >= videoPlayerController.value.duration && !videoPlayerController.value.isPlaying && mounted) {
        setState(() {
          isVideoEnded = true;
        });
      }
    },);

    videoPlayerController.addListener(() {
      setState(() {});
    },);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: videoPlayerController.value.isInitialized ?
            VideoView(
              controller: videoPlayerController,
              isVideoEnded: isVideoEnded,
              onEndReset: () {
                videoPlayerController.seekTo(Duration.zero);
                videoPlayerController.play();
                setState(() {
                  isVideoEnded = false;
                });
              },
            )
         : AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4))
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
