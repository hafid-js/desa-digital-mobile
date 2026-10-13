enum YangMenerangkan {
  dokter('Dokter', 1),
  bidanPerawat('Bidan/Perawat', 2),
  dukun('Dukun', 3),
  lainnya('Lainnya', 4);

  const YangMenerangkan(this.label, this.code);

  final String label;
  final int code;
}

extension YangMenerangkanLabels on List<YangMenerangkan> {
  List<String> get labels => map((item) => item.label).toList();
}
