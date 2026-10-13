import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';
import 'package:desa_digital/features/artikel/domain/usecases/get_article_categories.dart';
import 'package:get/get.dart';

class ArticleController extends GetxController {
  ArticleController(this._getArticleCategories);

  final GetArticleCategories _getArticleCategories;

  final List<ArticleCategory> kategori = <ArticleCategory>[];

  final RxnString pesanGagal = RxnString();

  @override
  void onInit() {
    super.onInit();
    _getArticleCategories(const NoParams()).fold(
      onSuccess: kategori.addAll,
      onFailure: (failure) => pesanGagal.value = failure.message,
    );
  }
}
