import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayButton extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isVideoEnded;
  final VoidCallback onReplayPressed;
  final bool isShow;

  /// 재생 / 일시정지 / 리플레이 버튼 위젯.
  /// 영상 상태에 따라 아이콘이 변경되며, 눌렀을 때 동작 처리도 포함.
  const PlayButton({
    super.key,
    required this.controller,
    required this.isVideoEnded,
    required this.onReplayPressed,
    required this.isShow,
  });

  void _handlePlayOrReplay() {
    if (isVideoEnded) {
      onReplayPressed();
    } else {
      controller.value.isPlaying ? controller.pause() : controller.play();
    }
  }

  Icon _buildIcon() {
    if (isVideoEnded) return const Icon(Icons.replay);
    return controller.value.isPlaying ?
    Icon(Icons.pause) : Icon(Icons.play_arrow);
  }

  String get _key => isVideoEnded ?
  'replay' : controller.value.isPlaying ?
  'pause' : 'play';

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isShow ? 1.0 : 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _skipPrevious(),
            _playArrow(),
            _skipNext(),
          ],
        ),
      ),
    );
  }

  Widget _skipPrevious() {
    return IconButton(
      onPressed: () {
        // TODO
      },
      icon: Icon(Icons.skip_previous),
    );
  }

  Widget _playArrow() {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 100),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: IconButton(
          key: ValueKey<String>(_key),
          onPressed: _handlePlayOrReplay,
          icon: _buildIcon(),
        ),
      );
  }

  Widget _skipNext() {
    return IconButton(
      onPressed: () {
        // TODO
      },
      icon: Icon(Icons.skip_next),
    );
  }

}
