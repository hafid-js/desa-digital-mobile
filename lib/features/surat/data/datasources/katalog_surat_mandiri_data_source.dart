import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';

class KatalogSuratMandiriDataSource {
  const KatalogSuratMandiriDataSource();

  List<SuratMandiri> semua() => katalogSuratMandiri;

  List<SuratMandiri> mandiriSiap() =>
      katalogSuratMandiri.where((item) => item.sudahDiimplementasikan).toList();

  List<SuratMandiri> perluProses() => suratPerluProses;
}

const List<SuratMandiri> katalogSuratMandiri = [
  SuratMandiri(
    code: 'S-41',
    title: 'Keterangan Domisili',
    ringkasan: 'Surat yang menyebutkan alamat tempat tinggal resmi seseorang',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran sekolah anak',
        wajib: false,
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-01',
    title: 'Keterangan Pengantar',
    ringkasan: 'Surat pengantar dari desa untuk mendukung keperluan warga',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran sekolah anak',
      ),
      FieldSurat(
        label: 'Keterangan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Orang tua siswa yang meminta surat pengantar',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-02',
    title: 'Keterangan Penduduk',
    ringkasan: 'Surat keterangan yang memuat data lengkap seorang penduduk',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran sekolah anak',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-08',
    title: 'Keterangan KTP dalam Proses',
    ringkasan:
        'Surat keterangan bahwa kartu tanda penduduk sedang dalam proses pembuatan',
    lampiran: null,
    fields: [],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-10',
    title: 'Keterangan Bepergian',
    ringkasan:
        'Surat keterangan bagi penduduk yang sedang berada di luar wilayah desa',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran sekolah anak',
        wajib: false,
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-13',
    title: 'Pengantar Laporan Kehilangan',
    ringkasan:
        'Surat pengantar untuk laporan barang atau identitas yang hilang',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Nama Barang',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: KTP, SIM, Kartu Keluarga',
      ),
      FieldSurat(
        label: 'Rincian',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: 1 unit motor, 1 unit sepeda, 1 unit ponsel',
      ),
      FieldSurat(
        label: 'Keterangan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Dicuri di depan rumah pada 1 September 2025',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: '500',
    title: 'Keterangan Usaha',
    ringkasan: 'Surat keterangan bagi penduduk yang menjalankan usaha',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Nama Usaha',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: Toko Sembako',
      ),
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran izin usaha',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-11',
    title: 'Keterangan Kurang Mampu',
    ringkasan:
        'Surat keterangan bahwa seseorang termasuk golongan kurang mampu',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pengajuan bantuan sosial',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-16',
    title: 'Keterangan Domisili Usaha',
    ringkasan: 'Surat keterangan domisili untuk tempat usaha',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Nama Usaha',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: Toko Sembako',
        wajib: false,
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-30',
    title: 'Keterangan Pergi Kawin',
    ringkasan: 'Surat keterangan untuk keperluan pendaftaran perkawinan',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Tujuan',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: KUA di Kabupaten Semarang',
      ),
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran perkawinan',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-12',
    title: 'Pengantar Izin Keramaian',
    ringkasan:
        'Surat pengantar izin kegiatan yang dilaksanakan di wilayah desa',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Jenis Acara',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: Pesta pernikahan, hajatan, musyawarah desa',
      ),
      FieldSurat(
        label: 'Keperluan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persetujuan kegiatan desa',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-07',
    title: 'Pengantar Surat Keterangan Catatan Kepolisisan',
    ringkasan: 'Pengantar untuk pengajuan surat keterangan catatan resmi',
    lampiran: null,
    fields: [
      FieldSurat(
        label: 'Keterangan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Contoh: Persyaratan pendaftaran perusahaan',
      ),
    ],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-43',
    title: 'Pengantar Permohonan Penerbitan Buku Pas Lintas',
    ringkasan: 'Pengantar untuk pengajuan buku pas lintas wilayah',
    lampiran: null,
    fields: [],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: '471.1',
    title: 'Keterangan Beda Identitas',
    ringkasan: 'Surat keterangan perbedaan data karena ketidaksesuaian dokumen',
    lampiran: 'F-1.06',
    fields: [
      FieldSurat(
        label: 'Nama Kartu Identitas',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: Kartu Tanda Penduduk',
      ),
      FieldSurat(
        label: 'Nomor Identitas',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: 1234567890123456',
      ),
      FieldSurat(
        label: 'Perbedaan',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: Nama berbeda antara KTP dan Akta Lahir',
      ),
    ],
    fieldsIdentitasKedua: [
      FieldSurat(
        label: 'Nama',
        tipe: TipeFieldSurat.teks,
        hint: 'Nama pada kartu identitas yang berbeda',
      ),
      FieldSurat(
        label: 'Tempat Lahir',
        tipe: TipeFieldSurat.teks,
        hint: 'Contoh: Semarang',
      ),
      FieldSurat(
        label: 'Tanggal Lahir',
        tipe: TipeFieldSurat.tanggal,
        hint: '-',
      ),
      FieldSurat(
        label: 'Jenis Kelamin',
        tipe: TipeFieldSurat.opsi,
        hint: 'Pilih Jenis Kelamin',
        pilihan: ['Laki-laki', 'Perempuan'],
      ),
      FieldSurat(
        label: 'Agama',
        tipe: TipeFieldSurat.opsi,
        hint: 'Pilih Agama',
        pilihan: [
          'ISLAM',
          'KRISTEN',
          'KATHOLIK',
          'HINDU',
          'BUDHA',
          'KHONGHUCU',
        ],
      ),
      FieldSurat(
        label: 'Pekerjaan',
        tipe: TipeFieldSurat.opsi,
        hint: 'Pilih Pekerjaan',
        pilihan: [
          'BELUM/TIDAK BEKERJA',
          'MENGURUS RUMAH TANGGA',
          'PELAJAR/MAHASISWA',
          'PENSIUNAN',
          'WIRASWASTA',
          'PETANI/PEKEBUN',
          'KARYAWAN SWASTA',
        ],
      ),
      FieldSurat(
        label: 'Alamat',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Alamat lengkap tanpa nomor rumah',
      ),
      FieldSurat(
        label: 'Keterangan',
        tipe: TipeFieldSurat.teksArea,
        hint: 'Keterangan tambahan mengenai perbedaan identitas',
      ),
    ],
    sudahDiimplementasikan: true,
    butuhIdentitasKedua: true,
  ),
  SuratMandiri(
    code: 'S-03',
    title: 'Biodata Penduduk',
    ringkasan: 'Surat biodata lengkap penduduk sesuai data kependudukan',
    lampiran: 'F-1.01,F-1.02',
    fields: [],
    sudahDiimplementasikan: true,
  ),
];

List<SuratMandiri> get suratMandiriSiap =>
    katalogSuratMandiri.where((item) => item.sudahDiimplementasikan).toList();

const List<SuratMandiri> suratPerluProses = [
  SuratMandiri(
    code: 'S-17',
    title: 'Keterangan Kelahiran',
    ringkasan:
        'Surat yang menyatakan kelahiran seseorang untuk pembuatan akta kelahiran',
    lampiran: 'F-2.01-KELAHIRAN',
    fields: [],
    sudahDiimplementasikan: true,
  ),
  SuratMandiri(
    code: 'S-21',
    title: 'Keterangan Kematian',
    ringkasan: 'Surat bukti resmi bahwa seseorang telah meninggal dunia',
    lampiran: 'F-2.01-KEMATIAN',
    fields: [],
    sudahDiimplementasikan: true,
  ),
];
