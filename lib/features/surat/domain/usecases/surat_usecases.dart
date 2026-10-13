import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:desa_digital/features/surat/domain/repositories/akun_repository.dart';
import 'package:desa_digital/features/surat/domain/repositories/penduduk_repository.dart';
import 'package:desa_digital/features/surat/domain/repositories/surat_mandiri_repository.dart';

class GetProfilAktif extends BaseAsyncUseCase<Penduduk?, NoParams> {
  const GetProfilAktif(this._repository);

  final AkunRepository _repository;

  @override
  Future<Result<Penduduk?>> execute(NoParams params) =>
      _repository.profilAktif();
}

class GetPenduduk extends BaseAsyncUseCase<List<Penduduk>, NoParams> {
  const GetPenduduk(this._repository);

  final PendudukRepository _repository;

  @override
  Future<Result<List<Penduduk>>> execute(NoParams params) =>
      _repository.semua();
}

class CariPenduduk extends BaseAsyncUseCase<List<Penduduk>, String> {
  const CariPenduduk(this._repository);

  final PendudukRepository _repository;

  @override
  Future<Result<List<Penduduk>>> execute(String kataKunci) =>
      _repository.cari(kataKunci);
}

class GetKatalogSuratMandiri extends BaseUseCase<List<SuratMandiri>, NoParams> {
  const GetKatalogSuratMandiri(this._repository);

  final SuratMandiriRepository _repository;

  @override
  Result<List<SuratMandiri>> execute(NoParams params) =>
      _repository.katalogSiap();
}

class GetKatalogSuratPerluProses
    extends BaseUseCase<List<SuratMandiri>, NoParams> {
  const GetKatalogSuratPerluProses(this._repository);

  final SuratMandiriRepository _repository;

  @override
  Result<List<SuratMandiri>> execute(NoParams params) =>
      _repository.katalogPerluProses();
}

class KirimSuratMandiri extends BaseAsyncUseCase<void, Map<String, dynamic>> {
  const KirimSuratMandiri(this._repository);

  final SuratMandiriRepository _repository;

  @override
  Future<Result<void>> execute(Map<String, dynamic> data) =>
      _repository.kirim(data);
}
