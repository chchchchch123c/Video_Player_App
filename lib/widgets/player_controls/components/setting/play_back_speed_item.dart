import 'package:flutter/material.dart';

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
