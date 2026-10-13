import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/home/data/datasources/home_local_data_source.dart';
import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/domain/entities/home_menu_item.dart';
import 'package:desa_digital/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeDataSource _dataSource;

  @override
  List<HomeMenuItem> getMenuItems() => _dataSource.menuItems();

  @override
  List<ContentItem> getAgendaHariIni() => _dataSource.agendaHariIni();

  @override
  List<ContentItem> getArtikelTerbaru() => _dataSource.artikelTerbaru();

  @override
  ApbdesSummary getApbdes() => _dataSource.apbdes();

  static Result<T> guard<T>(T Function() reader) {
    try {
      return Result<T>.success(reader());
    } on Exception catch (error) {
      return Result<T>.failure(mapUnknownError(error));
    }
  }
}
