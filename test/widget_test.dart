import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/section_heading.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/presentation/widgets/content_card.dart';
import 'package:desa_digital/features/profil/data/datasources/profile_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppAssets', () {
    test('semua path asset memakai awalan yang valid', () {
      final paths = <String>[
        AppAssets.banner1,
        AppAssets.article9,
        AppAssets.event5,
        AppAssets.complaintThumbnail,
        AppAssets.iconTanya,
        AppAssets.emptyState,
        AppAssets.villageRegulationLkdCepedak2021,
        AppAssets.dataProvinsi,
      ];

      for (final path in paths) {
        expect(path, isNotEmpty);
        expect(
          path.startsWith('assets/') || path.startsWith('data/'),
          isTrue,
          reason: '$path tidak menunjuk ke asset yang di-declare di pubspec',
        );
      }
    });
  });

  group('AppColors', () {
    test('warna primary dan putih sesuai nilai desain', () {
      expect(AppColors.primary, const Color(0xFF455CCA));
      expect(AppColors.white, Colors.white);
    });
  });

  group('ContentCard', () {
    testWidgets('menampilkan judul dan tanggal konten', (tester) async {
      const item = ContentItem(
        image: AppAssets.article9,
        title: 'Judul Berita',
        date: '24 Februari 2026',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContentCard(item: item, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Judul Berita'), findsOneWidget);
      expect(find.text('24 Februari 2026'), findsOneWidget);
    });

    testWidgets('memanggil onTap saat ditekan', (tester) async {
      var tapped = false;
      const item = ContentItem(
        image: AppAssets.article9,
        title: 'Judul Berita',
        date: '24 Februari 2026',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContentCard(item: item, onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(ContentCard));
      expect(tapped, isTrue);
    });
  });

  group('AppSectionHeading', () {
    testWidgets('menampilkan judul dan tombol aksi', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeading(
              title: 'Berita Terbaru',
              buttonTitle: 'Lihat Semua',
            ),
          ),
        ),
      );

      expect(find.text('Berita Terbaru'), findsOneWidget);
      expect(find.text('Lihat Semua'), findsOneWidget);
    });
  });

  group('menuSections profil', () {
    test('setiap kelompok menu punya judul dan minimal satu item', () {
      final bagianMenuProfil = ProfileLocalDataSource().menuSections();
      expect(bagianMenuProfil, isNotEmpty);

      for (final section in bagianMenuProfil) {
        expect(section.title, isNotEmpty);
        expect(section.items, isNotEmpty);
      }
    });

    test('baris terakhir tiap kelompok tidak memakai pemisah', () {
      for (final section in ProfileLocalDataSource().menuSections()) {
        expect(section.items.last.showDivider, isFalse);
      }
    });
  });
}
