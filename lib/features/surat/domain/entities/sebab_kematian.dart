enum SebabKematian {
  sakitBiasa('Sakit biasa / tua', 1),
  wabahPenyakit('Wabah Penyakit', 2),
  kecelakaan('Kecelakaan', 3),
  kriminalitas('Kriminalitas', 4),
  bunuhDiri('Bunuh Diri', 5),
  lainnya('Lainnya', 6);

  const SebabKematian(this.label, this.code);

  final String label;
  final int code;
}

extension SebabKematianLabels on List<SebabKematian> {
  List<String> get labels => map((item) => item.label).toList();
}
