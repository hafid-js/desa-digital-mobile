import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';

abstract interface class WeatherDataSource {
  List<WeatherLocation> locations();
}

class WeatherLocalDataSource implements WeatherDataSource {
  const WeatherLocalDataSource();

  @override
  List<WeatherLocation> locations() => List.unmodifiable(_locations);
}

const String _namaWilayah = "Cepedak, Bruno";

const List<WeatherForecast> _prakiraan = [
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
  WeatherForecast(
    day: "Min, 4 Okt",
    condition: "Berawan",
    temperature: "24-29",
    humidity: "68-87%",
  ),
];

const List<WeatherLocation> _locations = [
  WeatherLocation(id: 'lokasi-1', name: _namaWilayah, forecasts: _prakiraan),
  WeatherLocation(id: 'lokasi-2', name: _namaWilayah, forecasts: _prakiraan),
  WeatherLocation(id: 'lokasi-3', name: _namaWilayah, forecasts: _prakiraan),
  WeatherLocation(id: 'lokasi-4', name: _namaWilayah, forecasts: _prakiraan),
  WeatherLocation(id: 'lokasi-5', name: _namaWilayah, forecasts: _prakiraan),
];
