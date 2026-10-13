import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/profil/presentation/controllers/profile_controller.dart';
import 'package:desa_digital/features/profil/presentation/widgets/detail_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class DetailProfilScreen extends StatelessWidget {
  const DetailProfilScreen({super.key});

  ProfileController get _controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Data Diri", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.only(top: 20, right: 1, left: 1, bottom: 1),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary.withAlpha(40),
                      radius: 45,
                      child: Icon(
                        Iconsax.user,
                        size: 30,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final detail in _controller.personalDetails)
                          DetailInfoTile(
                            title: detail.title,
                            value: detail.value,
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.ubahProfil),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Ubah Data",
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
