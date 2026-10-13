import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/pengaduan/presentation/controllers/pencarian_wilayah_controller.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/searchable_wheel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagianPemilihWilayah extends StatelessWidget {
  final String? selectedRegion;
  final ValueChanged<String> onRegionSelected;

  const BagianPemilihWilayah({
    super.key,
    required this.selectedRegion,
    required this.onRegionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Lokasi Laporan", style: Theme.of(context).textTheme.titleSmall),
        SizedBox(height: 10),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: TextFormField(
            readOnly: true,
            focusNode: FocusNode(),
            decoration: InputDecoration(
              labelText: selectedRegion ?? "Pilih Kabupaten/Kota",
              labelStyle: Theme.of(context).textTheme.labelSmall,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.dark.withAlpha(50),
                  width: 1.5,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: AppColors.dark.withAlpha(50),
                  width: 1.5,
                ),
              ),
            ),

            onTap: () async {
              final selected = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  final controller = Get.find<PencarianWilayahController>()
                    ..reset();

                  return _LembarCariWilayah(controller: controller);
                },
              );

              if (selected != null) {
                onRegionSelected(selected);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _LembarCariWilayah extends StatelessWidget {
  final PencarianWilayahController controller;

  const _LembarCariWilayah({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: 400,
        padding: EdgeInsets.only(right: 8, left: 8, top: 10, bottom: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.searchController,
              onChanged: controller.onQueryChanged,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.primary, width: 1),
                ),
                hintText: "Cari Provinsi/Kabupaten/Kecamatan/Kelurahan",
                hintStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.results.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppAssets.emptyState,
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(height: 10),
                          Text(
                            controller.searchController.text.trim().length <
                                    PencarianWilayahController.minChars
                                ? "Masukkan minimal 3 karakter pada kolom pencarian"
                                : "Data tidak ditemukan",
                            style: Theme.of(context).textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final count = controller.results.length;

                return Column(
                  children: [
                    Text(
                      "$count hasil ditemukan",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SearchableWheel(controller: controller, count: count),
                          IgnorePointer(
                            child: Container(
                              height: 56,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(14),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.primary.withAlpha(60),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 0.2, color: Colors.red),
                          right: BorderSide(width: 0.2, color: Colors.red),
                          bottom: BorderSide(width: 0.2, color: Colors.red),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withAlpha(40),
                          foregroundColor: Colors.red,
                          elevation: 0,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 0.2,
                            color: AppColors.primary,
                          ),
                          right: BorderSide(
                            width: 0.2,
                            color: AppColors.primary,
                          ),
                          bottom: BorderSide(
                            width: 0.2,
                            color: AppColors.primary,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          final location = controller.fullLocation;

                          if (location != null) {
                            Navigator.pop(context, location);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary.withAlpha(40),
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Pilih",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
