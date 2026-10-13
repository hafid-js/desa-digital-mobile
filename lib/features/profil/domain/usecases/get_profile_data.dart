import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_form_options.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_menu_item.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_user.dart';
import 'package:desa_digital/features/profil/domain/repositories/profile_repository.dart';

class GetProfileUser extends BaseUseCase<ProfileUser, NoParams> {
  const GetProfileUser(this._repository);

  final ProfileRepository _repository;

  @override
  Result<ProfileUser> execute(NoParams params) =>
      Result<ProfileUser>.success(_repository.getUser());
}

class GetProfileMenuSections
    extends BaseUseCase<List<ProfileMenuSection>, NoParams> {
  const GetProfileMenuSections(this._repository);

  final ProfileRepository _repository;

  @override
  Result<List<ProfileMenuSection>> execute(NoParams params) =>
      Result<List<ProfileMenuSection>>.success(_repository.getMenuSections());
}

class GetPersonalDetails extends BaseUseCase<List<ProfileDetail>, NoParams> {
  const GetPersonalDetails(this._repository);

  final ProfileRepository _repository;

  @override
  Result<List<ProfileDetail>> execute(NoParams params) =>
      Result<List<ProfileDetail>>.success(_repository.getPersonalDetails());
}

class GetProfileFormOptions extends BaseUseCase<ProfileFormOptions, NoParams> {
  const GetProfileFormOptions(this._repository);

  final ProfileRepository _repository;

  @override
  Result<ProfileFormOptions> execute(NoParams params) =>
      Result<ProfileFormOptions>.success(_repository.getFormOptions());
}
