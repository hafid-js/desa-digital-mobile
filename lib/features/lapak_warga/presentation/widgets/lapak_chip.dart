import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LapakChip extends StatelessWidget {
  const LapakChip({
    super.key,
    required this.label,
    required this.aktif,
    required this.onTap,
  });

  final String label;
  final bool aktif;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: aktif ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: aktif ? AppColors.primary : AppColors.borderPrimary,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: aktif ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
