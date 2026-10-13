import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/bordered_pill_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class PanduanPengaduan extends StatelessWidget {
  const PanduanPengaduan({
    super.key,
    required this.agreeChecked,
    required this.onAgreeChanged,
  });

  final bool agreeChecked;
  final ValueChanged<bool> onAgreeChanged;

  void _openForm() => Get.toNamed(Routes.formulirPengaduan);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Perhatikan informasi berikut sebelum melaporkan aduan",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                const _CatatanPanduan(
                  icon: Iconsax.profile_2user,
                  title: "Anonim",
                  description:
                      "Identitas pelapor tidak akan ditampilkan di dalam aduan. "
                      "Identitas hanya dapat dilihat oleh dirimu dan admin utama.",
                  descriptionMaxLines: 5,
                ),
                const SizedBox(height: 20),
                const _CatatanPanduan(
                  icon: Iconsax.lock,
                  title: "Aduan Privat (Rahasia)",
                  description:
                      "Jenis aduan akan otomatis terpilih privat/rahasia. "
                      "Aduan hanya dapat dilihat oleh petugas",
                  descriptionMaxLines: 2,
                ),
                const SizedBox(height: 20),
                const _CatatanPanduan(
                  icon: Iconsax.global,
                  title: "Aduan Publik",
                  description:
                      "Jenis aduan dapat kamu ubah menjadi publik jika kamu ingin "
                      "aduan terlihat oleh pengguna aplikasi lainnya. Jika aduan "
                      "Publik berisi data pribadi maka jenis akan diubah menjadi "
                      "privat/rahasia.",
                  descriptionMaxLines: 5,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.dark.withAlpha(10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Saya sudah mengerti, jangan tampilkan lagi",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              value: agreeChecked,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.primary;
                }
                return Colors.white;
              }),
              checkColor: Colors.white,
              side: BorderSide(color: AppColors.primary, width: 1.5),
              onChanged: (v) => onAgreeChanged(v ?? false),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: BorderedPillButton(
                  text: "Batal",
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: BorderedPillButton(
                  text: "Lanjutkan",
                  color: AppColors.primary,
                  onPressed: _openForm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CatatanPanduan extends StatelessWidget {
  const _CatatanPanduan({
    required this.icon,
    required this.title,
    required this.description,
    required this.descriptionMaxLines,
  });

  final IconData icon;
  final String title;
  final String description;
  final int descriptionMaxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 5),
              Text(
                description,
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: descriptionMaxLines,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
