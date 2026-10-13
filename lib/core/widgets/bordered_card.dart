import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BorderedCard extends StatelessWidget {
  const BorderedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(width: 0.2, color: AppColors.primary),
          right: BorderSide(width: 0.2, color: AppColors.primary),
          bottom: BorderSide(width: 0.2, color: AppColors.primary),
        ),
      ),
      padding: padding,
      child: child,
    );
  }
}
