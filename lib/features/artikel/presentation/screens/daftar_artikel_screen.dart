import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:desa_digital/core/widgets/tab_section.dart';
import 'package:desa_digital/features/artikel/presentation/controllers/article_controller.dart';
import 'package:desa_digital/features/artikel/presentation/widgets/daftar_artikel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaftarArtikelScreen extends StatelessWidget {
  const DaftarArtikelScreen({super.key});

  ArticleController get _controller => Get.find<ArticleController>();

  @override
  Widget build(BuildContext context) {
    final categories = _controller.kategori;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Warta Desa",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: TabSection(
        labels: [for (final category in categories) category.label],
        tabs: [
          for (final category in categories)
            DaftarArtikel(
              category: category,
              onItemTap: (item) =>
                  Get.toNamed(Routes.detailArtikel, arguments: item),
            ),
        ],
      ),
    );
  }
}
