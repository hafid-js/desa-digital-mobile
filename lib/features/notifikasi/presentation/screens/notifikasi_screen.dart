import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_preference.dart';
import 'package:desa_digital/features/notifikasi/presentation/controllers/notification_controller.dart';
import 'package:desa_digital/features/notifikasi/presentation/widgets/tile_daftar_notifikasi.dart';
import 'package:desa_digital/features/notifikasi/presentation/widgets/tile_notifikasi.dart';
import 'package:desa_digital/features/notifikasi/presentation/widgets/tampilan_kosong_notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

const List<({String label, NotificationCategory category})> _tabs = [
  (label: "Semua", category: NotificationCategory.semua),
  (label: "Aduan", category: NotificationCategory.aduan),
  (label: "Event", category: NotificationCategory.event),
  (label: "Berita", category: NotificationCategory.berita),
];

const Map<NotificationPreferenceType, IconData> _ikonPreferensi = {
  NotificationPreferenceType.beritaTerkini: Iconsax.book,
  NotificationPreferenceType.peringatanCuaca: Iconsax.cloud_drizzle,
  NotificationPreferenceType.eventDesa: Iconsax.calendar_1,
};

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  NotificationController get _controller => Get.find<NotificationController>();

  void _bukaPengaturan(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pengaturan Notifikasi",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Text(
              "Pilih notifikasi yang kamu ingin terima",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            Obx(
              () => Column(
                children: [
                  for (final preferensi in _controller.preferences)
                    TileDaftarNotifikasi(
                      icon: _ikonPreferensi[preferensi.type]!,
                      title: preferensi.title,
                      subtitle: preferensi.subtitle,
                      value: preferensi.aktif,
                      onChanged: (v) =>
                          _controller.setPreferensi(preferensi.type, v),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text("Preferensi notifikasi disimpan"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Simpan",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter(BuildContext context, TabController tabController) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        final selectedIndex = tabController.index;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              for (var index = 0; index < _tabs.length; index++) ...[
                if (index > 0) const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => tabController.animateTo(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? AppColors.primary
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _tabs[index].label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDaftarNotifikasi(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Obx(() {
            final items = _controller.items;

            return Column(
              children: [
                for (var index = 0; index < items.length; index++) ...[
                  TileNotifikasi(
                    item: items[index],
                    terbaca: _controller.terbaca.value,
                    gayaIsi: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    gayaWaktu: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 11),
                    onTap: _controller.toggleTerbaca,
                  ),
                  if (index < items.length - 1)
                    Divider(
                      color: AppColors.grey.withAlpha(180),
                      thickness: 0.5,
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Notifikasi",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => _bukaPengaturan(context),
            child: Icon(Iconsax.setting_2, color: AppColors.primary),
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 12),
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);

            return Column(
              children: [
                _buildFilter(context, tabController),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildDaftarNotifikasi(context),
                      const TampilanKosongNotifikasi(),
                      const TampilanKosongNotifikasi(),
                      const TampilanKosongNotifikasi(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
