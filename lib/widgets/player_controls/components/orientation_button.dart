import 'package:flutter/material.dart';

class OrientationButton extends StatelessWidget {
  final bool isShow;

  /// 전체화면 전환 버튼 위젯.
  /// [isShow]가 true일 때만 보이며, 터치 가능함.
  const OrientationButton({super.key, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isShow ? 1.0 : 0.0,
        child: IconButton(
          onPressed: () {},
          icon: Icon(Icons.fullscreen),
        ),
      ),
    );
  }
}
