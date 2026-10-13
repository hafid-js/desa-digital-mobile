import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.scale(
          scale: 0.9,
          child: Switch(
            padding: EdgeInsets.zero,
            value: value,
            activeThumbColor: AppColors.green,
            thumbColor: WidgetStatePropertyAll(value ? Colors.white : null),
            trackColor: WidgetStatePropertyAll(
              value ? AppColors.green : Colors.transparent,
            ),
            inactiveThumbColor: AppColors.grey,
            trackOutlineColor: WidgetStatePropertyAll(
              value ? AppColors.green : AppColors.grey,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
