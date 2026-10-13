import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/cuaca/domain/entities/weather_forecast.dart';
import 'package:desa_digital/features/cuaca/domain/usecases/get_weather_locations.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class WeatherController extends GetxController {
  WeatherController(this._getWeatherLocations);

  final GetWeatherLocations _getWeatherLocations;

  final RxList<WeatherLocation> lokasi = <WeatherLocation>[].obs;
  final TextEditingController searchController = TextEditingController();

  final RxString query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _muat();
    searchController.addListener(() => query.value = searchController.text);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void clearSearch() => searchController.clear();

  void _muat() {
    lokasi.assignAll(
      _getWeatherLocations(const NoParams()).valueOrNull ??
          const <WeatherLocation>[],
    );
  }
}
