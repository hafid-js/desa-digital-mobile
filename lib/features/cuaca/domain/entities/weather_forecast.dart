class WeatherForecast {
  const WeatherForecast({
    required this.day,
    required this.condition,
    required this.temperature,
    required this.humidity,
  });

  final String day;

  final String condition;

  final String temperature;

  final String humidity;
}

class WeatherLocation {
  const WeatherLocation({
    required this.id,
    required this.name,
    required this.forecasts,
  });

  final String id;
  final String name;
  final List<WeatherForecast> forecasts;
}
