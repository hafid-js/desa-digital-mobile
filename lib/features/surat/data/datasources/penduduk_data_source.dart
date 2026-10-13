import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';

class PendudukDataSource {
  const PendudukDataSource();

  static final List<Penduduk> daftar = <Penduduk>[
    Penduduk(
      id: '1',
      nik: '3306132208990002',
      nama: 'Siti Aminah',
      jenisKelamin: 'Perempuan',
      tempatLahir: 'Banyumas',
      tanggalLahir: DateTime(1999, 8, 22),
      agama: 'Islam',
      pekerjaan: 'Ibu Rumah Tangga',
      pendidikan: 'SMP',
      statusPerkawinan: 'Kawin',
      wargaNegara: 'WNI',
      alamat: 'Dusun I RT 02 RW 05, Desa Sukamaju, Kec. Ajbar, Kab. Banyumas',
      noKk: '3306132208990001',
      kepalaKk: 'Ahmad Hidayat',
      hubungan: 'Kepala Keluarga',
    ),
    Penduduk(
      id: '2',
      nik: '3306131007950003',
      nama: 'Ahmad Hidayat',
      jenisKelamin: 'Laki-laki',
      tempatLahir: 'Cilacap',
      tanggalLahir: DateTime(1995, 7, 10),
      agama: 'Islam',
      pekerjaan: 'Wiraswasta',
      pendidikan: 'SMA',
      statusPerkawinan: 'Kawin',
      wargaNegara: 'WNI',
      alamat: 'Dusun I RT 02 RW 05, Desa Sukamaju, Kec. Ajbar, Kab. Banyumas',
      noKk: '3306132208990001',
      kepalaKk: 'Ahmad Hidayat',
      hubungan: 'Kepala Keluarga',
    ),
    Penduduk(
      id: '3',
      nik: '3306131201200004',
      nama: 'Budi Hidayat',
      jenisKelamin: 'Laki-laki',
      tempatLahir: 'Banyumas',
      tanggalLahir: DateTime(2020, 1, 12),
      agama: 'Islam',
      pekerjaan: 'Pelajar',
      pendidikan: 'Belum Tamat SD',
      statusPerkawinan: 'Belum Kawin',
      wargaNegara: 'WNI',
      alamat: 'Dusun I RT 02 RW 05, Desa Sukamaju, Kec. Ajbar, Kab. Banyumas',
      noKk: '3306132208990001',
      kepalaKk: 'Ahmad Hidayat',
      hubungan: 'Anak',
    ),
    Penduduk(
      id: '4',
      nik: '3306132503150005',
      nama: 'Rina Hidayat',
      jenisKelamin: 'Perempuan',
      tempatLahir: 'Purbalingga',
      tanggalLahir: DateTime(2015, 3, 25),
      agama: 'Islam',
      pekerjaan: 'Pelajar',
      pendidikan: 'Belum Tamat SD',
      statusPerkawinan: 'Belum Kawin',
      wargaNegara: 'WNI',
      alamat: 'Dusun I RT 02 RW 05, Desa Sukamaju, Kec. Ajbar, Kab. Banyumas',
      noKk: '3306132208990001',
      kepalaKk: 'Ahmad Hidayat',
      hubungan: 'Anak',
    ),
    Penduduk(
      id: '5',
      nik: '3273091805650001',
      nama: 'Ratma Sari',
      jenisKelamin: 'Perempuan',
      tempatLahir: 'Bandung',
      tanggalLahir: DateTime(1965, 5, 18),
      agama: 'Kristen',
      pekerjaan: 'Pensiunan',
      pendidikan: 'S1',
      statusPerkawinan: 'Cerai Hidup',
      wargaNegara: 'WNI',
      alamat: 'Dusun II RT 01 RW 03, Desa Sukamaju, Kec. Ajbar, Kab. Banyumas',
      noKk: '3273091805650001',
      kepalaKk: 'Ratma Sari',
      hubungan: 'Kepala Keluarga',
    ),
    Penduduk(
      id: '6',
      nik: '3306130408700002',
      nama: 'Dedi Susanto',
      jenisKelamin: 'Laki-laki',
      tempatLahir: 'Banyumas',
      tanggalLahir: DateTime(1987, 8, 4),
      agama: 'Islam',
      pekerjaan: 'Petani',
      pendidikan: 'SMP',
      statusPerkawinan: 'Kawin',
      wargaNegara: 'WNI',
      alamat: 'Dusun II RT 01 RW 03, Desa Sukamaju, Kec. Ajbar, Kab. Banyumas',
      noKk: '3273091805650001',
      kepalaKk: 'Ratma Sari',
      hubungan: 'Suami',
    ),
  ];

  List<Penduduk> semua() => daftar;

  List<Penduduk> cari(String kataKunci) {
    final kunci = kataKunci.trim().toLowerCase();
    if (kunci.isEmpty) return daftar;
    return daftar
        .where(
          (item) =>
              item.nik.contains(kunci) ||
              item.nama.toLowerCase().contains(kunci),
        )
        .toList();
  }
}
