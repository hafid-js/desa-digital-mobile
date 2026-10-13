import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';

abstract interface class ArticleRepository {
  Result<List<ArticleCategory>> categories();
}
