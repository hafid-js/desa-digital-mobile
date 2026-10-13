import 'package:desa_digital/features/surat/data/datasources/katalog_surat_mandiri_data_source.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';

class SuratMandiriDataSource {
  SuratMandiriDataSource(this._katalog);

  final KatalogSuratMandiriDataSource _katalog;

  final List<Map<String, dynamic>> _terkirim = [];

  List<Map<String, dynamic>> get terkirim => List.unmodifiable(_terkirim);

  List<SuratMandiri> katalog() => _katalog.semua();

  List<SuratMandiri> katalogSiap() => _katalog.mandiriSiap();

  List<SuratMandiri> katalogPerluProses() => _katalog.perluProses();

  void kirim(Map<String, dynamic> data) => _terkirim.add(data);
}
