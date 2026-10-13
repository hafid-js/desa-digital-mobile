enum JenisSurat {
  domicile(
    code: 'S-41',
    title: 'Surat Keterangan Domisili',
    lampiran: null,
    masaBerlakuBulan: 1,
    mandiri: true,
  ),
  birth(
    code: 'S-17',
    title: 'Surat Keterangan Kelahiran',
    lampiran: 'F-2.01-KELAHIRAN',
    masaBerlakuBulan: 1,
    mandiri: false,
  ),
  death(
    code: 'S-21',
    title: 'Surat Keterangan Kematian',
    lampiran: 'F-2.01-KEMATIAN',
    masaBerlakuBulan: 1,
    mandiri: false,
  );

  const JenisSurat({
    required this.code,
    required this.title,
    required this.lampiran,
    required this.masaBerlakuBulan,
    required this.mandiri,
  });

  final String code;
  final String title;
  final String? lampiran;
  final int masaBerlakuBulan;
  final bool mandiri;

  String get labelMasaBerlaku =>
      'Berlaku $masaBerlakuBulan bulan sejak diterbitkan';

  String? get labelLampiran => lampiran == null ? null : 'Lampiran $lampiran';
}
