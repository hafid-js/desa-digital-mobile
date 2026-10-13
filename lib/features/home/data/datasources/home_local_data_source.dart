import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/domain/entities/home_menu_item.dart';

abstract interface class HomeDataSource {
  List<HomeMenuItem> menuItems();

  List<ContentItem> agendaHariIni();

  List<ContentItem> artikelTerbaru();

  ApbdesSummary apbdes();
}

class HomeLocalDataSource implements HomeDataSource {
  const HomeLocalDataSource();

  @override
  List<HomeMenuItem> menuItems() => List.unmodifiable(_menuItems);

  @override
  List<ContentItem> agendaHariIni() => List.unmodifiable(_agenda);

  @override
  List<ContentItem> artikelTerbaru() => List.unmodifiable(_artikel);

  @override
  ApbdesSummary apbdes() => _apbdes;
}

final List<HomeMenuItem> _menuItems = [
  HomeMenuItem(
    title: 'Aduan',
    icon: AppAssets.menuComplaint,
    route: Routes.pengaduan,
  ),

  HomeMenuItem(title: 'Acara', icon: AppAssets.menuEvent, route: Routes.agenda),
  HomeMenuItem(
    title: 'Layanan Mandiri',
    icon: AppAssets.menuLetterRequest,
    route: Routes.permohonanSurat,
  ),
  HomeMenuItem(
    title: 'Lapak Warga',
    icon: AppAssets.menuBursaKerja,
    route: Routes.lapakWarga,
  ),

  // HomeMenuItem(
  //   title: 'Peraturan Desa',
  //   icon: AppAssets.menuVillageRegulation,
  //   route: Routes.peraturanDesa,
  // ),
];

final List<ContentItem> _agenda = [
  ContentItem(
    image: AppAssets.event5,
    title: "Jalan Sehat Dan Baksos Karang Taruna Desa Gunung Condong",
    date: "23-24 Februari 2026",
  ),
  ContentItem(
    image: AppAssets.event4,
    title: "Penyaluran Bantuan Perhutani Untuk Keluarga Miskin",
    date: "13 Februari - 1 Maret 2026",
  ),
  ContentItem(
    image: AppAssets.event3,
    title: "Penyaluran Bantuan Perhutani Untuk Keluarga Miskin",
    date: "13 Februari - 1 Maret 2026",
  ),
  ContentItem(
    image: AppAssets.event2,
    title: "Penyaluran Bantuan Perhutani Untuk Keluarga Miskin",
    date: "13 Februari - 1 Maret 2026",
  ),
  ContentItem(
    image: AppAssets.event1,
    title: "Penyaluran Bantuan Perhutani Untuk Keluarga Miskin",
    date: "13 Februari - 1 Maret 2026",
  ),
];

final List<ContentItem> _artikel = [
  ContentItem(
    image: AppAssets.article9,
    title:
        "Sikapi Dampak Opsen dari Pemerintah Pusat, Pemprov Jateng Berlakukan Pengurangan Pajak Kendaraan Bermotor",
    date: "24 Februari 2026",
  ),
  ContentItem(
    image: AppAssets.article2,
    title: "Sosialisasi Kekosongan Perangkat Desa Plipiran",
    date: "19 Februari 2026",
  ),
  ContentItem(
    image: AppAssets.article3,
    title: "Peningkatan Kapasitas Perangkat Desa Se- Kecamatan Bruno",
    date: "17 Februari 2026",
  ),
];

const ApbdesTotal _totalPendapatan = ApbdesTotal(
  realAmount: 369305706,
  targetAmount: 1125947389,
);

final ApbdesSection _pelaksanaan = ApbdesSection(
  title: "APBDes 2026 Pelaksanaan",
  items: [
    ApbdesItem(
      title: "Pendapatan",
      realAmount: "Rp 369.305.706,00",
      targetAmount: "Rp 1.125.947.389,00",
      progress: _totalPendapatan.progress,
      percentageText: _totalPendapatan.percentageText,
    ),
    const ApbdesItem(
      title: "Belanja",
      realAmount: "Rp 280.178.925,00",
      targetAmount: "Rp 1.099.315.413,00",
      progress: 0.2,
      percentageText: "25.49%",
    ),
  ],
);

const ApbdesSection _pendapatan = ApbdesSection(
  title: "APBDes 2026 Pendapatan",
  items: [
    ApbdesItem(
      title: "Hasil Usaha Desa",
      realAmount: "Rp 0,00",
      targetAmount: "Rp 24.000.000,00",
      progress: 0.01,
      percentageText: "0%",
    ),
    ApbdesItem(
      title: "Hasil Aset Desa",
      realAmount: "Rp 0,00",
      targetAmount: "Rp 16.000.000,00",
      progress: 0.01,
      percentageText: "0%",
    ),
    ApbdesItem(
      title: "Dana Desa",
      realAmount: "Rp 149.382.400,00",
      targetAmount: "Rp 373.456.000,00",
      progress: 0.4,
      percentageText: "40.2%",
    ),
    ApbdesItem(
      title: "Bagi Hasil Pajak Dan Retribusi",
      realAmount: "Rp 0,00",
      targetAmount: "Rp 41.217.700,00",
      progress: 0.01,
      percentageText: "0%",
    ),
    ApbdesItem(
      title: "Alokasi Dana Desa",
      realAmount: "Rp 174.647.992,00",
      targetAmount: "Rp 434.491.400,00",
      progress: 0.4,
      percentageText: "40%",
    ),
    ApbdesItem(
      title: "Bagi Hasil Pajak Dan Retribusi",
      realAmount: "Rp 0,00",
      targetAmount: "Rp 41.217.700,00",
      progress: 0.01,
      percentageText: "0%",
    ),
    ApbdesItem(
      title: "Dana Desa",
      realAmount: "Rp 149.382.400,00",
      targetAmount: "Rp 373.456.000,00",
      progress: 0.4,
      percentageText: "40.2%",
    ),
    ApbdesItem(
      title: "Bantuan Keuangan Provinsi",
      realAmount: "Rp 0,00",
      targetAmount: "Rp 100.000.000,00",
      progress: 0.01,
      percentageText: "0%",
    ),
    ApbdesItem(
      title: "Bunga Bank",
      realAmount: "Rp 90.994,00",
      targetAmount: "Rp 1.180.417,00",
      progress: 0.07,
      percentageText: "7.71%",
    ),
  ],
);

const ApbdesSection _pembelanjaan = ApbdesSection(
  title: "APBDes 2026 Pembelanjaan",
  items: [
    ApbdesItem(
      title: "Bidang Penyelenggaraan Pemerintahan",
      realAmount: "Rp 173.323.325,00",
      targetAmount: "Rp 642.272.557,00",
      progress: 0.26,
      percentageText: "26.83%",
    ),
    ApbdesItem(
      title: "Bidang Pelaksanaan Pembangunan Desa",
      realAmount: "Rp 63.372.100,00",
      targetAmount: "Rp 369.859.500,00",
      progress: 0.17,
      percentageText: "17.13%",
    ),
    ApbdesItem(
      title: "Bidang Pembinaan Kemasyarakatan Desa",
      realAmount: "Rp 0,00",
      targetAmount: "Rp 26.449.856.00,00",
      progress: 0.01,
      percentageText: "0%",
    ),
    ApbdesItem(
      title: "Bidang Pemberdayaa Masyarakat Desa",
      realAmount: "Rp 39.083.500,00",
      targetAmount: "Rp 39.083.500,00",
      progress: 1,
      percentageText: "100%",
      labelAlignment: ApbdesLabelAlignment.center,
    ),
    ApbdesItem(
      title: "Bidang Penanggulangan Bencana, Darurat Dan Mendesak Desa",
      realAmount: "Rp 5.400.000,00",
      targetAmount: "Rp 21.600.000,00",
      progress: 0.25,
      percentageText: "25%",
    ),
  ],
);

final ApbdesSummary _apbdes = ApbdesSummary(
  pelaksanaan: _pelaksanaan,
  pendapatan: _pendapatan,
  pembelanjaan: _pembelanjaan,
);
