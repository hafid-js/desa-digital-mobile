import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class MainInfoForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const MainInfoForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
  });

  Widget _buildTextField({
    required String label,
    IconData? suffixIcon,
    TextEditingController? controller,
    bool editable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        readOnly: !editable,
        onTap: editable
            ? null
            : () {
                if (label == "Email") {
                  Get.toNamed(Routes.ubahEmail);
                } else if (label == "Nomor Whatsapp") {
                  Get.toNamed(Routes.ubahTelepon);
                }
              },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
          floatingLabelStyle: TextStyle(color: AppColors.primary),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          suffixIcon: suffixIcon != null
              ? label == "Email"
                    ? GestureDetector(
                        onTap: () => Get.toNamed(Routes.ubahEmail),
                        child: Icon(suffixIcon, size: 18),
                      )
                    : label == "Nomor Whatsapp"
                    ? GestureDetector(
                        onTap: () => Get.toNamed(Routes.ubahTelepon),
                        child: Icon(suffixIcon, size: 18),
                      )
                    : Icon(suffixIcon, size: 18)
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informasi Utama",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 15),
          _buildTextField(
            label: "Nama Lengkap",
            controller: fullNameController,
            editable: true,
          ),
          _buildTextField(
            label: "Email",
            controller: emailController,
            suffixIcon: Iconsax.edit,
          ),
          _buildTextField(
            label: "Nomor Whatsapp",
            controller: phoneController,
            suffixIcon: Iconsax.edit,
          ),
        ],
      ),
    );
  }
}
