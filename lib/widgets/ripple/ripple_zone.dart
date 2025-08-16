import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/ripple/ripple_icon.dart';
import 'package:video_play_app/widgets/ripple/custom_ripple_zone.dart';
import 'package:video_player/video_player.dart';


class RippleZone extends StatefulWidget {
  final VideoPlayerController controller;

  /// 영상 좌우 더블탭 영역을 감싸는 위젯.
  /// 왼쪽/오른쪽 더블탭 시 각각 5초 되감기 / 빨리감기를 처리함.
  const RippleZone({super.key, required this.controller});

  @override
  State<RippleZone> createState() => _RippleZoneState();
}

class _RippleZoneState extends State<RippleZone> {
  bool? _showIconLeft;

  void _onDoubleTap(bool isLeft) {
    final current = widget.controller.value.position;
    final max = widget.controller.value.duration;

    Duration target = isLeft ?
    current - const Duration(seconds: 5) :
    current + const Duration(seconds: 5);

    if (isLeft && target < Duration.zero) target = Duration.zero;
    if (!isLeft && target > max) target = max;

    widget.controller.seekTo(target);
    setState(() {
      _showIconLeft = null;
    });
    // Schedule next frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _showIconLeft = isLeft;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final padding = screenWidth * 0.2;
    return Positioned.fill(
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomRippleZone(
                  isLeft: true,
                  onDoubleTap: () => _onDoubleTap(true),
                ),
              ),
              Expanded(
                child: CustomRippleZone(
                  isLeft: false,
                  onDoubleTap: () => _onDoubleTap(false),
                ),
              ),
            ],
          ),
          if (_showIconLeft != null)
            Align(
              alignment: _showIconLeft! ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: RippleIcon(isLeft: _showIconLeft!),
              ),
            )
        ],
      ),
    );
  }
}
