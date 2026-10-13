import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/peraturan_desa/data/datasources/village_regulation_local_data_source.dart';
import 'package:desa_digital/features/peraturan_desa/data/repositories/village_regulation_repository_impl.dart';
import 'package:desa_digital/features/peraturan_desa/domain/repositories/village_regulation_repository.dart';
import 'package:desa_digital/features/peraturan_desa/domain/usecases/get_village_regulations.dart';
import 'package:desa_digital/features/peraturan_desa/presentation/controllers/village_regulation_controller.dart';
import 'package:get/get.dart';

class VillageRegulationBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<VillageRegulationDataSource>(
      VillageRegulationLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<VillageRegulationRepository>(
      () => VillageRegulationRepositoryImpl(
        Injector.resolve<VillageRegulationDataSource>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetVillageRegulations>(
      () => GetVillageRegulations(
        Injector.resolve<VillageRegulationRepository>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<VillageRegulationController>(
      () => VillageRegulationController(
        Injector.resolve<GetVillageRegulations>(),
      ),
      lazy: true,
      permanent: true,
    );
  }
}
