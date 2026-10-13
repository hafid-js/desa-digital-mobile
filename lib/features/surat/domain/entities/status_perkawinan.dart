enum StatusPerkawinan {
  belumkawin('BELUM KAWIN', 1),
  kawin('KAWIN', 2),
  ceraihidup('CERAI HIDUP', 3),
  ceraimati('CERAI MATI', 4);

  const StatusPerkawinan(this.label, this.code);

  final String label;
  final int code;
}

extension StatusPerkawinanLabels on List<StatusPerkawinan> {
  List<String> get labels => map((item) => item.label).toList();
}
