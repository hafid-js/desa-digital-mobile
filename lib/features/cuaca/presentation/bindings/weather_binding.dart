import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/cuaca/data/datasources/weather_local_data_source.dart';
import 'package:desa_digital/features/cuaca/data/repositories/weather_repository_impl.dart';
import 'package:desa_digital/features/cuaca/domain/repositories/weather_repository.dart';
import 'package:desa_digital/features/cuaca/domain/usecases/get_weather_locations.dart';
import 'package:desa_digital/features/cuaca/presentation/controllers/weather_controller.dart';
import 'package:get/get.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<WeatherDataSource>(
      WeatherLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<WeatherRepository>(
      () => WeatherRepositoryImpl(Injector.resolve<WeatherDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetWeatherLocations>(
      () => GetWeatherLocations(Injector.resolve<WeatherRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<WeatherController>(
      () => WeatherController(Injector.resolve<GetWeatherLocations>()),
      lazy: true,
    );
  }
}
