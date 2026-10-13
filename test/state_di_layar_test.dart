import 'package:desa_digital/features/agenda/presentation/bindings/agenda_binding.dart';
import 'package:desa_digital/features/agenda/presentation/controllers/agenda_controller.dart';
import 'package:desa_digital/features/autentikasi/presentation/bindings/auth_binding.dart';
import 'package:desa_digital/features/autentikasi/presentation/controllers/register_controller.dart';
import 'package:desa_digital/features/cuaca/presentation/bindings/weather_binding.dart';
import 'package:desa_digital/features/cuaca/presentation/controllers/weather_controller.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/filter_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/urutan.dart';
import 'package:desa_digital/features/lapak_warga/presentation/bindings/lapak_warga_binding.dart';
import 'package:desa_digital/features/lapak_warga/presentation/controllers/lapak_warga_controller.dart';
import 'package:desa_digital/features/profil/domain/entities/jenis_kelamin.dart';
import 'package:desa_digital/features/profil/presentation/bindings/profile_binding.dart';
import 'package:desa_digital/features/profil/presentation/controllers/profile_controller.dart';
import 'package:desa_digital/features/profil/presentation/screens/ubah_profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

/// State yang dulunya milik `State` di dalam screen (pencarian, kalender,
/// filter) tidak boleh terbawa ke kunjungan berikutnya. Controller yang hanya
/// dipakai satu halaman harus mengikuti umur halaman tersebut, sedangkan halaman
/// yang memakai controller bersama harus mengembalikan isian form ke data profil.
void main() {
  setUp(() => Get.testMode = true);

  tearDown(Get.reset);

  group('State sebaiknya berumur seumur halaman', () {
    test('Cuaca: pencarian kembali kosong setelah halaman ditutup', () {
      WeatherBinding().dependencies();
      Get.find<WeatherController>().searchController.text = 'Sleman';

      Get.delete<WeatherController>();
      WeatherBinding().dependencies();

      expect(Get.find<WeatherController>().searchController.text, isEmpty);
    });

    test('Agenda: format kalender dan tanggal terpilih kembali ke awal', () {
      AgendaBinding().dependencies();
      Get.find<AgendaController>()
        ..onFormatChanged(CalendarFormat.week)
        ..onDaySelected(DateTime.utc(2026, 1, 2), DateTime.utc(2026, 1, 2));

      Get.delete<AgendaController>();
      AgendaBinding().dependencies();
      final baru = Get.find<AgendaController>();

      expect(baru.calendarFormat.value, CalendarFormat.month);
      expect(
        DateUtils.isSameDay(baru.selectedDay.value, DateTime.now()),
        isTrue,
        reason: 'sebelum migrasi tanggal terpilih selalu hari ini',
      );
    });

    test('Lapak warga: filter dan urutan kembali ke awal', () {
      LapakWargaBinding().dependencies();
      Get.find<LapakWargaController>()
        ..setUrutan(Urutan.hargaTerendah)
        ..setFilter(
          const FilterLapak(
            kategori: <String>{'Elektronik'},
            hargaMinimum: 100,
          ),
        );

      Get.delete<LapakWargaController>();
      LapakWargaBinding().dependencies();
      final baru = Get.find<LapakWargaController>();

      expect(baru.urutan.value, Urutan.palingSesuai);
      expect(baru.filter.value.jumlahFilterAktif, 0);
    });

    test('Registrasi: kata sandi kembali tersembunyi di tiap langkah', () {
      AuthBinding().dependencies();
      Get.find<RegisterController>().togglePassword();

      Get.delete<RegisterController>();
      AuthBinding().dependencies();

      expect(Get.find<RegisterController>().sembunyikanPassword.value, isTrue);
    });
  });

  group('Form profil', () {
    testWidgets(
      'isian yang belum disimpan tidak terbawa saat layar dibuka lagi',
      (tester) async {
        ProfileBinding().dependencies();

        await tester.pumpWidget(GetMaterialApp(home: const UbahProfilScreen()));
        await tester.pumpAndSettle();

        final controller = Get.find<ProfileController>()
          ..fullNameController.text = 'Nama Baru'
          ..emailController.text = 'baru@hafidtech.com'
          ..phoneController.text = '089999999999'
          ..selectGender(JenisKelamin.male);
        await tester.pumpAndSettle();

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        await tester.pumpWidget(GetMaterialApp(home: const UbahProfilScreen()));
        await tester.pumpAndSettle();

        expect(find.text('Nama Baru'), findsNothing);
        expect(controller.fullNameController.text, 'HafidTech');
        expect(controller.emailController.text, 'dev@hafidtech.com');
        expect(controller.phoneController.text, '082322875277');
        expect(controller.selectedGender.value, isNull);
      },
    );
  });
}
