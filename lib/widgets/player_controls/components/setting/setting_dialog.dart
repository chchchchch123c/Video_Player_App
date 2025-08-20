import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';
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

class PlayBackSpeedList extends StatelessWidget {
  final List<double> speeds;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const PlayBackSpeedList({
    super.key,
    required this.speeds,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: speeds.asMap().entries.map((e) {
        final index = e.key;
        final value = e.value;
        return PlayBackSpeedItem(
          index: index,
          selectedIndex: selectedIndex,
          playBackSpeedText: value.toString(),
          onSelect: onSelect,
        );
      },).toList(),
    );
  }
}

class PlayBackSpeedItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String playBackSpeedText;
  final ValueChanged<int> onSelect;

  const PlayBackSpeedItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.playBackSpeedText,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(index),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(
                  selectedIndex == index ? Icons.check : null,
                  size: 20,
                ),
              ),
              Text(
                playBackSpeedText,
                style: TextStyle(color: Colors.white,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

