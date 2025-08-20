import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
import 'package:video_play_app/widgets/player_controls/components/setting/play_back_speed_list.dart';
import 'package:video_play_app/widgets/player_controls/components/setting/setting_list.dart';
import 'package:video_player/video_player.dart';

class SettingDialog extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isLoop;
  final VoidCallback onTapSpeed;
  final VoidCallback onTapLoop;
  final bool isExtended;
  final List<double> speeds;
  final ValueChanged<int> onSelectSpeed;
  final int playbackIndex;

  const SettingDialog({
    super.key,
    required this.controller,
    required this.isLoop,
    required this.onTapSpeed,
    required this.onTapLoop,
    required this.isExtended,
    required this.speeds,
    required this.onSelectSpeed,
    required this.playbackIndex,
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
        bottom: isExtended ? mediaWidth * 0.15 : mediaWidth * 0.3,
      ),
      child: Container(
        height: isExtended ? 120 : 64,
        decoration: BoxDecoration(
          color: kEightyBlack,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: isExtended ?
          PlayBackSpeedList(
            speeds: speeds,
            selectedIndex: playbackIndex,
            onSelect: onSelectSpeed,
          ) :
          SettingList(
            controller: controller,
            isLoop: isLoop,
            onTapSpeed: onTapSpeed,
            onTapLoop: onTapLoop,
            isExtended: isExtended,
          ),
        ),
      ),
    );
  }
}
