import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TileNotifikasi extends StatelessWidget {
  const TileNotifikasi({
    super.key,
    required this.item,
    required this.terbaca,
    required this.gayaIsi,
    required this.gayaWaktu,
    required this.onTap,
  });

  final NotificationItem item;
  final bool terbaca;
  final TextStyle gayaIsi;
  final TextStyle gayaWaktu;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: terbaca ? AppColors.light : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondary.withAlpha(40),
              child: Icon(
                Iconsax.menu_board,
                color: AppColors.secondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: terbaca ? FontWeight.w400 : FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(item.body, style: gayaIsi),
                  const SizedBox(height: 10),
                  Text(item.timeAgo, style: gayaWaktu),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
