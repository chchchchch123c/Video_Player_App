import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/presentations/controllers/select_video_controller.dart';
import 'package:video_play_app/presentations/screens/select_video_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      iconTheme: IconThemeData(
        color: kWhite,
      ),
    ),
    home: SelectVideoScreen(controller: SelectVideoController(),),
  ));
}