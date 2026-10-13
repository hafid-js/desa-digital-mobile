import 'package:desa_digital/features/surat/domain/utils/hitung_umur.dart';

class Penduduk {
  const Penduduk({
    required this.id,
    required this.nik,
    required this.nama,
    required this.jenisKelamin,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.agama,
    required this.pekerjaan,
    required this.pendidikan,
    required this.statusPerkawinan,
    required this.wargaNegara,
    required this.alamat,
    required this.noKk,
    required this.kepalaKk,
    required this.hubungan,
  });

  final String id;
  final String nik;
  final String nama;
  final String jenisKelamin;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String agama;
  final String pekerjaan;
  final String pendidikan;
  final String statusPerkawinan;
  final String wargaNegara;
  final String alamat;
  final String noKk;
  final String kepalaKk;
  final String hubungan;

  int? get umur => HitungUmur.tahunSejak(tanggalLahir);

  String get labelUmur {
    final tahun = umur;
    return tahun == null ? '-' : '$tahun TAHUN';
  }

  String get tanggalLahirTerbaca => HitungUmur.formatTanggal(tanggalLahir);

  String get nikNama => '$nik - $nama';
}
