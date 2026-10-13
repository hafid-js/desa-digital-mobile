import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/pengaduan.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:get/get.dart';

class DaftarPengaduanScreen extends StatelessWidget {
  const DaftarPengaduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Aduan Masyarakat",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: daftarPengaduan.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 6,
              left: 6,
              top: 6,
              bottom: 0,
            ),
            child: GestureDetector(
              onTap: () => Get.toNamed(
                Routes.detailPengaduan,
                arguments: daftarPengaduan[index],
              ),
              child: Container(
                padding: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    left: BorderSide(width: 0.2, color: AppColors.primary),
                    right: BorderSide(width: 0.2, color: AppColors.primary),
                    bottom: BorderSide(width: 0.2, color: AppColors.primary),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        AppAssets.complaintThumbnail,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            daftarPengaduan[index].kode,
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            daftarPengaduan[index].ringkasan,
                            style: Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: Colors.black),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "• ",
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(fontSize: 12),
                                ),
                                TextSpan(
                                  text: daftarPengaduan[index].waktu,
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(fontSize: 11),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(40),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  daftarPengaduan[index].status,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.bookmark_border_outlined,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

const List<Pengaduan> daftarPengaduan = [
  Pengaduan(
    kode: "LGWS67947799",
    ringkasan:
        "Judul : Gapura PRPP | Lokasi : Gapura PRPP Puri Anjasmoro | Deskripsi Laporan : Gapura PRPP yg lampu merah, mohon di perhatikan",
    waktu: "Sukoharjo, 6 jam yang lalu",
    status: "Disposisi",
    deskripsi:
        "Gapura PRPP yang lampunya warna merah, mohon diperhatikan. Sudah lapor ke kepala desa tapi lampu belum diperbaiki.",
    kategori: "INFRASTRUKTUR",
    lokasi: "KABUPATEN PURWOREJO",
  ),
  Pengaduan(
    kode: "LGIG21192729",
    ringkasan:
        "Judul : Izin lapor | Lokasi : Depan PT Konimex | Deskripsi Laporan : Kanal sampai menyentuh ke jalan, tolong diperbaiki",
    waktu: "Sukoharjo, 1 hari yang lalu",
    status: "Diproses",
    deskripsi:
        "Izin lapor depan PT Konimex Sukoharjo, kanal sampai menyentuh ke jalan. Tolong diperbaiki, sudah lapor lewat IG pemerintah Sukoharjo tetapi tidak ditindaklanjuti.",
    kategori: "INFRASTRUKTUR",
    lokasi: "KABUPATEN SUKOHARJO",
  ),
  Pengaduan(
    kode: "LGWS51203847",
    ringkasan:
        "Judul : Sampah menumpuk | Lokasi : Depan Pasar Desa | Deskripsi Laporan : Bak sampah penuh dan tidak ada angkut",
    waktu: "Karanganyar, 2 hari yang lalu",
    status: "Disposisi",
    deskripsi:
        "Bak sampah di depan pasar desa sudah penuh sejak kemarin dan aromanya mengganggu warga sekitar.",
    kategori: "KEBERSIHAN",
    lokasi: "KABUPATEN KARANGANYAR",
  ),
  Pengaduan(
    kode: "LGWS39014522",
    ringkasan:
        "Judul : Jalan berlubang | Lokasi : Gang RT 03 | Deskripsi Laporan : Lubang cukup dalam dan berbahaya",
    waktu: "Karanganyar, 3 hari yang lalu",
    status: "Menunggu",
    deskripsi:
        "Jalan di gang RT 03 berlubang sedalam 30 cm. Sudah diberi tanda penghalang namun belum diperbaiki.",
    kategori: "INFRASTRUKTUR",
    lokasi: "KABUPATEN KARANGANYAR",
  ),
  Pengaduan(
    kode: "LGIG77120983",
    ringkasan:
        "Judul : Lampu jalan mati | Lokasi : Jalan BK 02 | Deskripsi Laporan : Tiga lampu mati sejak malam",
    waktu: "Gunung Condong, 4 hari yang lalu",
    status: "Diproses",
    deskripsi:
        "Tiga titik lampu jalan mati di Jalan BK 02 sehingga malam menjadi gelap dan tidak aman untuk warga.",
    kategori: "INFRASTRUKTUR",
    lokasi: "KABUPATEN SEMARANG",
  ),
  Pengaduan(
    kode: "LGWS24810673",
    ringkasan:
        "Judul : Air tidak mengalir | Lokasi : Masjid Al Hikmah | Deskripsi Laporan : Sumur tidak keluar air sejak seminggu",
    waktu: "Gunung Condong, 5 hari yang lalu",
    status: "Disposisi",
    deskripsi:
        "Sumur di dekat Masjid Al Hikmah tidak keluar air sejak seminggu lalu sehingga kegiatan wudu terganggu.",
    kategori: "SANITASI",
    lokasi: "KABUPATEN SEMARANG",
  ),
  Pengaduan(
    kode: "LGWS66302714",
    ringkasan:
        "Judul : Pohon tumbang | Lokasi : Depan SD Negeri 2 | Deskripsi Laporan : Pohon besar tumbang menutup jalan",
    waktu: "Ngopeni, 6 hari yang lalu",
    status: "Selesai",
    deskripsi:
        "Pohon besar tumbang menutup jalan di depan SD Negeri 2. Sudah dipangkas dan jalannya sudah kembali bisa dilalui.",
    kategori: "KEBERHATIAN",
    lokasi: "KABUPATEN SEMARANG",
  ),
  Pengaduan(
    kode: "LGIG91557460",
    ringkasan:
        "Judul : Air keruh | Lokasi : Cluster RT 07 | Deskripsi Laporan : Air yang keluar keruh dan berbau",
    waktu: "Nglakoni, 1 minggu yang lalu",
    status: "Menunggu",
    deskripsi:
        "Air yang keluar di cluster RT 07 keruh dan berbau sejak tiga hari lalu. Warna air seperti keruh kuning kecoklatan.",
    kategori: "SANITASI",
    lokasi: "KABUPATEN SEMARANG",
  ),
];
