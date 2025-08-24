import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TimeIndicator extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isShow;

  const TimeIndicator({
    super.key,
    required this.controller,
    required this.isShow,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isShow ? 1 : 0,
        child: ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            if (!value.isInitialized || value.duration == Duration.zero) {
              return const SizedBox.shrink();
            }

            final dur = value.duration;
            final posMs = math.min(
              math.max(value.position.inMilliseconds, 0),
              dur.inMilliseconds,
            );
            final pos = Duration(milliseconds: posMs);

            return Text(
              '${_fmt(pos)} / ${_fmt(dur)}',
              style: const TextStyle(
                color: Colors.white,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            );
          },
        ),
      ),
    );
  }

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }
}
