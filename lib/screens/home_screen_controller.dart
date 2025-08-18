import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class HomeScreenController extends ChangeNotifier {
  late final VideoPlayerController videoPlayerController;
  bool isVideoEnded = false;
  bool isShow = true;
  Timer? hideTimer;
  bool isDoubleSpeed = false;
  bool isFullScreen = false;


  // 영상 끝난 후 리셋
  void onEndReset() {
    isVideoEnded = false;
    notifyListeners();
    videoPlayerController.seekTo(Duration.zero);
    videoPlayerController.play();
  }

  // 화면 탭 시 UI 토글 및 자동 숨김 타이머
  void onShowTap() {
    hideTimer?.cancel();

    isShow = !isShow;
    notifyListeners();
    if (videoPlayerController.value.isPlaying) {
      _startHideTimer();
    }
  }

  // UI 자동 숨김
  void _startHideTimer() {
    hideTimer = Timer(Duration(seconds: 2), () {
      if (videoPlayerController.value.isPlaying) {
        isShow = false;
        notifyListeners();
      }
    },);
  }

  // 재생 버튼 클릭 시 동작 처리
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

  // 더블 탭 시 UI 숨김
  void onForceHide() {
    isShow = false;
    notifyListeners();
  }


  // 롱프레스 호출 시, UI가 보일 때만 2배속 적용하고 그 즉시 UI는 감춤
  void onSetDoubleSpeed() {
    if (!videoPlayerController.value.isPlaying) return;
    if (isShow) {
      onForceHide();
    }
    isDoubleSpeed = true;
    notifyListeners();
    videoPlayerController.setPlaybackSpeed(2.0);
  }

  // 롱프레스가 끝날시 속도 정상화
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

}