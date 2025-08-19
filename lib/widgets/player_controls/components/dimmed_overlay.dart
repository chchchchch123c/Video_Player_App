import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';

class DimmedOverlay extends StatelessWidget {
  final bool isShow;

  /// 영상 위에 흐려진 반투명 오버레이를 보여주는 위젯.
  /// UI 컨트롤러들이 보일 때 뒷배경을 어둡게 처리함.
  const DimmedOverlay({super.key, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isShow ? 1.0 : 0.0,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: kHalfBlack,
      ),
    );
  }
}
