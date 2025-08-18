import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/screens/home_screen_controller.dart';
import 'package:video_play_app/widgets/player_controls/video_view.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    widget.controller.videoPlayerController = VideoPlayerController.asset(
      'assets/videos/(720p)Old_Town_Road.mp4'
    )..initialize().then((_) {
        setState(() {});
      },);

    widget.controller.videoPlayerController.addListener(() {
      if (!mounted) return;

      final controller = widget.controller.videoPlayerController;
      final isEnded = controller.value.position >= controller.value.duration;

      setState(() {
        widget.controller.isVideoEnded = isEnded;
      });
    },);
  }

  @override
  void dispose() {
    widget.controller.hideTimer?.cancel();
    widget.controller.videoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBlack,
      body: Center(
        child: widget.controller.videoPlayerController.value.isInitialized ?
         _body() : _placeHolder(),
      ),
    );
  }

  Widget _body() {
    return VideoView(
      controller: widget.controller.videoPlayerController,
      isVideoEnded: widget.controller.isVideoEnded,
      onEndReset: widget.controller.onEndReset,
      onShowTap: widget.controller.onShowTap,
      isShow: widget.controller.isShow,
      onPlayPressed: widget.controller.onPlayPressed,
      onForceHide: widget.controller.onForceHide,
      onLongPress: widget.controller.onSetDoubleSpeed,
      onLongPressEnd: widget.controller.onSetDefaultSpeed,
      isiDoubleSpeed: widget.controller.isDoubleSpeed,
      onFullScreenToggle: widget.controller.onFullScreenToggle,
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
