import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/profil/data/datasources/profile_local_data_source.dart';
import 'package:desa_digital/features/profil/data/repositories/profile_repository_impl.dart';
import 'package:desa_digital/features/profil/domain/repositories/profile_repository.dart';
import 'package:desa_digital/features/profil/domain/usecases/get_profile_data.dart';
import 'package:desa_digital/features/profil/presentation/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<ProfileDataSource>(
      ProfileLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<ProfileRepository>(
      () => ProfileRepositoryImpl(Injector.resolve<ProfileDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetProfileUser>(
      () => GetProfileUser(Injector.resolve<ProfileRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetProfileMenuSections>(
      () => GetProfileMenuSections(Injector.resolve<ProfileRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetPersonalDetails>(
      () => GetPersonalDetails(Injector.resolve<ProfileRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetProfileFormOptions>(
      () => GetProfileFormOptions(Injector.resolve<ProfileRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<ProfileController>(
      () => ProfileController(
        Injector.resolve<GetProfileUser>(),
        Injector.resolve<GetProfileMenuSections>(),
        Injector.resolve<GetPersonalDetails>(),
        Injector.resolve<GetProfileFormOptions>(),
      ),
      lazy: true,
      permanent: true,
    );
  }
}
