import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';

abstract interface class ArticleDataSource {
  List<ArticleCategory> categories();
}

class ArticleLocalDataSource implements ArticleDataSource {
  const ArticleLocalDataSource();

  @override
  List<ArticleCategory> categories() => articleCategories;
}

const ArticleSample _publicSample = ArticleSample(
  title: "Kala Gelaran Final MTQ 2026 di Jateng Pukau Ribuan Orang",
);

const ArticleSample _opdSample = ArticleSample(
  title: "Timsel Calon Anggota Komisi Informasi Jamin Kerahasiaan Soal Seleksi",
);

const List<ArticleSample> _publicSamples = [
  _publicSample,
  _publicSample,
  _publicSample,
];

const List<ArticleSample> _opdSamples = [_opdSample, _opdSample, _opdSample];

const List<ArticleCategory> articleCategories = [
  ArticleCategory(label: "Publik", samples: _publicSamples),
  ArticleCategory(label: "Rilis", samples: _opdSamples),
  ArticleCategory(label: "Berita Daerah", samples: _opdSamples),
  ArticleCategory(label: "Berita OPD", samples: _opdSamples),
];
