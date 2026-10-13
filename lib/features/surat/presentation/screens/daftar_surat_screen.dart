import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:desa_digital/features/surat/presentation/screens/formulir_surat_mandiri_screen.dart';
import 'package:desa_digital/features/surat/presentation/widgets/field_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';

class DaftarSuratScreen extends GetView<SuratController> {
  const DaftarSuratScreen({super.key})
    : tampilMandiri = true,
      tampilPerluProses = true;

  const DaftarSuratScreen.mandiri({super.key})
    : tampilMandiri = true,
      tampilPerluProses = false;

  const DaftarSuratScreen.perluProses({super.key})
    : tampilMandiri = false,
      tampilPerluProses = true;

  final bool tampilMandiri;
  final bool tampilPerluProses;

  void _bukaMandiri(BuildContext context, SuratMandiri surat) {
    Get.to(
      () => FormulirSuratMandiriScreen(key: ValueKey(surat.code), surat: surat),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mandiri = controller.katalogMandiri;
    final perluProses = controller.katalogPerluProses;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Layanan Mandiri",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          if (tampilMandiri) ...[
            FieldLabel("Surat Mandiri (${mandiri.length})"),
            Text(
              "Warga bisa mengisi dan menghasilkan surat ini sendiri tanpa "
              "diproses perangkat desa.",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < mandiri.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              _KartuSurat(
                kode: mandiri[i].code,
                judul: mandiri[i].title,
                ringkasan: mandiri[i].ringkasan,
                onTap: () => _bukaMandiri(context, mandiri[i]),
              ),
            ],
          ],
          if (tampilMandiri && tampilPerluProses) const SizedBox(height: 24),
          if (tampilPerluProses) ...[
            FieldLabel("Perlu Proses Desa (${perluProses.length})"),
            Text(
              "Warga boleh mengajukan, tetapi surat tetap diverifikasi petugas "
              "desa sebelum diterbitkan.",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 11,
                color: Colors.black87,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < perluProses.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              _KartuSurat(
                kode: perluProses[i].code,
                judul: perluProses[i].title,
                ringkasan: perluProses[i].ringkasan,
                onTap: () {
                  if (perluProses[i].code == 'S-17') {
                    Get.toNamed(Routes.keteranganKelahiran);
                  } else {
                    Get.toNamed(Routes.keteranganKematian);
                  }
                },
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _KartuSurat extends StatelessWidget {
  const _KartuSurat({
    required this.kode,
    required this.judul,
    required this.ringkasan,
    required this.onTap,
  });

  final String kode;
  final String judul;
  final String ringkasan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$kode · $judul",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ringkasan,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              size: 15,
              color: AppColors.textSecondaryLight,
            ),
          ],
        ),
      ),
    );
  }
}
