import 'package:flutter/material.dart';

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
