import 'package:desa_digital/features/surat/domain/entities/jenis_kelamin.dart';

class ValidasiNik {
  const ValidasiNik._();

  static const int length = 16;

  static String? validate(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'NIK wajib diisi';
    if (text.length != length) {
      return 'NIK harus terdiri dari $length digit';
    }
    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return 'NIK hanya boleh berisi angka';
    }
    if (text.startsWith('0')) {
      return 'NIK sementara belum dapat digunakan untuk surat ini';
    }
    if (tanggalLahirDari(text) == null) {
      return 'Tanggal lahir pada NIK tidak valid';
    }
    if (jenisKelaminDari(text) == null) {
      return 'Jenis kelamin pada NIK tidak valid';
    }
    return null;
  }

  static DateTime? tanggalLahirDari(String nik) {
    if (nik.length != length || !RegExp(r'^\d+$').hasMatch(nik)) return null;
    return _parseBirthDate(nik.substring(6, 12));
  }

  static JenisKelamin? jenisKelaminDari(String nik) {
    if (nik.length != length || !RegExp(r'^\d+$').hasMatch(nik)) return null;
    return switch (int.tryParse(nik[13])) {
      1 => JenisKelamin.lakiLaki,
      2 => JenisKelamin.perempuan,
      _ => null,
    };
  }

  static DateTime? _parseBirthDate(String part) {
    final day = int.tryParse(part.substring(0, 2));
    final month = int.tryParse(part.substring(2, 4));
    final year = int.tryParse(part.substring(4, 6));
    if (day == null || month == null || year == null) return null;
    if (month < 1 || month > 12 || day < 1 || day > 31) return null;

    final fullYear = year + 2000;
    if (fullYear < 1900) return null;

    final candidate = DateTime(fullYear, month, day);
    if (candidate.day != day || candidate.month != month) return null;
    if (candidate.isAfter(DateTime.now())) return null;
    return candidate;
  }
}
