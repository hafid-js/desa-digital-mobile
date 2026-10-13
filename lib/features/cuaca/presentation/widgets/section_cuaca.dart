import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';
import 'package:desa_digital/features/cuaca/presentation/widgets/card_prakiraan_cuaca.dart';
import 'package:flutter/material.dart';

class SectionCuaca extends StatelessWidget {
  const SectionCuaca({
    super.key,
    required this.lokasi,
    required this.radiusIkon,
    required this.radiusKartu,
  });

  final WeatherLocation lokasi;

  final double radiusIkon;

  final double radiusKartu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withAlpha(50),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusIkon),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(lokasi.name, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: lokasi.forecasts.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) => CardPrakiraanCuaca(
                forecast: lokasi.forecasts[index],
                radius: radiusKartu,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
