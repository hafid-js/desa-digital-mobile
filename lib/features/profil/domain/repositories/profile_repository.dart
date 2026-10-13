import 'package:desa_digital/features/profil/domain/entities/profile_form_options.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_menu_item.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_user.dart';

abstract interface class ProfileRepository {
  ProfileUser getUser();

  List<ProfileMenuSection> getMenuSections();

  List<ProfileDetail> getPersonalDetails();

  ProfileFormOptions getFormOptions();
}
