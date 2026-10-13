import 'package:desa_digital/features/lapak_warga/domain/entities/opsi_lapak.dart';

class OpsiLapakDataSource {
  const OpsiLapakDataSource();

  OpsiLapak loadOpsi() => const OpsiLapak(
    kategoriFilter: opsiKategoriFilter,
    kategoriProduk: opsiKategoriProduk,
    lokasi: opsiLokasi,
    kondisiProduk: opsiKondisiProduk,
    penawaran: opsiPenawaran,
    terakhirDitambahkan: opsiTerakhirDitambahkan,
    ketersediaan: opsiKetersediaan,
  );
}

const List<String> opsiKategoriFilter = [
  'Fashion & Pakaian',
  'Kuliner & Olahan',
  'Elektronik & Gadget',
  'Hasil Bumi & Pertanian',
  'Perlengkapan Rumah',
  'Otomotif',
  'Kerajinan & Souvenir',
];

const List<String> opsiKategoriProduk = [
  'Fashion & Pakaian',
  'Kuliner & Olahan',
  'Elektronik & Gadget',
  'Hasil Bumi & Pertanian',
  'Perlengkapan Rumah',
  'Otomotif',
  'Kerajinan & Souvernir',
];

const List<String> opsiLokasi = [
  'Dusun Krajan',
  'Dusun Kepudang',
  'Dusun Karangsari',
  'Dusun Kemplung',
  'Dusun Brembet',
];

const List<String> opsiKondisiProduk = [
  'Baru',
  'Bekas - Seperti Baru',
  'Bekas - Bagus',
  'Bekas - Cukup',
];

const List<String> opsiPenawaran = ['COD', 'Harga Diskon'];

const List<String> opsiTerakhirDitambahkan = [
  '7 hari',
  '14 hari',
  '1 bulan',
  '3 bulan',
];

const List<String> opsiKetersediaan = ['Stok Tersedia', 'Preorder'];
