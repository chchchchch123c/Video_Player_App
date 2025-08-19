import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.centerRight,
      insetPadding: EdgeInsets.only(
        right: mediaWidth * 0.07,
        left: MediaQuery.of(context).orientation == Orientation.landscape ?
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(Icons.slow_motion_video, size: 20,),
                      ),
                      Text('speed', style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('1.0', style: TextStyle(color: Colors.white),),
                      Icon(Icons.keyboard_arrow_right, size: 20,),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
