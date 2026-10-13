enum ApbdesLabelAlignment { start, center }

class ApbdesItem {
  const ApbdesItem({
    required this.title,
    required this.realAmount,
    required this.targetAmount,
    required this.progress,
    required this.percentageText,
    this.labelAlignment = ApbdesLabelAlignment.start,
  });

  final String title;
  final String realAmount;
  final String targetAmount;

  final double progress;

  final String percentageText;

  final ApbdesLabelAlignment labelAlignment;
}

class ApbdesSection {
  const ApbdesSection({required this.title, required this.items});

  final String title;
  final List<ApbdesItem> items;
}

class ApbdesTotal {
  const ApbdesTotal({required this.realAmount, required this.targetAmount});

  final int realAmount;
  final int targetAmount;

  double get progress => targetAmount == 0 ? 0 : realAmount / targetAmount;

  String get percentageText => '${(progress * 100).toStringAsFixed(1)}%';
}

class ApbdesSummary {
  const ApbdesSummary({
    required this.pelaksanaan,
    required this.pendapatan,
    required this.pembelanjaan,
  });

  final ApbdesSection pelaksanaan;
  final ApbdesSection pendapatan;
  final ApbdesSection pembelanjaan;
}
