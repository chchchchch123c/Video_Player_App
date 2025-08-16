import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../ripple/custom_ripple_zone.dart';

class RippleZone extends StatelessWidget {
  final VideoPlayerController controller;

  /// 영상 좌우 더블탭 영역을 감싸는 위젯.
  /// 왼쪽/오른쪽 더블탭 시 각각 5초 되감기 / 빨리감기를 처리함.
  const RippleZone({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomRippleZone(
            isLeft: true,
            onDoubleTap: () {
              final current = controller.value.position;
              final rewind = current - Duration(seconds: 5);
              controller.seekTo(
                rewind > Duration.zero ? rewind : Duration.zero,
              );
            },
          ),
        ),
        Expanded(
          child: CustomRippleZone(
            isLeft: false,
            onDoubleTap: () {
              final current = controller.value.position;
              final forward = current + Duration(seconds: 5);
              final max = controller.value.duration;
              controller.seekTo(
                forward < max ? forward : max,
              );
            },
          ),
        ),
      ],
    );
  }
}
