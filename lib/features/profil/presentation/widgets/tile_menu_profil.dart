import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/constants/app_config.dart';
import 'package:desa_digital/features/profil/domain/entities/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class TileMenuProfil extends StatelessWidget {
  const TileMenuProfil({super.key, required this.item});

  final ProfileMenuItem item;

  static const Map<ProfileMenuAction, IconData> _ikon = {
    ProfileMenuAction.profileInfo: Iconsax.profile_circle,
    ProfileMenuAction.accountSettings: Iconsax.setting_2,
    ProfileMenuAction.myStore: Iconsax.shopping_bag,
    ProfileMenuAction.helpCenter: Icons.contact_support_outlined,
    ProfileMenuAction.termsConditions: Iconsax.document_text,
    ProfileMenuAction.privacyPolicy: Iconsax.security,
    ProfileMenuAction.rateApp: Iconsax.star,
  };

  static const String _privacyPolicyUrl =
      'https://laporgub.jatengprov.go.id/privacy';
  static const String _termsAndConditionsUrl =
      'https://lakon.jatengprov.go.id/ketentuan-pengguna';

  static Future<void> _openExternal(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

  void _handleTap() {
    switch (item.action) {
      case ProfileMenuAction.profileInfo:
        Get.toNamed(Routes.detailProfil);
      case ProfileMenuAction.accountSettings:
        Get.toNamed(Routes.pengaturanAkun);
        case ProfileMenuAction.myStore:
        Get.toNamed(Routes.lapakSaya);
      case ProfileMenuAction.privacyPolicy:
        _openExternal(_privacyPolicyUrl);
      case ProfileMenuAction.termsConditions:
        _openExternal(_termsAndConditionsUrl);

      case ProfileMenuAction.helpCenter:
      case ProfileMenuAction.rateApp:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRateApp = item.action == ProfileMenuAction.rateApp;
    final trailingColor = AppColors.primary.withAlpha(180);

    return Column(
      children: [
        InkWell(
          onTap: _handleTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(_ikon[item.action], size: 25, color: trailingColor),
                  const SizedBox(width: 10),
                  Text(
                    item.label,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 15),
                  ),
                ],
              ),
              Row(
                children: [
                  if (isRateApp)
                    Text(
                      'v${AppConfig.appVersion}',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.black,
                        fontSize: 11,
                      ),
                    ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 22,
                    color: trailingColor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        if (item.showDivider)
          Divider(color: AppColors.grey.withAlpha(80), thickness: 1),
        const SizedBox(height: 18),
      ],
    );
  }
}
