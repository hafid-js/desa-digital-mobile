import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/lapak_warga/data/datasources/opsi_lapak_data_source.dart';
import 'package:desa_digital/features/lapak_warga/data/datasources/produk_data_source.dart';
import 'package:desa_digital/features/lapak_warga/data/repositories/lapak_warga_repository_impl.dart';
import 'package:desa_digital/features/lapak_warga/domain/repositories/lapak_warga_repository.dart';
import 'package:desa_digital/features/lapak_warga/domain/usecases/lapak_warga_usecases.dart';
import 'package:desa_digital/features/lapak_warga/presentation/controllers/lapak_warga_controller.dart';
import 'package:get/get.dart';

class LapakWargaBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<ProdukDataSource>(
      ProdukDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<OpsiLapakDataSource>(
      OpsiLapakDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<LapakWargaRepository>(
      () => LapakWargaRepositoryImpl(
        Injector.resolve<ProdukDataSource>(),
        Injector.resolve<OpsiLapakDataSource>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<LoadProdukLapak>(
      () => LoadProdukLapak(Injector.resolve<LapakWargaRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetOpsiLapak>(
      () => GetOpsiLapak(Injector.resolve<LapakWargaRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<LapakWargaController>(
      () => LapakWargaController(
        Injector.resolve<LoadProdukLapak>(),
        Injector.resolve<GetOpsiLapak>(),
      ),
      lazy: true,
    );
  }
}
