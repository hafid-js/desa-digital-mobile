import 'package:desa_digital/core/widgets/pdf_viewer.dart';
import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';
import 'package:desa_digital/features/peraturan_desa/presentation/controllers/village_regulation_controller.dart';
import 'package:desa_digital/features/peraturan_desa/presentation/widgets/tile_peraturan_desa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeraturanDesaScreen extends StatelessWidget {
  const PeraturanDesaScreen({super.key});

  VillageRegulationController get _controller =>
      Get.find<VillageRegulationController>();

  void _bukaPdf(BuildContext context, VillageRegulation regulation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewer(pdfPath: regulation.pdfAsset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Peraturan Desa",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _controller.regulations.length,
          itemBuilder: (context, index) {
            final regulation = _controller.regulations[index];

            return TilePeraturanDesa(
              regulation: regulation,
              onTap: () => _bukaPdf(context, regulation),
            );
          },
        ),
      ),
    );
  }
}
