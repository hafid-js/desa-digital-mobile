import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';
import 'package:desa_digital/features/artikel/domain/repositories/article_repository.dart';

class GetArticleCategories
    extends BaseUseCase<List<ArticleCategory>, NoParams> {
  const GetArticleCategories(this._repository);

  final ArticleRepository _repository;

  @override
  Result<List<ArticleCategory>> execute(NoParams params) =>
      _repository.categories();
}
