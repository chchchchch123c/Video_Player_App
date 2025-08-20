import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/player_controls/components/setting/setting_item.dart';
import 'package:video_player/video_player.dart';

class SettingList extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isLoop;
  final VoidCallback onTapSpeed;
  final VoidCallback onTapLoop;
  final bool isExtended;

  const SettingList({
    super.key,
    required this.controller,
    required this.isLoop,
    required this.onTapSpeed,
    required this.onTapLoop,
    required this.isExtended,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        SettingItem(
          onSettingItemTap: onTapSpeed,
          icon: Icons.slow_motion_video,
          label: 'speed',
          itemButton: Row(
            children: [
              Text(
                controller.value.playbackSpeed.toString(),
                style: TextStyle(color: Colors.white),
              ),
              Icon(Icons.keyboard_arrow_right, size: 20,),
            ],
          ),
        ),
        SettingItem(
          onSettingItemTap: onTapLoop,
          icon: Icons.repeat,
          label: 'loop',
          itemButton: Icon(
            isLoop ? Icons.check : null,
            size: 20,
          ),
        ),
      ],
    );
  }
}