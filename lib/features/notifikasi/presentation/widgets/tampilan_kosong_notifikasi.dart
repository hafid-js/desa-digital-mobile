import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class TampilanKosongNotifikasi extends StatelessWidget {
  const TampilanKosongNotifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.emptyBox, height: 120, width: 120),
        SizedBox(height: 10),
        Text(
          "Notifikasi tidak ditemukan",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 5),
        Text(
          "Belum ada pengumumuman buat kamu",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
