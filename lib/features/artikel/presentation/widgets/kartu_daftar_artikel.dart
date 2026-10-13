import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

const String _deskripsiArtikel =
    "Judul : Gapura PRPP | Lokasi : Gapura PRPP Puri Anjasmoro | "
    "Deskripsi Laporan : Gapura PRPP yg lampu merah, mohon di perhatikan";

const String _tanggalArtikel = "17 Sept 2026";

class KartuDaftarArtikel extends StatelessWidget {
  const KartuDaftarArtikel({
    super.key,
    required this.title,
    required this.titleColor,
    required this.onTap,
    this.titleFontWeight,
  });

  final String title;
  final Color titleColor;
  final FontWeight? titleFontWeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 6, bottom: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(right: 12, left: 8, top: 6, bottom: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(width: 0.2, color: AppColors.primary),
              right: BorderSide(width: 0.2, color: AppColors.primary),
              bottom: BorderSide(width: 0.2, color: AppColors.primary),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  AppAssets.complaintThumbnail,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: titleColor,
                        fontWeight: titleFontWeight,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _deskripsiArtikel,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _tanggalArtikel,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                fontSize: 11,
                                color: AppColors.textSecondaryLight,
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Icon(
                          Icons.bookmark_rounded,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
