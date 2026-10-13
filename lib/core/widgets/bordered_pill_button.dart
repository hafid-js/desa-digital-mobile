import 'package:flutter/material.dart';

class BorderedPillButton extends StatelessWidget {
  const BorderedPillButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.height = 42,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 0.2, color: color),
            right: BorderSide(width: 0.2, color: color),
            bottom: BorderSide(width: 0.2, color: color),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withAlpha(40),
            foregroundColor: color,
            elevation: 0,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
