import 'package:desa_digital/features/surat/data/datasources/penduduk_data_source.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';

class AkunDataSource {
  const AkunDataSource(this._penduduk);

  final PendudukDataSource _penduduk;

  Penduduk? profilAktif() {
    final daftar = _penduduk.semua();
    return daftar.isEmpty ? null : daftar.first;
  }
}
