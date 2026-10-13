import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/pengaduan/data/datasources/wilayah_local_data_source.dart';
import 'package:desa_digital/features/pengaduan/data/repositories/wilayah_repository_impl.dart';
import 'package:desa_digital/features/pengaduan/domain/repositories/wilayah_repository.dart';
import 'package:desa_digital/features/pengaduan/domain/usecases/wilayah_usecases.dart';
import 'package:desa_digital/features/pengaduan/presentation/controllers/pencarian_wilayah_controller.dart';
import 'package:get/get.dart';

class PengaduanBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<WilayahDataSource>(
      WilayahDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<WilayahRepository>(
      () => WilayahRepositoryImpl(Injector.resolve<WilayahDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<LoadWilayahCatalog>(
      () => LoadWilayahCatalog(Injector.resolve<WilayahRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<SearchWilayah>(
      SearchWilayah.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<PencarianWilayahController>(
      () => PencarianWilayahController(
        Injector.resolve<LoadWilayahCatalog>(),
        Injector.resolve<SearchWilayah>(),
      ),
      lazy: true,
      permanent: true,
    );
  }
}
