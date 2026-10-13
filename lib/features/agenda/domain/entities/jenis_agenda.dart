import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

enum JenisAgenda {
  rapat('Rapat / Musyawarah'),
  posyandu('Posyandu'),
  bansos('Bansos / Bantuan'),
  kerjaBakti('Kerja Bakti / Gotong Royong'),
  keagamaan('Keagamaan'),
  kesehatan('Kesehatan'),
  pelatihan('Pelatihan / Sosialisasi'),
  lomba('Lomba / Hiburan'),
  lainnya('Lainnya');

  const JenisAgenda(this.label);

  final String label;

  IconData get icon => switch (this) {
    JenisAgenda.rapat => Icons.groups,
    JenisAgenda.posyandu => Icons.child_friendly,
    JenisAgenda.bansos => Icons.volunteer_activism,
    JenisAgenda.kerjaBakti => Icons.handshake,
    JenisAgenda.keagamaan => Icons.mosque,
    JenisAgenda.kesehatan => Icons.medical_services,
    JenisAgenda.pelatihan => Icons.school,
    JenisAgenda.lomba => Icons.emoji_events,
    JenisAgenda.lainnya => Icons.event,
  };

  Color get color => switch (this) {
    JenisAgenda.rapat => AppColors.primary,
    JenisAgenda.posyandu => AppColors.tertiary,
    JenisAgenda.bansos => AppColors.secondary,
    JenisAgenda.kerjaBakti => AppColors.quartenary,
    JenisAgenda.keagamaan => AppColors.green,
    JenisAgenda.kesehatan => AppColors.blue,
    JenisAgenda.pelatihan => AppColors.info,
    JenisAgenda.lomba => AppColors.warning,
    JenisAgenda.lainnya => AppColors.grey,
  };
}
