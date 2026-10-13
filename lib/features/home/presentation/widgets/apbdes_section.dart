import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/presentation/widgets/apbdes_pelaksanaan_card.dart';
import 'package:desa_digital/features/home/presentation/widgets/apbdes_pembelanjaan_card.dart';
import 'package:desa_digital/features/home/presentation/widgets/apbdes_pendapatan_card.dart';
import 'package:flutter/material.dart';

class ApbdesSection extends StatelessWidget {
  const ApbdesSection({super.key, required this.summary});

  final ApbdesSummary summary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ApbdesPelaksanaanCard(section: summary.pelaksanaan),
          const SizedBox(height: 16),
          ApbdesPendapatanCard(section: summary.pendapatan),
          const SizedBox(height: 16),
          ApbdesPembelanjaanCard(section: summary.pembelanjaan),
        ],
      ),
    );
  }
}
