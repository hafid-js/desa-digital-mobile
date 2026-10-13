enum Agama {
  islam('ISLAM'),
  kristen('KRISTEN'),
  katholik('KATHOLIK'),
  hindu('HINDU'),
  budha('BUDHA'),
  khonghucu('KHONGHUCU'),
  lainnya('Kepercayaan Terhadap Tuhan YME / Lainnya');

  const Agama(this.label);

  final String label;
}

extension AgamaLabels on List<Agama> {
  List<String> get labels => map((item) => item.label).toList();
}
