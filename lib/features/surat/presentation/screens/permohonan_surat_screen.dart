import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:desa_digital/core/widgets/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class PermohonanSuratScreen extends GetView<SuratController> {
  const PermohonanSuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jumlahMandiri = controller.katalogMandiri.length;
    final jumlahPerluProses = controller.katalogPerluProses.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Layanan Mandiri",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSectionHeading(
                title: "Status Surat",
                buttonTitle: "Lihat Semua",
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 28, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.inbox_rounded,
                      size: 40,
                      color: AppColors.quartenary.withAlpha(160),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Belum ada surat",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Surat yang Anda ajukan akan tampil di sini",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Layanan Mandiri",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Ajukan pembuatan surat yang sesuai kebutuhan Anda, Pilih Kategori dibawah ini.",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 11,
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSuratCard(
                          context,
                          title: "Surat Mandiri",
                          countText: "$jumlahMandiri Jenis Surat",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSuratCard(
                          context,
                          title: "Perlu Proses Desa",
                          countText: "$jumlahPerluProses Jenis Surat",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSuratCard(
  BuildContext context, {
  required String title,
  required String countText,
}) {
  return GestureDetector(
    onTap: () {
      if (title == "Surat Mandiri") {
        Get.toNamed(Routes.daftarSuratMandiri);
      } else {
        Get.toNamed(Routes.daftarSuratPerluProses);
      }
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FaIcon(
              FontAwesomeIcons.fileLines,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                countText,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: 11,
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Icon(
                Iconsax.arrow_right_3,
                size: 15,
                color: AppColors.textSecondaryLight,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
