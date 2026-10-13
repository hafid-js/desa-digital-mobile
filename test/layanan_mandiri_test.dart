import 'package:desa_digital/app/routes/app_pages.dart';
import 'package:desa_digital/features/surat/data/datasources/akun_data_source.dart';
import 'package:desa_digital/features/surat/data/datasources/katalog_surat_mandiri_data_source.dart';
import 'package:desa_digital/features/surat/data/datasources/penduduk_data_source.dart';
import 'package:desa_digital/features/surat/data/datasources/surat_mandiri_data_source.dart';
import 'package:desa_digital/features/surat/data/repositories/akun_repository_impl.dart';
import 'package:desa_digital/features/surat/data/repositories/penduduk_repository_impl.dart';
import 'package:desa_digital/features/surat/data/repositories/surat_mandiri_repository_impl.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:desa_digital/features/surat/domain/usecases/surat_usecases.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:desa_digital/features/surat/presentation/screens/daftar_surat_screen.dart';
import 'package:desa_digital/features/surat/presentation/screens/formulir_surat_mandiri_screen.dart';
import 'package:desa_digital/features/surat/presentation/screens/keterangan_kelahiran_screen.dart';
import 'package:desa_digital/features/surat/presentation/screens/keterangan_kematian_screen.dart';
import 'package:desa_digital/features/surat/presentation/screens/permohonan_surat_screen.dart';
import 'package:desa_digital/features/surat/presentation/widgets/konfirmasi_pemohon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

/// Katalog surat dan graf dependensi yang dipakai seluruh test, mengikuti
/// apa yang diikat `SuratBinding` di aplikasi.
class _LingkunganSurat {
  _LingkunganSurat() {
    katalog = KatalogSuratMandiriDataSource();
    suratDataSource = SuratMandiriDataSource(katalog);
    suratRepository = SuratMandiriRepositoryImpl(suratDataSource);
    pendudukDataSource = PendudukDataSource();
    akunRepository = AkunRepositoryImpl(AkunDataSource(pendudukDataSource));
    controller = SuratController(
      GetProfilAktif(akunRepository),
      GetKatalogSuratMandiri(suratRepository),
      GetKatalogSuratPerluProses(suratRepository),
      KirimSuratMandiri(suratRepository),
    );
  }

  late final KatalogSuratMandiriDataSource katalog;
  late final SuratMandiriDataSource suratDataSource;
  late final SuratMandiriRepositoryImpl suratRepository;
  late final PendudukDataSource pendudukDataSource;
  late final AkunRepositoryImpl akunRepository;
  late final SuratController controller;

  List<SuratMandiri> get semua => katalog.semua();
  List<SuratMandiri> get mandiriSiap => katalog.mandiriSiap();
  List<SuratMandiri> get perluProses => katalog.perluProses();
}

final lingkungan = _LingkunganSurat();

/// Daftarkan `SuratController` yang dipakai layar dan simpan agar test bisa
/// memeriksa payload yang terkirim.
void setUpSurat() {
  Get.put<SuratController>(lingkungan.controller);
}

Future<void> _aturLayar(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

/// Aplikasi test memakai `AppPages` supaya navigasi bernama (misalnya dari
/// kartu Permohonan Surat ke daftar surat) ikut teruji.
Widget _app(Widget home) =>
    GetMaterialApp(home: home, getPages: AppPages.pages);

void main() {
  setUp(setUpSurat);
  tearDown(Get.reset);

  group('Layanan Mandiri', () {
    test('katalog memuat surat mandiri OpenSID', () {
      expect(lingkungan.semua, hasLength(15));
      expect(lingkungan.mandiriSiap, hasLength(15));
      expect(lingkungan.perluProses.map((item) => item.code), ['S-17', 'S-21']);
    });

    test('jumlah isian tiap surat sama persis dengan kode_isian OpenSID', () {
      const harapan = <String, int>{
        'S-41': 1,
        '500': 2,
        'S-01': 2,
        'S-02': 1,
        'S-03': 0,
        'S-07': 1,
        'S-08': 0,
        'S-10': 1,
        'S-11': 1,
        'S-12': 2,
        'S-13': 3,
        'S-16': 1,
        'S-30': 2,
        'S-43': 0,
        '471.1': 11,
      };
      for (final surat in lingkungan.semua) {
        expect(
          surat.fields.length + surat.fieldsIdentitasKedua.length,
          harapan[surat.code],
          reason: surat.code,
        );
      }
    });

    test('warga hanya mengetik isian surat, bukan data penduduk', () {
      for (final surat in lingkungan.semua) {
        if (surat.code == '471.1') continue;
        expect(
          surat.fields.length,
          lessThanOrEqualTo(3),
          reason: '${surat.code} tidak boleh meminta data penduduk manual',
        );
      }
    });

    test('hanya 471.1 yang butuh identitas kedua', () {
      final butuh = lingkungan.semua
          .where((item) => item.butuhIdentitasKedua)
          .map((item) => item.code);
      expect(butuh, ['471.1']);
    });

    test('semua surat mandiri punya masa berlaku 1 bulan', () {
      for (final surat in lingkungan.semua) {
        expect(surat.masaBerlakuBulan, 1, reason: surat.code);
      }
    });

    testWidgets('kartu jumlah surat memakai angka nyata', (tester) async {
      await _aturLayar(tester);
      await tester.pumpWidget(_app(PermohonanSuratScreen()));
      await tester.pumpAndSettle();

      expect(
        find.text("${lingkungan.mandiriSiap.length} Jenis Surat"),
        findsOneWidget,
      );
      expect(
        find.text("${lingkungan.perluProses.length} Jenis Surat"),
        findsOneWidget,
      );
      expect(find.text('Surat Pernyataan'), findsNothing);
    });

    testWidgets('klik kartu Surat Mandiri membuka daftar mandiri', (
      tester,
    ) async {
      await _aturLayar(tester);
      await tester.pumpWidget(_app(PermohonanSuratScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Surat Mandiri'));
      await tester.pumpAndSettle();

      expect(find.byType(DaftarSuratScreen), findsOneWidget);
      expect(find.text('Perlu Proses Desa'), findsNothing);
    });

    testWidgets('klik kartu Perlu Proses membuka daftar perlu proses', (
      tester,
    ) async {
      await _aturLayar(tester);
      await tester.pumpWidget(_app(PermohonanSuratScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Perlu Proses Desa'));
      await tester.pumpAndSettle();

      expect(find.byType(DaftarSuratScreen), findsOneWidget);
      expect(find.textContaining('Surat Mandiri ('), findsNothing);
    });

    testWidgets('S-41 memakai formulir mandiri yang sama', (tester) async {
      await _aturLayar(tester);
      await tester.pumpWidget(_app(DaftarSuratScreen.mandiri()));
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('S-41'));
      await tester.pumpAndSettle();

      expect(find.byType(FormulirSuratMandiriScreen), findsOneWidget);
      expect(find.text('Keterangan Pemohon'), findsOneWidget);
      expect(find.text('Masa Berlaku'), findsOneWidget);
    });

    testWidgets('S-17 dan S-21 membuka formulir perlu proses', (tester) async {
      await _aturLayar(tester);
      await tester.pumpWidget(_app(DaftarSuratScreen.perluProses()));
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('S-17'));
      await tester.pumpAndSettle();
      expect(find.byType(KeteranganKelahiranScreen), findsOneWidget);

      Get.back();
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('S-21'));
      await tester.pumpAndSettle();
      expect(find.byType(KeteranganKematianScreen), findsOneWidget);
    });

    testWidgets('setiap surat mandiri punya formulir yang bisa dirender', (
      tester,
    ) async {
      await _aturLayar(tester);

      for (final surat in lingkungan.mandiriSiap) {
        if (surat.code == 'S-41') continue;

        await tester.pumpWidget(
          _app(
            FormulirSuratMandiriScreen(key: ValueKey(surat.code), surat: surat),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.text(surat.title),
          findsWidgets,
          reason: 'gagal merender ${surat.code}',
        );
      }
    });

    testWidgets('ganti surat di state yang sama tidak menyebabkan error', (
      tester,
    ) async {
      await _aturLayar(tester);

      for (final surat in lingkungan.mandiriSiap.where(
        (i) => i.code != 'S-41',
      )) {
        await tester.pumpWidget(
          _app(
            FormulirSuratMandiriScreen(key: ValueKey(surat.code), surat: surat),
          ),
        );
        await tester.pumpAndSettle();
      }
    });

    testWidgets('471.1 menampilkan blok Identitas Kedua', (tester) async {
      await _aturLayar(tester);
      final beda = lingkungan.mandiriSiap.firstWhere((i) => i.code == '471.1');

      await tester.pumpWidget(_app(FormulirSuratMandiriScreen(surat: beda)));
      await tester.pumpAndSettle();

      expect(find.text('Identitas Kedua'), findsOneWidget);
    });

    testWidgets('surat tanpa identitas kedua tidak menampilkan blok itu', (
      tester,
    ) async {
      await _aturLayar(tester);
      final usaha = lingkungan.mandiriSiap.firstWhere((i) => i.code == '500');

      await tester.pumpWidget(_app(FormulirSuratMandiriScreen(surat: usaha)));
      await tester.pumpAndSettle();

      expect(find.text('Identitas Kedua'), findsNothing);
    });

    testWidgets('formulir menolak isian kosong pada field wajib', (
      tester,
    ) async {
      await _aturLayar(tester);
      final s13 = lingkungan.mandiriSiap.firstWhere(
        (item) => item.code == 'S-13',
      );

      await tester.pumpWidget(_app(FormulirSuratMandiriScreen(surat: s13)));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.text('Simpan'),
        find.byType(Form),
        const Offset(0, -200),
      );
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Nama Barang wajib diisi'), findsOneWidget);
    });

    testWidgets('pemohon tampil read-only dari profil akun', (tester) async {
      await _aturLayar(tester);
      final s41 = lingkungan.mandiriSiap.firstWhere(
        (item) => item.code == 'S-41',
      );

      await tester.pumpWidget(_app(FormulirSuratMandiriScreen(surat: s41)));
      await tester.pumpAndSettle();

      expect(find.byType(KonfirmasiPemohon), findsOneWidget);
      expect(
        find.text('Data sesuai akun Anda dan tidak dapat diubah'),
        findsOneWidget,
      );
      expect(find.byType(TextField), findsWidgets);
      final profil =
          (await lingkungan.akunRepository.profilAktif()).valueOrNull;
      expect(find.text(profil!.nik), findsOneWidget);
      expect(find.text(profil.nama), findsOneWidget);
    });

    testWidgets('formulir mandiri tidak punya pencarian NIK', (tester) async {
      await _aturLayar(tester);
      final s41 = lingkungan.mandiriSiap.firstWhere(
        (item) => item.code == 'S-41',
      );

      await tester.pumpWidget(_app(FormulirSuratMandiriScreen(surat: s41)));
      await tester.pumpAndSettle();

      expect(find.text('Cari NIK atau nama'), findsNothing);
    });

    testWidgets('submit mengirim id profil akun ke repository', (tester) async {
      await _aturLayar(tester);
      final s41 = lingkungan.mandiriSiap.firstWhere(
        (item) => item.code == 'S-41',
      );

      await tester.pumpWidget(_app(FormulirSuratMandiriScreen(surat: s41)));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.text('Simpan'),
        find.byType(Form),
        const Offset(0, -200),
      );
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      // Graf di level file dipakai bersama oleh layar dan test, seperti
      // repository singleton yang dipakai sebelum refactor.
      final profil =
          (await lingkungan.akunRepository.profilAktif()).valueOrNull;
      expect(lingkungan.suratDataSource.terkirim, hasLength(1));
      expect(
        lingkungan.suratDataSource.terkirim.first['penduduk_id'],
        profil!.id,
      );
      expect(lingkungan.suratDataSource.terkirim.first['kode_surat'], 'S-41');
    });
  });

  group('SuratMandiriRepository', () {
    test('data source menyimpan payload yang dikirim', () async {
      final dataSource = SuratMandiriDataSource(
        KatalogSuratMandiriDataSource(),
      );
      final repository = SuratMandiriRepositoryImpl(dataSource);

      await repository.kirim({'kode_surat': 'S-01'});
      await repository.kirim({'kode_surat': '500'});

      expect(dataSource.terkirim.map((item) => item['kode_surat']), [
        'S-01',
        '500',
      ]);
    });

    test('katalog dibaca dari data source', () {
      final dataSource = SuratMandiriDataSource(
        KatalogSuratMandiriDataSource(),
      );
      final repository = SuratMandiriRepositoryImpl(dataSource);

      expect(
        repository.katalogSiap().valueOrNull!.length,
        dataSource.katalogSiap().length,
      );
      expect(repository.katalogPerluProses().valueOrNull, isNotEmpty);
    });
  });

  group('PendudukRepository', () {
    late PendudukRepositoryImpl repository;

    setUp(() => repository = PendudukRepositoryImpl(PendudukDataSource()));

    test('mengembalikan seluruh penduduk saat kunci kosong', () async {
      final hasil = (await repository.cari('')).valueOrNull;
      expect(hasil!.length, greaterThanOrEqualTo(2));
    });

    test('mencari berdasarkan NIK', () async {
      final hasil = (await repository.cari('3273091805650001')).valueOrNull;
      expect(hasil!.map((item) => item.nama), ['Ratma Sari']);
    });

    test('mencari berdasarkan nama tidak mempeduli huruf besar', () async {
      final hasil = (await repository.cari('budi')).valueOrNull;
      expect(hasil!.map((item) => item.nama), ['Budi Hidayat']);
    });

    test('kunci yang tidak cocok mengembalikan daftar kosong', () async {
      final hasil = (await repository.cari('zzz')).valueOrNull;
      expect(hasil, isEmpty);
    });

    test('umur dihitung dari tanggal lahir', () {
      final penduduk = lingkungan.pendudukDataSource.semua().first;
      expect(penduduk.umur, isNotNull);
      expect(penduduk.labelUmur, endsWith('TAHUN'));
    });

    test('repository dengan instance berbeda punya data yang sama', () async {
      final lain = PendudukRepositoryImpl(PendudukDataSource());
      expect(
        (await lain.semua()).valueOrNull!.length,
        (await repository.semua()).valueOrNull!.length,
      );
    });
  });
}
