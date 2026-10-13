import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:desa_digital/features/surat/domain/usecases/surat_usecases.dart';

class SuratController {
  SuratController(
    this._getProfil,
    this._getKatalogMandiri,
    this._getKatalogPerluProses,
    this._kirim,
  );

  final GetProfilAktif _getProfil;
  final GetKatalogSuratMandiri _getKatalogMandiri;
  final GetKatalogSuratPerluProses _getKatalogPerluProses;
  final KirimSuratMandiri _kirim;

  List<SuratMandiri>? _mandiri;
  List<SuratMandiri>? _perluProses;

  List<SuratMandiri> get katalogMandiri =>
      _mandiri ??= _getKatalogMandiri(const NoParams()).valueOrNull ?? const [];

  List<SuratMandiri> get katalogPerluProses => _perluProses ??=
      _getKatalogPerluProses(const NoParams()).valueOrNull ?? const [];

  Future<Penduduk?> muatProfilAktif() async =>
      (await _getProfil(const NoParams())).valueOrNull;

  Future<bool> kirim(Map<String, dynamic> data) async =>
      (await _kirim(data)).isSuccess;
}
