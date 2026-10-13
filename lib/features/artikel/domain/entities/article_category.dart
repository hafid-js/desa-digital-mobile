class ArticleSample {
  const ArticleSample({required this.title});

  final String title;
}

class ArticleCategory {
  const ArticleCategory({required this.label, required this.samples});

  final String label;
  final List<ArticleSample> samples;
}
