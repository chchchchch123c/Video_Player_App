import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TimeIndicator extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isShow;

  const TimeIndicator({super.key, required this.controller, required this.isShow});

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final position = controller.value.position;
    final duration = controller.value.duration;
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isShow ? 1.0 : 0.0,
        child: Text(
          '${_formatDuration(position)} / ${_formatDuration(duration)}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
