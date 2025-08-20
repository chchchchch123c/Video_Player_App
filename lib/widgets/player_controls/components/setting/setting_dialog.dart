import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_player/video_player.dart';

class SettingDialog extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isLoop;
  final VoidCallback onTapSpeed;
  final VoidCallback onTapLoop;

  const SettingDialog({
    super.key,
    required this.controller,
    required this.isLoop,
    required this.onTapSpeed,
    required this.onTapLoop,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mediaWidth = mediaQuery.size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.centerRight,
      insetPadding: EdgeInsets.only(
        right: mediaWidth * 0.07,
        left: mediaQuery.orientation == Orientation.landscape ?
        mediaWidth * 0.65 : mediaWidth * 0.55,
        bottom: mediaWidth * 0.3,
      ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: kEightyBlack,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget itemButton;
  final VoidCallback onSettingItemTap;

  const SettingItem({
    super.key,
    required this.icon,
    required this.label,
    required this.itemButton,
    required this.onSettingItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSettingItemTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(icon, size: 20,),
              ),
              Text(label, style: TextStyle(color: Colors.white),),
            ],
          ),
          itemButton,
        ],
      ),
    );
  }
}

