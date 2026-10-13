import 'package:intl/intl.dart';

class HitungUmur {
  const HitungUmur._();

  static int? tahunAntara(DateTime birthDate, DateTime reference) {
    if (birthDate.isAfter(reference)) return null;
    var years = reference.year - birthDate.year;
    final hasHadBirthday =
        reference.month > birthDate.month ||
        (reference.month == birthDate.month && reference.day >= birthDate.day);
    if (!hasHadBirthday) years -= 1;
    return years < 0 ? null : years;
  }

  static int? tahunSejak(DateTime birthDate) =>
      tahunAntara(birthDate, DateTime.now());

  static String formatTahun(int? years) =>
      years == null ? '-' : years.toString().padLeft(3, '0');

  static String formatTahunSejak(DateTime? birthDate) =>
      formatTahun(birthDate == null ? null : tahunSejak(birthDate));

  static String formatTanggal(DateTime date) =>
      DateFormat('dd-MM-yyyy').format(date);

  static String formatHari(DateTime date) =>
      DateFormat('EEEE', 'id_ID').format(date);
}
