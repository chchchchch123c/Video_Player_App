import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_play_app/presentations/controllers/home_screen_controller.dart';
import 'package:video_play_app/presentations/screens/home_screen.dart';

class SelectVideoController {

  Future<void> pickVideo(BuildContext context) async {
    XFile? pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomeScreen(
        controller: HomeScreenController(),
        pickedVideo: pickedVideo,
      );
    },));
  }

}