import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
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
  bool isShow = true;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(
      'assets/videos/(720p)Old_Town_Road.mp4'
    )..initialize().then((_) {
        setState(() {});
      },);

    videoPlayerController.addListener(() {
      if (!mounted) return;

      final controller = videoPlayerController;
      final isEnded = controller.value.position >= controller.value.duration;

      setState(() {
        isVideoEnded = isEnded;
      });
    },);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  void onEndReset() {
    setState(() {
      isVideoEnded = false;
    });
    videoPlayerController.seekTo(Duration.zero);
    videoPlayerController.play();
  }

  void onShowTap() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
        child: videoPlayerController.value.isInitialized ?
         _body() : _placeHolder(),
      ),
    );
  }

  Widget _body() {
    return VideoView(
      controller: videoPlayerController,
      isVideoEnded: isVideoEnded,
      onEndReset: onEndReset,
      onShowTap: onShowTap,
      isShow: isShow,
      );
  }

  Widget _placeHolder() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
