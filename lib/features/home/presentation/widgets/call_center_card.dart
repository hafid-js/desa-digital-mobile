import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CallCenterCard extends StatelessWidget {
  const CallCenterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Image.asset(AppAssets.iconCsSupport, height: 50, width: 50),
        title: Text(
          "Call Center Layanan Desa",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Telepon Call Center",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.textSecondaryDark,
        ),
      ),
    );
  }
}
