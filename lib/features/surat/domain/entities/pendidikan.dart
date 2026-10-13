enum Pendidikan {
  belumSekolah('TIDAK/BELUM SEKOLAH', 1),
  belumTamatSd('BELUM TAMAT SD/SEDERAJAT', 2),
  tamatSd('TAMAT SD/SEDERAJAT', 3),
  sltp('SLTP/SEDERAJAT', 4),
  slta('SLTA/SEDERAJAT', 5),
  diploma('DIPLOMA I/II', 6),
  akademi('AKADEMI/DIPLOMA III/S. MUDA', 7),
  strataSatu('DIPLOMA IV/STRATA I', 8),
  strataDua('STRATA II', 9),
  strataTiga('STRATA III', 10);

  const Pendidikan(this.label, this.code);

  final String label;
  final int code;
}

extension PendidikanLabels on List<Pendidikan> {
  List<String> get labels => map((item) => item.label).toList();
}
