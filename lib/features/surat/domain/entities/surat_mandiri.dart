enum TipeFieldSurat { teks, teksArea, tanggal, opsi }

class FieldSurat {
  const FieldSurat({
    required this.label,
    required this.tipe,
    required this.hint,
    this.wajib = true,
    this.pilihan = const [],
  });

  final String label;
  final TipeFieldSurat tipe;
  final String hint;
  final bool wajib;
  final List<String> pilihan;
}

class SuratMandiri {
  const SuratMandiri({
    required this.code,
    required this.title,
    required this.ringkasan,
    required this.lampiran,
    required this.fields,
    this.fieldsIdentitasKedua = const [],
    this.sudahDiimplementasikan = false,
    this.butuhIdentitasKedua = false,
  });

  final String code;
  final String title;
  final String ringkasan;
  final String? lampiran;
  final List<FieldSurat> fields;
  final List<FieldSurat> fieldsIdentitasKedua;
  final bool sudahDiimplementasikan;
  final bool butuhIdentitasKedua;

  int get masaBerlakuBulan => 1;

  String get labelMasaBerlaku =>
      'Berlaku $masaBerlakuBulan bulan sejak diterbitkan';

  String? get labelLampiran => lampiran == null ? null : 'Lampiran $lampiran';
}
