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

const WeatherForecast _contohPrakiraan = WeatherForecast(
  day: "Min, 4 Okt",
  condition: "Berawan",
  temperature: "24-29",
  humidity: "68-87%",
);

final List<WeatherForecast> _prakiraan = List<WeatherForecast>.unmodifiable(
  List<WeatherForecast>.filled(10, _contohPrakiraan),
);

final List<WeatherLocation> _locations = [
  for (var nomor = 1; nomor <= 5; nomor++)
    WeatherLocation(
      id: 'lokasi-$nomor',
      name: _namaWilayah,
      forecasts: _prakiraan,
    ),
];
