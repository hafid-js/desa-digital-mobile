import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/pengaduan/data/datasources/wilayah_local_data_source.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah.dart';
import 'package:desa_digital/features/pengaduan/domain/repositories/wilayah_repository.dart';

class WilayahRepositoryImpl implements WilayahRepository {
  WilayahRepositoryImpl(this._dataSource);

  final WilayahDataSource _dataSource;

  Future<Result<List<Wilayah>>>? _cache;

  @override
  Future<Result<List<Wilayah>>> loadRegions() => _cache ??= _load();

  Future<Result<List<Wilayah>>> _load() async {
    try {
      return Result<List<Wilayah>>.success(await _dataSource.loadRegions());
    } on Exception catch (error) {
      return Result<List<Wilayah>>.failure(mapUnknownError(error));
    }
  }
}
