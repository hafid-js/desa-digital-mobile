import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';
import 'package:flutter/material.dart';

class KonfirmasiPemohon extends StatelessWidget {
  const KonfirmasiPemohon({super.key, required this.penduduk});

  final Penduduk penduduk;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _baris(
            context,
            'NIK',
            penduduk.nik,
            Icon(Icons.badge_outlined, size: 14),
          ),
          const SizedBox(height: 12),
          _baris(
            context,
            'Nama',
            penduduk.nama,
            Icon(Icons.person_outline, size: 14),
          ),
          const SizedBox(height: 12),
          _baris(
            context,
            'Tempat / Tanggal Lahir / Umur',
            '${penduduk.tempatLahir} / ${penduduk.tanggalLahirTerbaca} / ${penduduk.labelUmur}',
            Icon(Icons.cake_outlined, size: 14),
          ),
          const SizedBox(height: 12),
          _baris(
            context,
            'Alamat',
            penduduk.alamat,
            Icon(Icons.home_outlined, size: 14),
          ),
          const SizedBox(height: 12),
          _baris(
            context,
            'Pendidikan / Warga Negara / Agama',
            '${penduduk.pendidikan} / ${penduduk.wargaNegara} / ${penduduk.agama}',
            Icon(Icons.school_outlined, size: 14),
          ),
          const SizedBox(height: 12),
          _baris(
            context,
            'Pekerjaan / Status Kawin',
            '${penduduk.pekerjaan} / ${penduduk.statusPerkawinan}',
            Icon(Icons.work_outline, size: 14),
          ),
          const SizedBox(height: 12),
          _baris(
            context,
            'Nomor KK',
            '${penduduk.noKk} (Kepala KK: ${penduduk.kepalaKk}, ${penduduk.hubungan})',
            Icon(Icons.groups_outlined, size: 14),
          ),
        ],
      ),
    );
  }

  Widget _baris(
    BuildContext context,
    String label,
    String value,
    Widget icon,
  ) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: const EdgeInsets.only(top: 2), child: icon),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black45),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
