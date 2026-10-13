import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/home/data/datasources/home_local_data_source.dart';
import 'package:desa_digital/features/home/data/repositories/home_repository_impl.dart';
import 'package:desa_digital/features/home/domain/repositories/home_repository.dart';
import 'package:desa_digital/features/home/domain/usecases/get_apbdes_summary.dart';
import 'package:desa_digital/features/home/domain/usecases/get_home_agenda.dart';
import 'package:desa_digital/features/home/domain/usecases/get_home_articles.dart';
import 'package:desa_digital/features/home/domain/usecases/get_home_menu_items.dart';
import 'package:desa_digital/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<HomeDataSource>(
      HomeLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<HomeRepository>(
      () => HomeRepositoryImpl(Injector.resolve<HomeDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetHomeMenuItems>(
      () => GetHomeMenuItems(Injector.resolve<HomeRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetHomeAgenda>(
      () => GetHomeAgenda(Injector.resolve<HomeRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetHomeArticles>(
      () => GetHomeArticles(Injector.resolve<HomeRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetApbdesSummary>(
      () => GetApbdesSummary(Injector.resolve<HomeRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<HomeController>(
      () => HomeController(
        Injector.resolve<GetHomeMenuItems>(),
        Injector.resolve<GetHomeAgenda>(),
        Injector.resolve<GetHomeArticles>(),
        Injector.resolve<GetApbdesSummary>(),
      ),
      lazy: true,
      permanent: true,
    );
  }
}
