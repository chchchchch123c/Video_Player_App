import 'package:flutter/material.dart';
import 'package:video_play_app/widgets/player_controls/components/setting/play_back_speed_item.dart';

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
