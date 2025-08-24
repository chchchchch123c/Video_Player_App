import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_play_app/widgets/player_controls/components/setting/setting_dialog.dart';
import 'package:video_player/video_player.dart';

class HomeScreenController extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  VoidCallback? _valueListener;

  bool isVideoEnded = false;
  bool isShow = true;
  Timer? hideTimer;
  bool isDoubleSpeed = false;
  bool isFullScreen = false;
  bool isLoop = false;
  bool isExtended = false;
  int playbackIndex = 2;
  List<XFile> videoList = [];
  int currentVideoIndex = 0;

  bool showVideoLayer = true;

  Future<void> initAndPlay(String src) async {
    showVideoLayer = false;
    notifyListeners();

    try {
      videoPlayerController.pause();
      if (_valueListener != null) {
        videoPlayerController.removeListener(_valueListener!);
      }
      await videoPlayerController.dispose();
    } catch (_) {}

    final bool isContentUri = src.startsWith('content://');
    final VideoPlayerController next = isContentUri
        ? VideoPlayerController.contentUri(Uri.parse(src))
        : VideoPlayerController.file(File(src));

    videoPlayerController = next;

    await videoPlayerController.initialize();
    isVideoEnded = false;

    _attachVideoListener();
    await videoPlayerController.play();

    showVideoLayer = true;
    notifyListeners();
  }

  void _attachVideoListener() {
    if (_valueListener != null) {
      videoPlayerController.removeListener(_valueListener!);
    }
    _valueListener = () {
      final v = videoPlayerController.value;
      final ended = v.isInitialized && v.position >= v.duration && !v.isPlaying;
      if (isVideoEnded != ended) {
        isVideoEnded = ended;
        notifyListeners();
      }
    };
    videoPlayerController.addListener(_valueListener!);
  }

  void onEndReset() {
    isVideoEnded = false;
    notifyListeners();
    videoPlayerController.seekTo(Duration.zero);
    videoPlayerController.play();
  }

  void onShowTap() {
    hideTimer?.cancel();
    isShow = !isShow;
    notifyListeners();
    if (videoPlayerController.value.isPlaying) {
      _startHideTimer();
    }
  }

  void _startHideTimer() {
    hideTimer = Timer(const Duration(milliseconds: 2600), () {
      if (videoPlayerController.value.isPlaying) {
        isShow = false;
        notifyListeners();
      }
    });
  }

  void onPlayPressed() {
    final isPlaying = videoPlayerController.value.isPlaying;
    if (isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
      if (isShow) {
        hideTimer?.cancel();
        _startHideTimer();
      }
    }
    notifyListeners();
  }

  void onForceHide() {
    isShow = false;
    notifyListeners();
  }

  void onSetDoubleSpeed() {
    if (!videoPlayerController.value.isPlaying) return;
    if (isShow) onForceHide();
    isDoubleSpeed = true;
    notifyListeners();
    videoPlayerController.setPlaybackSpeed(2.0);
  }

  void onSetDefaultSpeed(LongPressEndDetails _) {
    isDoubleSpeed = false;
    notifyListeners();
    videoPlayerController.setPlaybackSpeed(1.0);
  }

  void onFullScreenToggle() {
    isFullScreen = !isFullScreen;
    notifyListeners();
    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Future<bool> onWillPop() async {
    if (isFullScreen) {
      onFullScreenToggle();
      return false;
    }
    return true;
  }

  Future<void> onSettingPress(BuildContext context) async {
    try {
      return await showDialog(
        barrierColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            final speeds = <double>[2.0, 1.5, 1.0, 0.5];
            return SettingDialog(
              speeds: speeds,
              playbackIndex: playbackIndex,
              controller: videoPlayerController,
              isExtended: isExtended,
              isLoop: isLoop,
              onTapSpeed: () {
                _onTapExtends(() => setState(() {}));
              },
              onTapLoop: () {
                _onTapLoop(() => setState(() {}));
              },
              onSelectSpeed: (index) {
                playbackIndex = index;
                isExtended = false;
                videoPlayerController.setPlaybackSpeed(speeds[index]);
                notifyListeners();
                setState(() {});
              },
            );
          },
        ),
        context: context,
      );
    } finally {
      if (isExtended) {
        isExtended = false;
        notifyListeners();
      }
    }
  }

  void _onTapExtends(VoidCallback setState) {
    isExtended = true;
    notifyListeners();
    setState();
  }

  void _onTapLoop(VoidCallback setState) {
    isLoop = !isLoop;
    videoPlayerController.setLooping(isLoop);
    notifyListeners();
    setState();
  }

  void setVideoList(List<XFile> videos, {int startIndex = 0}) {
    videoList = videos;
    currentVideoIndex =
    (startIndex >= 0 && startIndex < videoList.length) ? startIndex : 0;
    notifyListeners();
  }

  Future<void> playVideoAt(int index) async {
    if (index < 0 || index >= videoList.length) {
      return;
    }
    currentVideoIndex = index;
    notifyListeners();
    await initAndPlay(videoList[index].path);
  }

  void onSkipPrevious() {
    if (currentVideoIndex > 0) {
      playVideoAt(currentVideoIndex - 1);
    }
  }

  void onSkipNext() {
    if (currentVideoIndex < videoList.length - 1) {
      playVideoAt(currentVideoIndex + 1);
    }
  }
}
