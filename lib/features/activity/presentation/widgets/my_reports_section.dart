import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/label_pill.dart';
import 'package:desa_digital/core/widgets/tab_section.dart';
import 'package:desa_digital/features/activity/domain/entities/activity_item.dart';
import 'package:desa_digital/features/activity/presentation/controllers/activity_controller.dart';
import 'package:desa_digital/features/activity/presentation/widgets/activity_item_card.dart';
import 'package:desa_digital/features/activity/presentation/widgets/activity_list.dart';
import 'package:desa_digital/features/activity/presentation/widgets/activity_meta.dart';
import 'package:flutter/material.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/pengaduan.dart';
import 'package:get/get.dart';

class MyReportsSection extends StatelessWidget {
  const MyReportsSection({super.key});

  ActivityController get _controller => Get.find<ActivityController>();

  void _openDetail(ActivityItem item) => Get.toNamed(
    Routes.detailPengaduan,
    arguments: Pengaduan(
      kode: item.isReportCode ? item.title : 'ADUAN MASYARAKAT',
      ringkasan: item.title,
      waktu: item.meta,
      status: 'Menunggu',
      deskripsi: item.title,
      kategori: 'LAINNYA',
      lokasi: 'KABUPATEN SEMARANG',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TabSection(
      labels: const ["Proses", "Selesai"],
      tabs: [
        ActivityList(
          items: _controller.laporanProses,
          itemBuilder: (item) => ActivityItemCard(
            item: item,
            cardPadding: activityReportCardPadding,
            meta: BulletMeta(text: item.meta),
            footer: _pillRow(
              LabelPill(
                label: "Progress",
                color: AppColors.secondary,
                backgroundColor: AppColors.secondary.withAlpha(40),
              ),
            ),
            onTap: () => _openDetail(item),
          ),
        ),
        ActivityList(
          items: _controller.laporanSelesai,
          itemBuilder: (item) => ActivityItemCard(
            item: item,
            meta: DateMeta(text: item.meta),
            footer: _pillRow(
              LabelPill(
                label: "Selesai",
                color: AppColors.quartenary,
                backgroundColor: AppColors.quartenary.withAlpha(40),
              ),
            ),
            onTap: () => _openDetail(item),
          ),
        ),
      ],
      barPadding: const EdgeInsets.all(12),
    );
  }

  Widget _pillRow(Widget statusPill) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        statusPill,
        const SizedBox(width: 5),
        const LabelPill(
          label: "Publik",
          color: AppColors.textPrimaryLight,
          backgroundColor: Color(0x1E000000),
          icon: Icons.lock_open_rounded,
        ),
      ],
    );
  }
}
