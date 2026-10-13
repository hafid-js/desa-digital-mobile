import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TilePeraturanDesa extends StatelessWidget {
  const TilePeraturanDesa({
    super.key,
    required this.regulation,
    required this.onTap,
  });

  final VillageRegulation regulation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 6, top: 6, bottom: 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                  regulation.thumbnailAsset,
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
                      regulation.title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      regulation.description,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar5,
                              color: AppColors.primary,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              regulation.date,
                              style: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_rounded,
                                color: AppColors.primary,
                                size: 15,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  regulation.author,
                                  style: Theme.of(context).textTheme.labelSmall!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.bookmark_rounded,
                          color: AppColors.primary,
                          size: 15,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          regulation.category,
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
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
