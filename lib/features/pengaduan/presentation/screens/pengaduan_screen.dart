import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/bordered_card.dart';
import 'package:desa_digital/core/widgets/section_heading.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/panduan_pengaduan.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/baris_pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:get/get.dart';

class PengaduanScreen extends StatefulWidget {
  const PengaduanScreen({super.key});

  @override
  State<PengaduanScreen> createState() => _PengaduanScreenState();
}

class _PengaduanScreenState extends State<PengaduanScreen> {
  bool _agreeChecked = false;

  void _showGuideSheet() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.64,
              minChildSize: 0.3,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return PanduanPengaduan(
                  agreeChecked: _agreeChecked,
                  onAgreeChanged: (v) => setModalState(() => _agreeChecked = v),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aduan Masyarakat",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Sampaikan aduan seputar layanan atau fasilitas umum di Desa",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const AppSectionHeading(title: "Lapor Aduan"),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      BorderedCard(
                        child: BarisInfo(
                          image: AssetImage(AppAssets.iconKamera),
                          iconSize: 40,
                          title: "Aduan Umum",
                          description:
                              "Laporkan permasalahan umum seperti infrastruktur, "
                              "layanan publik, dll",
                          onTap: _showGuideSheet,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const _CallCenterCard(),
                    ],
                  ),
                ),
                const AppSectionHeading(title: "Jelajahi Aduan"),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.daftarPengaduan),
                        child: BorderedCard(
                          child: BarisMenu(
                            image: AssetImage(AppAssets.iconSearchAttachment),
                            title: "Lihat Aduan Masyarakat",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.aktivitas),
                        child: BorderedCard(
                          child: BarisMenu(
                            image: AssetImage(AppAssets.iconList),
                            title: "Laporan Saya",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CallCenterCard extends StatelessWidget {
  const _CallCenterCard();

  @override
  Widget build(BuildContext context) {
    return BorderedCard(
      child: Column(
        children: [
          BarisInfo(
            image: AssetImage(AppAssets.iconTelepon2),
            title: "Call Center JNN Gratis",
            description: "Telepon bebas pulsa ke CS Desa Ngopeni Nglakoni",
          ),
          const SizedBox(height: 10),
          Divider(height: 10, color: AppColors.primary, thickness: 0.15),
          const SizedBox(height: 10),
          BarisInfo(
            image: AssetImage(AppAssets.iconTelepon3),
            title: "Call Center 150945",
            description:
                "Telepon call center berbayar ke CS Jateng Ngpeni Nglakoni",
          ),
        ],
      ),
    );
  }
}
