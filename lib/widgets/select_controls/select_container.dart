import 'package:flutter/material.dart';
import 'package:video_play_app/constant/color.dart';

class SelectContainer extends StatelessWidget {
  final double? height;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const SelectContainer({
    super.key,
    this.height,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhite,
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  icon,
                  color: kIndigoAccent,
                  size: 32,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 18
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
