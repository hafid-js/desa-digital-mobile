import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CuacaCard extends StatelessWidget {
  final String humidity;
  final String windSpeed;
  final String windDirection;
  final String visibility;

  const CuacaCard({
    super.key,
    this.humidity = "82%",
    this.windSpeed = "1.27 m/s",
    this.windDirection = "Barat Laut",
    this.visibility = "10 km",
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> weatherItems = [
      {
        'title': humidity,
        'subtitle': 'Kelembapan Udara',
        'icon': Icons.water_drop_rounded,
      },
      {
        'title': windSpeed,
        'subtitle': 'Kecepatan Angin',
        'icon': Icons.air_rounded,
      },
      {
        'title': windDirection,
        'subtitle': 'Arah Angin Menuju',
        'icon': Icons.explore_rounded,
      },
      {
        'title': visibility,
        'subtitle': 'Jarak Pandang',
        'icon': Icons.remove_red_eye_rounded,
      },
    ];

    return Container(
      padding: const EdgeInsets.only(right: 14, left: 14, bottom: 14, top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withAlpha(50),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image.asset(AppAssets.cloud, height: 50),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "27°C",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const WidgetSpan(child: SizedBox(width: 8)),
                  TextSpan(
                    text: "Berawan",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.grey, size: 18),
                SizedBox(width: 2),
                Text(
                  "Gunungcondong, Bruno",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(45),
              borderRadius: BorderRadius.circular(16),
            ),
            child: MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: weatherItems.length,
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              itemBuilder: (context, index) {
                final item = weatherItems[index];

                return ListTile(
                  horizontalTitleGap: 6,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  leading: Icon(
                    item['icon'] as IconData,
                    color: AppColors.primary.withAlpha(100),
                  ),
                  title: Text(
                    item['title'] as String,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 13),
                  ),
                  subtitle: Text(
                    item['subtitle'] as String,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
