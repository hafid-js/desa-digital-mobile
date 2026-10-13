class OpsiLapak {
  const OpsiLapak({
    required this.kategoriFilter,
    required this.kategoriProduk,
    required this.lokasi,
    required this.kondisiProduk,
    required this.penawaran,
    required this.terakhirDitambahkan,
    required this.ketersediaan,
  });

  final List<String> kategoriFilter;
  final List<String> kategoriProduk;
  final List<String> lokasi;
  final List<String> kondisiProduk;
  final List<String> penawaran;
  final List<String> terakhirDitambahkan;
  final List<String> ketersediaan;
}
