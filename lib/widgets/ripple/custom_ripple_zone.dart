import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/ripple/ripple_painter.dart';

class CustomRippleZone extends StatefulWidget {
  final bool isLeft;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;
  final void Function(LongPressEndDetails) onLongPressEnd;

  /// 더블탭 시 원형 리플 애니메이션을 보여주는 위젯.
  /// 제스처를 인식하고 내부에서 [RipplePainter]로 효과를 그림.
  const CustomRippleZone({
    super.key,
    required this.isLeft,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.onLongPressEnd,
  });

  @override
  State<CustomRippleZone> createState() => _CustomRippleZoneState();
}

class _CustomRippleZoneState extends State<CustomRippleZone>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset? _rippleCenter;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  void _startRipple(TapDownDetails details, Size size) {
    final local = details.localPosition;

    setState(() {
      _rippleCenter = local;
    });

    _controller.forward(from: 0);
    widget.onDoubleTap();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTapDown: (details) => _startRipple(details, size),
          onLongPress: widget.onLongPress,
          onLongPressEnd: widget.onLongPressEnd,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: _rippleCenter == null ? null : RipplePainter(
                  progress: _animation.value,
                  center: _rippleCenter!,
                  maxRadius: size.shortestSide * 0.75,
                ),
                child: Container(),
              );
            },
          ),
        );
      },
    );
  }
}