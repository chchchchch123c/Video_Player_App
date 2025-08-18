import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_player/video_player.dart';


class SeekSlider extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isShow;

  /// 영상의 현재 위치를 보여주고 조절할 수 있는 슬라이더 위젯.
  /// 슬라이더를 움직이면 해당 위치로 영상이 이동함.
  const SeekSlider({super.key, required this.controller, required this.isShow});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isShow ? 1.0 : 0.0,
        child: SliderTheme(
          data: SliderThemeData(
            thumbShape: HandleThumbShape(),
            thumbSize: WidgetStateProperty.all(Size(12, 12))
          ),
          child: Slider(
            thumbColor: kIndigoAccent,
            activeColor: kIndigoAccent,
            max: controller.value.duration.inSeconds.toDouble(),
            value: controller.value.position.inSeconds.toDouble(),
            onChanged: (value) {
              controller.seekTo(Duration(seconds: value.toInt()));
            },),
        ),
      ),
    );
  }
}
