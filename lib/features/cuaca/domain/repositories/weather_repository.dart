import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';

abstract interface class WeatherRepository {
  List<WeatherLocation> getLocations();
}
