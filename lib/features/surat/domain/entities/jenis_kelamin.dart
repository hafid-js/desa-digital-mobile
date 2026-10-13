enum JenisKelamin {
  lakiLaki('Laki-laki', 1),
  perempuan('Perempuan', 2);

  const JenisKelamin(this.label, this.code);

  final String label;
  final int code;
}

extension JenisKelaminLabels on List<JenisKelamin> {
  List<String> get labels => map((item) => item.label).toList();
}
