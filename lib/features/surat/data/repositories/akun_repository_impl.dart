import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/surat/data/datasources/akun_data_source.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';
import 'package:desa_digital/features/surat/domain/repositories/akun_repository.dart';

class AkunRepositoryImpl implements AkunRepository {
  AkunRepositoryImpl(this._dataSource);

  final AkunDataSource _dataSource;

  @override
  Future<Result<Penduduk?>> profilAktif() async {
    try {
      return Result<Penduduk?>.success(_dataSource.profilAktif());
    } on Exception catch (error) {
      return Result<Penduduk?>.failure(mapUnknownError(error));
    }
  }
}
