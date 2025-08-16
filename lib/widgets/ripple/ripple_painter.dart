import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  final double progress;
  final Offset center;
  final double maxRadius;

  /// 실제 리플 애니메이션을 그리는 CustomPainter 클래스.
  /// [CustomRippleZone] 내부에서 사용됨.
  RipplePainter({
    required this.progress,
    required this.center,
    required this.maxRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3 * (1 - progress))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, maxRadius * progress, paint);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.center != center;
  }
}
