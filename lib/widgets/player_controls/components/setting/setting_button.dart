import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  final bool isShow;
  final VoidCallback onSettingPress;

  const SettingButton({
    super.key,
    required this.isShow,
    required this.onSettingPress,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isShow,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isShow ? 1.0 : 0.0,
        child: IconButton(
          onPressed: onSettingPress,
          icon: Icon(Icons.settings_outlined),
        ),
      ),
    );
  }
}
