import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/surat/data/datasources/akun_data_source.dart';
import 'package:desa_digital/features/surat/data/datasources/katalog_surat_mandiri_data_source.dart';
import 'package:desa_digital/features/surat/data/datasources/penduduk_data_source.dart';
import 'package:desa_digital/features/surat/data/datasources/surat_mandiri_data_source.dart';
import 'package:desa_digital/features/surat/data/repositories/akun_repository_impl.dart';
import 'package:desa_digital/features/surat/data/repositories/penduduk_repository_impl.dart';
import 'package:desa_digital/features/surat/data/repositories/surat_mandiri_repository_impl.dart';
import 'package:desa_digital/features/surat/domain/repositories/akun_repository.dart';
import 'package:desa_digital/features/surat/domain/repositories/penduduk_repository.dart';
import 'package:desa_digital/features/surat/domain/repositories/surat_mandiri_repository.dart';
import 'package:desa_digital/features/surat/domain/usecases/surat_usecases.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:get/get.dart';

class SuratBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<PendudukDataSource>(
      PendudukDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<AkunDataSource>(
      () => AkunDataSource(Injector.resolve<PendudukDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<KatalogSuratMandiriDataSource>(
      KatalogSuratMandiriDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<SuratMandiriDataSource>(
      () => SuratMandiriDataSource(
        Injector.resolve<KatalogSuratMandiriDataSource>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<AkunRepository>(
      () => AkunRepositoryImpl(Injector.resolve<AkunDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<PendudukRepository>(
      () => PendudukRepositoryImpl(Injector.resolve<PendudukDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<SuratMandiriRepository>(
      () => SuratMandiriRepositoryImpl(
        Injector.resolve<SuratMandiriDataSource>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetProfilAktif>(
      () => GetProfilAktif(Injector.resolve<AkunRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<CariPenduduk>(
      () => CariPenduduk(Injector.resolve<PendudukRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetKatalogSuratMandiri>(
      () => GetKatalogSuratMandiri(Injector.resolve<SuratMandiriRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetKatalogSuratPerluProses>(
      () => GetKatalogSuratPerluProses(
        Injector.resolve<SuratMandiriRepository>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<KirimSuratMandiri>(
      () => KirimSuratMandiri(Injector.resolve<SuratMandiriRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<SuratController>(
      () => SuratController(
        Injector.resolve<GetProfilAktif>(),
        Injector.resolve<GetKatalogSuratMandiri>(),
        Injector.resolve<GetKatalogSuratPerluProses>(),
        Injector.resolve<KirimSuratMandiri>(),
      ),
      lazy: true,
      permanent: true,
    );
  }
}
