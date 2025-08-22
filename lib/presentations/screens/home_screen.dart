import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/presentations/controllers/home_screen_controller.dart';
import 'package:video_play_app/widgets/player_controls/video_view.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenController controller;
  final XFile? pickedVideo;

  const HomeScreen({
    super.key,
    required this.controller,
    required this.pickedVideo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(updateScreen);
    widget.controller.videoPlayerController = VideoPlayerController.file(
      File(widget.pickedVideo!.path)
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
    widget.controller.removeListener(updateScreen);
    widget.controller.hideTimer?.cancel();
    widget.controller.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.controller.onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kBlack,
        body: Center(
          child: widget.controller.videoPlayerController.value.isInitialized ?
           _body() : _placeHolder(),
        ),
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
      onSettingPress: () {
        widget.controller.onSettingPress(context);
      },
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
