import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/player_controls/components/play_pause_button.dart';
import 'package:video_play_app/widgets/player_controls/components/ripple_zone.dart';
import 'package:video_play_app/widgets/player_controls/components/seek_slider.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isVideoEnded;
  final VoidCallback onEndReset;

  /// 영상 플레이어 전체 UI를 구성하는 위젯.
  /// 실제 영상 출력, 제스처 영역, 슬라이더, 재생 버튼 등을 포함함.
  const VideoView({
    super.key,
    required this.controller,
    required this.isVideoEnded,
    required this.onEndReset,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(controller),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: RippleZone(controller: controller),
            ),
          ),
          Positioned(
            left: 5,
            right: 0,
            bottom: 0,
            child: SeekSlider(controller: controller),
          ),
          PlayPauseButton(
            controller: controller,
            isVideoEnded: isVideoEnded,
            onReplayPressed: onEndReset,
          ),
        ],
      ),
    );
  }
}
