import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/artikel/data/datasources/article_local_data_source.dart';
import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';
import 'package:desa_digital/features/artikel/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  const ArticleRepositoryImpl(this._dataSource);

  final ArticleDataSource _dataSource;

  @override
  Result<List<ArticleCategory>> categories() {
    try {
      return Result<List<ArticleCategory>>.success(_dataSource.categories());
    } on Exception catch (error) {
      return Result<List<ArticleCategory>>.failure(mapUnknownError(error));
    }
  }
}
