import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/profil/data/datasources/profile_local_data_source.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_form_options.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_menu_item.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_user.dart';
import 'package:desa_digital/features/profil/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._dataSource);

  final ProfileDataSource _dataSource;

  @override
  ProfileUser getUser() => _dataSource.user();

  @override
  List<ProfileMenuSection> getMenuSections() => _dataSource.menuSections();

  @override
  List<ProfileDetail> getPersonalDetails() => _dataSource.personalDetails();

  @override
  ProfileFormOptions getFormOptions() => _dataSource.formOptions();

  static Result<T> guard<T>(T Function() reader) {
    try {
      return Result<T>.success(reader());
    } on Exception catch (error) {
      return Result<T>.failure(mapUnknownError(error));
    }
  }
}
