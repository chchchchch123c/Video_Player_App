import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/presentations/controllers/select_video_controller.dart';
import 'package:video_play_app/widgets/select_controls/select_container.dart';

class SelectVideoScreen extends StatelessWidget {
  final SelectVideoController controller;

  const SelectVideoScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kGray,
        appBar: _AppBar(),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: SelectContainer(
                  height: 56.0,
                  icon: Icons.help_outline,
                  text: 'How to use',
                  onTap: () => controller.urlLauncher(),
                  // TODO 다이얼로그 추가 후 다이얼로그 안에서 호춯하기
                ),
              ),
              Expanded(
                child: SelectContainer(
                  icon: Icons.add_photo_alternate_outlined,
                  text: 'Load a video',
                  onTap: () {
                    controller.pickVideo(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kIndigoAccent,
      title: Text('VideoPlayerApp'),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: kWhite,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

