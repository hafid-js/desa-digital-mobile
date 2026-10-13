import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/artikel/data/datasources/article_local_data_source.dart';
import 'package:desa_digital/features/artikel/data/repositories/article_repository_impl.dart';
import 'package:desa_digital/features/artikel/domain/repositories/article_repository.dart';
import 'package:desa_digital/features/artikel/domain/usecases/get_article_categories.dart';
import 'package:desa_digital/features/artikel/presentation/controllers/article_controller.dart';
import 'package:get/get.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<ArticleDataSource>(
      ArticleLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<ArticleRepository>(
      () => ArticleRepositoryImpl(Injector.resolve<ArticleDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetArticleCategories>(
      () => GetArticleCategories(Injector.resolve<ArticleRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<ArticleController>(
      () => ArticleController(Injector.resolve<GetArticleCategories>()),
      lazy: true,
      permanent: true,
    );
  }
}
