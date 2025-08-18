import 'package:flutter/material.dart';

class OrientationButton extends StatelessWidget {
  final bool isShow;
  final VoidCallback onFullScreenToggle;

  /// 전체화면 전환 버튼 위젯.
  /// [isShow]가 true일 때만 보이며, 눌렀을 때 전체화면 전환 로직을 실행.
  const OrientationButton({
    super.key,
    required this.isShow,
    required this.onFullScreenToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isShow ? 1.0 : 0.0,
        child: IconButton(
          onPressed: onFullScreenToggle,
          icon: Icon(Icons.fullscreen),
        ),
      ),
    );
  }
}
