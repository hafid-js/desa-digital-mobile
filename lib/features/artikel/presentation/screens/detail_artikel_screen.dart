import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/rounded_image.dart';
import 'package:desa_digital/features/artikel/domain/entities/article_category.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DetailArtikelScreen extends StatelessWidget {
  const DetailArtikelScreen({super.key});

  static const ArticleSample _cadangan = ArticleSample(
    title:
        "Malam Kebersamaan Kafilah MTQ Nasional di Halaman Masjid Agung Semarang",
  );

  ArticleSample get _artikel {
    final argumen = Get.arguments;
    if (argumen is ArticleSample) return argumen;
    return _cadangan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [Icon(Icons.share_outlined)],
        actionsPadding: const EdgeInsets.only(right: 12),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _artikel.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 5),
              Text(
                "19 September 2026",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 15),
              AppRoundedImage(imageUrl: AppAssets.article11, borderRadius: 12),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.bookmark_rounded,
                  size: 30,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "SEMARANG",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: " - ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    TextSpan(
                      text:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since 1966, when designers at Letraset and James Mosley, the librarian at St Bride Printing Library in London, took a 1914 Cicero translation and scrambled it to make dummy text for Letraset's Body Type sheets. It has survived not only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised thanks to these sheets and more recently with desktop publishing software like Aldus PageMaker and Microsoft Word including versions of Lorem Ipsum.",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppRoundedImage(imageUrl: AppAssets.article2),
              const SizedBox(height: 10),
              AppRoundedImage(imageUrl: AppAssets.article3),
              const SizedBox(height: 10),
              AppRoundedImage(imageUrl: AppAssets.article4),
              const SizedBox(height: 10),
              AppRoundedImage(imageUrl: AppAssets.article5),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
