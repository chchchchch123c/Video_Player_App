import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayButton extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isVideoEnded;
  final VoidCallback onReplayPressed;
  final bool isShow;
  final VoidCallback onPlayPressed;
  final VoidCallback onSkipPrevious;
  final VoidCallback onSkipNext;
  final bool canSkipPrev;
  final bool canSkipNext;

  const PlayButton({
    super.key,
    required this.controller,
    required this.isVideoEnded,
    required this.onReplayPressed,
    required this.isShow,
    required this.onPlayPressed,
    required this.onSkipPrevious,
    required this.onSkipNext,
    required this.canSkipPrev,
    required this.canSkipNext,
  });

  void _handlePlayOrReplay() {
    if (isVideoEnded) {
      onReplayPressed();
    } else {
      onPlayPressed();
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
      onPressed: canSkipPrev ? onSkipPrevious : null,
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
      onPressed: canSkipNext ? onSkipNext : null,
      icon: Icon(Icons.skip_next),
    );
  }

}
