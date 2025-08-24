import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_player/video_player.dart';

class SeekSlider extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isShow;

  const SeekSlider({
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
            if (!value.isInitialized || value.duration.inMilliseconds == 0) {
              return const SizedBox.shrink();
            }

            final duration = value.duration;
            final posMs = math.min(
              math.max(value.position.inMilliseconds, 0),
              duration.inMilliseconds,
            );
            final position = Duration(milliseconds: posMs);
            final progress = duration.inMilliseconds == 0
                ? 0.0
                : position.inMilliseconds / duration.inMilliseconds;

            return SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: HandleThumbShape(),
                thumbSize: WidgetStateProperty.all(Size(12, 12)),
              ),
              child: Slider(
                activeColor: kIndigoAccent,
                thumbColor: kIndigoAccent,
                min: 0.0,
                max: 1.0,
                value: progress.isNaN ? 0.0 : progress,
                onChanged: (v) {
                  final target = Duration(
                    milliseconds: (duration.inMilliseconds * v).round(),
                  );
                  controller.seekTo(target);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
