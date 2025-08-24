import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/presentations/controllers/home_screen_controller.dart';
import 'package:video_play_app/widgets/player_controls/video_view.dart';

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
    if (mounted) {
      setState(() {});
    }
  }

  bool get _isControllerInitializedSafe {
    try {
      return widget.controller.videoPlayerController.value.isInitialized;
    } catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(updateScreen);
    if (widget.pickedVideo != null && !_isControllerInitializedSafe) {
      widget.controller.initAndPlay(widget.pickedVideo!.path);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateScreen);
    widget.controller.hideTimer?.cancel();
    try {
      widget.controller.videoPlayerController.dispose();
    } catch (_) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inited = _isControllerInitializedSafe;
    return WillPopScope(
      onWillPop: widget.controller.onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kBlack,
        body: Center(
          child: inited ? _body() : _placeHolder(),
        ),
      ),
    );
  }

  Widget _body() {
    final idx = widget.controller.currentVideoIndex;
    final total = widget.controller.videoList.length;

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
      onSettingPress: () => widget.controller.onSettingPress(context),
      onSkipPrevious: widget.controller.onSkipPrevious,
      onSkipNext: widget.controller.onSkipNext,
      canSkipPrev: idx > 0,
      canSkipNext: idx < total - 1,
      showVideoLayer: widget.controller.showVideoLayer,
    );
  }

  Widget _placeHolder() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: const BoxDecoration(
          color: kBlack,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
