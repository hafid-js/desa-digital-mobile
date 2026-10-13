import 'package:flutter/material.dart';

class LabelPill extends StatelessWidget {
  const LabelPill({
    super.key,
    required this.label,
    required this.color,
    required this.backgroundColor,
    this.action,
    this.icon,
  });

  final String label;
  final Color color;
  final Color backgroundColor;
  final IconData? icon;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: color,
      fontSize: 11,
      fontWeight: FontWeight.w600,
    );

    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: icon == null
            ? Text(label, style: style)
            : Row(
                children: [
                  Text(label, style: style),
                  SizedBox(width: 4),
                  Icon(icon, size: 13, color: color),
                ],
              ),
      ),
    );
  }
}
