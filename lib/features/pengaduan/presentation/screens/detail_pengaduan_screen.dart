import 'package:carousel_slider/carousel_slider.dart';
import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/langkah_progres_pengaduan.dart';
import 'package:desa_digital/core/utils/color_utils.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailPengaduanScreen extends StatefulWidget {
  const DetailPengaduanScreen({super.key});

  static const Pengaduan _cadangan = Pengaduan(
    kode: "LGIG21192729",
    ringkasan:
        "Judul : Izin lapor | Lokasi : Depan PT Konimex | Deskripsi Laporan : Kanal sampai menyentuh ke jalan",
    waktu: "Sukoharjo, 1 hari yang lalu",
    status: "Disposisi",
    deskripsi:
        "Izin lapor depan PT Konimex Sukoharjo kanel sampai menyentuh ke jalan tolong di perbaiki dong. udah lapor via ig pemerintah sukoharjo ga di tindak lanjutin",
    kategori: "INFRASTRUKTUR",
    lokasi: "KABUPATEN PURWOREJO",
  );

  Pengaduan get pengaduan {
    final argumen = Get.arguments;
    if (argumen is Pengaduan) return argumen;
    return _cadangan;
  }

  @override
  State<DetailPengaduanScreen> createState() => _DetailPengaduanScreenState();
}

class _DetailPengaduanScreenState extends State<DetailPengaduanScreen> {
  int _currentIndex = 0;

  final List<String> sliderItems = [
    AppAssets.article3,
    AppAssets.article3,
    AppAssets.article3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Detail Aduan",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 280,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: sliderItems
                        .map(
                          (imagePath) => Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 230,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),

                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: sliderItems.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 14,
                          dotWidth: 20,
                          activeDotColor: HexColor.fromHex("#ff6900"),
                          dotColor: Colors.white.withAlpha(6),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.pengaduan.kode,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          "21 Sep 2026 06:01",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12),

            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 12,
                  right: 12,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.quartenary.withAlpha(40),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Selesai",
                            style: TextStyle(
                              color: AppColors.quartenary,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.bookmark, size: 30, color: Colors.grey),
                      ],
                    ),

                    SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Laporan",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.pengaduan.deskripsi,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: Colors.black87),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Kategori",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.pengaduan.kategori,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Lokasi",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.pengaduan.lokasi,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 14,
                  bottom: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),

                    SizedBox(height: 10),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LangkahProgresPengaduan(
                              status: "Disposisi",
                              admin: "ADMIN KELURAHAN",
                              date: "21 Sep 2026 06:11",
                              description:
                                  "Aduan telah diterima dan diteruskan kepada instansi terkait untuk ditindaklanjuti.",
                            ),

                            const SizedBox(height: 12),

                            LangkahProgresPengaduan(
                              status: "Verifikasi",
                              admin: "ADMIN KELURAHAN",
                              date: "21 Sep 2026 08:24",
                              description:
                                  "Aduan sedang diverifikasi oleh petugas untuk memastikan informasi dan lokasi yang dilaporkan.",
                            ),

                            const SizedBox(height: 12),

                            LangkahProgresPengaduan(
                              status: "Progress",
                              admin: "ADMIN KELURAHAN",
                              date: "21 Sep 2026 10:15",
                              description:
                                  "Aduan telah diterima oleh instansi terkait dan sedang dalam proses penanganan.",
                            ),

                            const SizedBox(height: 12),

                            LangkahProgresPengaduan(
                              status: "Selesai",
                              admin: "ADMIN KELURAHAN",
                              date: "22 Sep 2026 15:30",
                              description:
                                  "Aduan telah ditindaklanjuti dan penanganan atas laporan telah selesai dilakukan.",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
