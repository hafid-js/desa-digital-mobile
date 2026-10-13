import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/lapak_warga/data/datasources/opsi_lapak_data_source.dart';
import 'package:desa_digital/features/lapak_warga/data/datasources/produk_data_source.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/opsi_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/repositories/lapak_warga_repository.dart';

class LapakWargaRepositoryImpl implements LapakWargaRepository {
  LapakWargaRepositoryImpl(this._produkDataSource, this._opsiDataSource);

  final ProdukDataSource _produkDataSource;
  final OpsiLapakDataSource _opsiDataSource;

  @override
  Result<List<ProdukLapak>> loadProduk() {
    try {
      return Result<List<ProdukLapak>>.success(_produkDataSource.loadProduk());
    } on Exception catch (error) {
      return Result<List<ProdukLapak>>.failure(mapUnknownError(error));
    }
  }

  @override
  Result<OpsiLapak> loadOpsi() {
    try {
      return Result<OpsiLapak>.success(_opsiDataSource.loadOpsi());
    } on Exception catch (error) {
      return Result<OpsiLapak>.failure(mapUnknownError(error));
    }
  }
}
