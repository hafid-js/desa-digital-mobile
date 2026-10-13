import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';
import 'package:flutter/material.dart';

class CardPrakiraanCuaca extends StatelessWidget {
  const CardPrakiraanCuaca({
    super.key,
    required this.forecast,
    required this.radius,
  });

  final WeatherForecast forecast;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(forecast.day, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 5),
          Image.asset(AppAssets.cloud, height: 30),
          const SizedBox(height: 5),
          Text(
            forecast.condition,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            forecast.temperature,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            forecast.humidity,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
