import 'package:flutter/material.dart';

class DoubleSpeedBanner extends StatelessWidget {
  final bool isVisible;
  
  const DoubleSpeedBanner({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: isVisible ? 1.0 : 0.0,
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.5),
            minimumSize: Size.zero,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('2x', style: TextStyle(color: Colors.white),),
              Icon(Icons.fast_forward, color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
