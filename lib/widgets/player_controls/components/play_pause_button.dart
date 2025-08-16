import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class PlayPauseButton extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isVideoEnded;
  final VoidCallback onReplayPressed;

  /// 재생 / 일시정지 / 리플레이 버튼 위젯.
  /// 영상 상태에 따라 아이콘이 변경되며, 눌렀을 때 동작 처리도 포함.
  const PlayPauseButton({
    super.key,
    required this.controller,
    required this.isVideoEnded,
    required this.onReplayPressed,
});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.skip_previous),
          GestureDetector(
            onTap: () {
                if (isVideoEnded) {
                  onReplayPressed();
                } else {
                  controller.value.isPlaying ? controller.pause() : controller.play();
                }
            },
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child,);
                },
                child: Icon(
                  isVideoEnded ?
                  Icons.replay :
                  controller.value.isPlaying ?
                  Icons.pause : Icons.play_arrow,
                  key: ValueKey<String>(
                    isVideoEnded ? 'replay' :
                    controller.value.isPlaying ?
                    'pause' : 'play',
                  ),
                )
            ),
          ),
          Icon(Icons.skip_next),
        ],
      );
  }
}
