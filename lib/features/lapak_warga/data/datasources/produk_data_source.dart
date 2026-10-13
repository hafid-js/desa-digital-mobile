import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';

class ProdukDataSource {
  const ProdukDataSource();

  static const int jumlahContoh = 8;

  List<ProdukLapak> loadProduk() =>
      List<ProdukLapak>.generate(jumlahContoh, (_) => _produkContoh);

  static const ProdukLapak _produkContoh = ProdukLapak(
    title: "Columbia Women's Castback TC PFG Shoes",
    price: "31.800",
    originalPrice: "150.000",
    discount: "-55%",
    seller: "Etan Hooper",
    location: "Dusun Karangsari",
    image: "assets/images/lapak_warga/produk-example-1.png",
    userAvatar: "assets/images/lapak_warga/user_example2.png",
    description:
        "Sepatu berkualitas hasil karya warga lokal desa. Nyaman dipakai untuk aktivitas sehari-hari, awet, dan tahan lama.",
  );
}
