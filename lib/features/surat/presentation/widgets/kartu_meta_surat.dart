import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:flutter/material.dart';

class KartuMetaSurat extends StatelessWidget {
  const KartuMetaSurat({super.key, required this.type}) : data = null;

  const KartuMetaSurat.mandiri({super.key, required SuratMandiri surat})
    : data = surat,
      type = null;

  final JenisSurat? type;
  final SuratMandiri? data;

  String get _kode => type != null ? type!.code : data!.code;

  String? get _lampiran => type != null ? type!.lampiran : data!.lampiran;

  String get _labelMasaBerlaku =>
      type != null ? type!.labelMasaBerlaku : data!.labelMasaBerlaku;

  bool get _mandiri => type != null ? type!.mandiri : true;

  @override
  Widget build(BuildContext context) {
    final labelLampiran = _lampiran == null ? null : 'Lampiran $_lampiran';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _chip('Kode $_kode'),
              if (labelLampiran != null) ...[
                const SizedBox(width: 8),
                _chip(labelLampiran),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: Colors.black45),
              const SizedBox(width: 4),
              Text(
                _labelMasaBerlaku,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _mandiri ? Icons.bolt : Icons.groups,
                size: 14,
                color: Colors.black45,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _mandiri
                      ? 'Surat ini bisa warga buat sendiri tanpa diproses perangkat desa'
                      : 'Surat ini diverifikasi petugas desa sebelum diterbitkan',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 10, color: Colors.white),
    ),
  );
}
