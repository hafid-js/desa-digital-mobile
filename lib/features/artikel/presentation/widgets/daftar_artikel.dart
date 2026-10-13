import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';
import 'package:desa_digital/features/artikel/presentation/widgets/kartu_daftar_artikel.dart';
import 'package:flutter/material.dart';

class GayaKategori {
  const GayaKategori({required this.color, this.fontWeight});

  final Color color;
  final FontWeight? fontWeight;
}

GayaKategori gayaKategori(String label) => switch (label) {
  'Publik' => const GayaKategori(
    color: Colors.black,
    fontWeight: FontWeight.w500,
  ),
  _ => GayaKategori(color: AppColors.primary),
};

class DaftarArtikel extends StatelessWidget {
  const DaftarArtikel({
    super.key,
    required this.category,
    required this.onItemTap,
  });

  final ArticleCategory category;
  final void Function(ArticleSample sample) onItemTap;

  @override
  Widget build(BuildContext context) {
    final gaya = gayaKategori(category.label);

    return ListView.builder(
      itemCount: category.samples.length,
      itemBuilder: (context, index) {
        return KartuDaftarArtikel(
          title: category.samples[index].title,
          titleColor: gaya.color,
          titleFontWeight: gaya.fontWeight,
          onTap: () => onItemTap(category.samples[index]),
        );
      },
    );
  }
}
