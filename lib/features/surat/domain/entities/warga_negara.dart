enum WargaNegara {
  wni('WNI', 1),
  wna('WNA', 2),
  duakewarganegaraan('DUA KEWARGANEGARAAN', 3);

  const WargaNegara(this.label, this.code);

  final String label;
  final int code;
}

extension WargaNegaraLabels on List<WargaNegara> {
  List<String> get labels => map((item) => item.label).toList();
}
