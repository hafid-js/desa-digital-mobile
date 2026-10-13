import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/profil/domain/entities/jenis_kelamin.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_form_options.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_menu_item.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_user.dart';
import 'package:desa_digital/features/profil/domain/usecases/get_profile_data.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ProfileController(
    this._getUser,
    this._getMenuSections,
    this._getPersonalDetails,
    this._getFormOptions,
  );

  final GetProfileUser _getUser;
  final GetProfileMenuSections _getMenuSections;
  final GetPersonalDetails _getPersonalDetails;
  final GetProfileFormOptions _getFormOptions;

  final Rxn<ProfileUser> user = Rxn<ProfileUser>();
  final RxList<ProfileMenuSection> menuSections = <ProfileMenuSection>[].obs;
  final RxList<ProfileDetail> personalDetails = <ProfileDetail>[].obs;
  final Rxn<ProfileFormOptions> formOptions = Rxn<ProfileFormOptions>();

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  final Rx<JenisKelamin?> selectedGender = Rx<JenisKelamin?>(null);

  @override
  void onInit() {
    super.onInit();
    _muat();

    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    _isiFormDariProfil();
  }

  void resetForm() {
    _isiFormDariProfil();
    selectedGender.value = null;
  }

  void _isiFormDariProfil() {
    final profile = user.value;
    fullNameController.text = profile?.fullName ?? '';
    emailController.text = profile?.formEmail ?? '';
    phoneController.text = profile?.formPhone ?? '';
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void selectGender(JenisKelamin? gender) => selectedGender.value = gender;

  void _muat() {
    user.value = _getUser(const NoParams()).valueOrNull;
    menuSections.assignAll(
      _getMenuSections(const NoParams()).valueOrNull ??
          const <ProfileMenuSection>[],
    );
    personalDetails.assignAll(
      _getPersonalDetails(const NoParams()).valueOrNull ??
          const <ProfileDetail>[],
    );
    formOptions.value = _getFormOptions(const NoParams()).valueOrNull;
  }
}
