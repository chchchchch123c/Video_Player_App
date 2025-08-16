import 'package:flutter/material.dart';

class RippleIcon extends StatefulWidget {
  final bool isLeft;

  /// 더블탭 시 나타나는 되감기/빨리감기 아이콘과 텍스트 애니메이션 위젯.
  /// 위치는 좌/우 중앙이며, 애니메이션은 자동으로 실행 후 사라짐.
  const RippleIcon({super.key, required this.isLeft});

  @override
  State<RippleIcon> createState() => _RippleIconState();
}

class _RippleIconState extends State<RippleIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationScale;
  late Animation<double> _animationOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationScale = Tween<double>(begin: 0.5, end: 1.0).
    animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _animationOpacity = Tween<double>(begin: 0.0, end: 1.0).
    animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 300), () => _controller.reverse());
    },);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icon = widget.isLeft ? Icons.fast_rewind : Icons.fast_forward;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        return Opacity(
          opacity: _animationOpacity.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: _animationScale.value,
                child: Icon(icon, size: 30),
              ),
              Text(
                widget.isLeft ? '-5sec' : '5sec',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
