import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';

abstract interface class VillageRegulationDataSource {
  List<VillageRegulation> regulations();
}

class VillageRegulationLocalDataSource implements VillageRegulationDataSource {
  const VillageRegulationLocalDataSource();

  @override
  List<VillageRegulation> regulations() => List.unmodifiable(_regulations);
}

const String _judul =
    "PERATURAN DESA GUNUNGCONDONG NOMOR 8 TAHUN 2021 TENTANG LEMBAGA KEMASYARAKATAN DESA";

const String _kategori = "Peraturan Desa Gunung Condong";

final List<VillageRegulation> _regulations = List.generate(
  8,
  (index) => VillageRegulation(
    id: 'peraturan-${index + 1}',
    title: _judul,
    description: _judul,
    date: "03 Januari 2025",
    author: "Admin",
    category: _kategori,
    thumbnailAsset: AppAssets.complaintThumbnail,
    pdfAsset: AppAssets.villageRegulationLkdCepedak2021,
  ),
);
