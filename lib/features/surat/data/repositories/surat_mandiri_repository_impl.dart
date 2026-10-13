import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/surat/data/datasources/surat_mandiri_data_source.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:desa_digital/features/surat/domain/repositories/surat_mandiri_repository.dart';

class SuratMandiriRepositoryImpl implements SuratMandiriRepository {
  SuratMandiriRepositoryImpl(this._dataSource);

  final SuratMandiriDataSource _dataSource;

  @override
  Result<List<SuratMandiri>> katalog() => _sync(_dataSource.katalog);

  @override
  Result<List<SuratMandiri>> katalogSiap() => _sync(_dataSource.katalogSiap);

  @override
  Result<List<SuratMandiri>> katalogPerluProses() =>
      _sync(_dataSource.katalogPerluProses);

  Result<List<SuratMandiri>> _sync(List<SuratMandiri> Function() read) {
    try {
      return Result<List<SuratMandiri>>.success(read());
    } on Exception catch (error) {
      return Result<List<SuratMandiri>>.failure(mapUnknownError(error));
    }
  }

  @override
  Future<Result<void>> kirim(Map<String, dynamic> data) async {
    try {
      _dataSource.kirim(data);
      return const Result<void>.success(null);
    } on Exception catch (error) {
      return Result<void>.failure(mapUnknownError(error));
    }
  }
}
