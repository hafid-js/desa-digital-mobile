import 'package:desa_digital/features/surat/domain/entities/jenis_kelamin.dart';
import 'package:desa_digital/features/surat/domain/entities/pekerjaan.dart';
import 'package:desa_digital/features/surat/domain/utils/hitung_umur.dart';

class DataPenduduk {
  const DataPenduduk({
    this.nik,
    this.name,
    this.birthPlace,
    this.birthDate,
    this.gender,
    this.occupation,
    this.address,
  });

  final String? nik;
  final String? name;
  final String? birthPlace;
  final DateTime? birthDate;
  final JenisKelamin? gender;
  final Pekerjaan? occupation;
  final String? address;

  int? get age {
    final value = birthDate;
    return value == null ? null : HitungUmur.tahunSejak(value);
  }

  String get labelUmur => HitungUmur.formatTahun(age);

  String get labelTempatTanggalLahir {
    if (birthPlace == null && birthDate == null) return '-';
    final place = birthPlace ?? '-';
    final date = birthDate == null ? '-' : HitungUmur.formatTanggal(birthDate!);
    return '$place, $date';
  }

  Map<String, dynamic> toMap() => {
    'nik': nik,
    'nama': name,
    'tempat_lahir': birthPlace,
    'tanggal_lahir': birthDate?.toIso8601String(),
    'umur': age,
    'jenis_kelamin': gender?.label,
    'pekerjaan': occupation?.label,
    'pekerjaan_id': occupation?.code,
    'alamat': address,
  };
}
