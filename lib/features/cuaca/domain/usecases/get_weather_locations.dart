import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';
import 'package:desa_digital/features/cuaca/domain/repositories/weather_repository.dart';

class GetWeatherLocations extends BaseUseCase<List<WeatherLocation>, NoParams> {
  const GetWeatherLocations(this._repository);

  final WeatherRepository _repository;

  @override
  Result<List<WeatherLocation>> execute(NoParams params) =>
      Result<List<WeatherLocation>>.success(_repository.getLocations());
}
