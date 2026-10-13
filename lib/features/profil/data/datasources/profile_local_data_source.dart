import 'package:desa_digital/features/profil/domain/entities/profile_form_options.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_menu_item.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_user.dart';

abstract interface class ProfileDataSource {
  ProfileUser user();

  List<ProfileMenuSection> menuSections();

  List<ProfileDetail> personalDetails();

  ProfileFormOptions formOptions();
}

class ProfileLocalDataSource implements ProfileDataSource {
  const ProfileLocalDataSource();

  @override
  ProfileUser user() => _user;

  @override
  List<ProfileMenuSection> menuSections() => List.unmodifiable(_menuSections);

  @override
  List<ProfileDetail> personalDetails() => List.unmodifiable(_personalDetails);

  @override
  ProfileFormOptions formOptions() => _formOptions;
}

const ProfileUser _user = ProfileUser(
  displayName: "Unknown",
  email: "support@hafidtech.com",
  fullName: "HafidTech",
  formEmail: "dev@hafidtech.com",
  formPhone: "082322875277",
  maskedEmail: "dev*****@hafidtech.com",
  maskedPhone: "628232287****",
);

const List<ProfileMenuSection> _menuSections = [
  ProfileMenuSection(
    title: 'Akun',
    items: [
      ProfileMenuItem(
        label: 'Informasi Pribadi',
        action: ProfileMenuAction.profileInfo,
      ),
      ProfileMenuItem(
        label: 'Pengaturan Akun',
        action: ProfileMenuAction.accountSettings,
        showDivider: false,
      ),
      ProfileMenuItem(
        label: 'Lapak Saya',
        action: ProfileMenuAction.myStore,
        showDivider: false,
      ),
    ],
  ),
  ProfileMenuSection(
    title: 'Lainnya',
    items: [
      ProfileMenuItem(
        label: 'Pusat Bantuan',
        action: ProfileMenuAction.helpCenter,
      ),
      ProfileMenuItem(
        label: 'Syarat & Ketentuan',
        action: ProfileMenuAction.termsConditions,
      ),
      ProfileMenuItem(
        label: 'Kebijakan Privasi',
        action: ProfileMenuAction.privacyPolicy,
      ),
      ProfileMenuItem(
        label: 'Rating Aplikasi',
        action: ProfileMenuAction.rateApp,
        showDivider: false,
      ),
    ],
  ),
];

const List<ProfileDetail> _personalDetails = [
  ProfileDetail(title: "Nama", value: "Hafid Tech"),
  ProfileDetail(title: "Email", value: "dev*****@hafidtech.com"),
  ProfileDetail(title: "No. HP", value: "628232287****"),
  ProfileDetail(title: "NIK", value: "-"),
  ProfileDetail(title: "Tempat, Tanggal Lahir", value: "-,-"),
  ProfileDetail(title: "Jenis Kelamin", value: "-"),
  ProfileDetail(title: "Alamat", value: "-,-,-,-"),
  ProfileDetail(title: "Agama", value: "-"),
  ProfileDetail(title: "Status Perkawinan", value: "-"),
];

const ProfileFormOptions _formOptions = ProfileFormOptions(
  religion: ['ISLAM', 'PROTESTAN', 'KATHOLIK', 'HINDU', 'BUDDHA', 'KONGHUCU'],
  marriedStatus: ['BELUM KAWIN', 'KAWIN', 'CERAI HIDUP', 'CERAI MATI'],
  provinsi: ['DKI JAKARTA', 'JAWA TENGAH', 'JAWA BARAT', 'DIY YOGYAKARTA'],
  kabupaten: ['PURWOREJO', 'KEBUMEN', 'WONOSOBO', 'MAGELANG'],
  kecamatan: ['BRUNO', 'KEMIRI', 'PITURUH', 'KUTOARJO'],
  kelurahan: ['GUNUNG CONDONG', 'CEPEDAK', 'BRUNOREJO', 'KEMRANGGEN'],
);
