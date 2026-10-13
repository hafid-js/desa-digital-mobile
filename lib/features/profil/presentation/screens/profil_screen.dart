import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/profil/presentation/controllers/profile_controller.dart';
import 'package:desa_digital/features/profil/presentation/widgets/tile_menu_profil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  ProfileController get _controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Profile",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      CircleAvatar(
                        backgroundColor: AppColors.primary.withAlpha(40),
                        radius: 45,
                        child: Icon(
                          Iconsax.user,
                          size: 30,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        _controller.user.value?.displayName ?? "",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _controller.user.value?.email ?? "",
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall!.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),

                ..._controller.menuSections.map((section) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 30),
                      for (final item in section.items)
                        TileMenuProfil(item: item),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
