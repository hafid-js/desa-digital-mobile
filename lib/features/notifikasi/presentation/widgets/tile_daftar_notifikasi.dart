import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/settings_switch_tile.dart';
import 'package:flutter/material.dart';

class TileDaftarNotifikasi extends StatelessWidget {
  final bool value;
  final IconData icon;
  final String title;
  final String subtitle;
  final ValueChanged<bool> onChanged;

  const TileDaftarNotifikasi({
    super.key,
    required this.value,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: title == "Event Desa Hari Ini"
            ? null
            : Border(bottom: BorderSide(color: AppColors.grey.withAlpha(100))),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppColors.primary.withAlpha(180)),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            SettingsSwitchTile(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
