import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/screens/home_screen.dart';
import 'package:video_play_app/screens/home_screen_controller.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      iconTheme: IconThemeData(
        color: kWhite,
      ),
    ),
    home: HomeScreen(controller: HomeScreenController(),),
  ));
}