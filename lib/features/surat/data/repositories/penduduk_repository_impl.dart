import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/surat/data/datasources/penduduk_data_source.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';
import 'package:desa_digital/features/surat/domain/repositories/penduduk_repository.dart';

class PendudukRepositoryImpl implements PendudukRepository {
  PendudukRepositoryImpl(this._dataSource);

  final PendudukDataSource _dataSource;

  @override
  Future<Result<List<Penduduk>>> semua() async {
    try {
      return Result<List<Penduduk>>.success(_dataSource.semua());
    } on Exception catch (error) {
      return Result<List<Penduduk>>.failure(mapUnknownError(error));
    }
  }

  @override
  Future<Result<List<Penduduk>>> cari(String kataKunci) async {
    try {
      return Result<List<Penduduk>>.success(_dataSource.cari(kataKunci));
    } on Exception catch (error) {
      return Result<List<Penduduk>>.failure(mapUnknownError(error));
    }
  }
}
