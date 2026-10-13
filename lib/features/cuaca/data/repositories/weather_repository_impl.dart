import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/cuaca/data/datasources/weather_local_data_source.dart';
import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';
import 'package:desa_digital/features/cuaca/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this._dataSource);

  final WeatherDataSource _dataSource;

  @override
  List<WeatherLocation> getLocations() => _dataSource.locations();

  static Result<T> guard<T>(T Function() reader) {
    try {
      return Result<T>.success(reader());
    } on Exception catch (error) {
      return Result<T>.failure(mapUnknownError(error));
    }
  }
}
