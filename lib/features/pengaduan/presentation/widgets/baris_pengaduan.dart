import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BarisInfo extends StatelessWidget {
  const BarisInfo({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.onTap,
    this.iconSize = 35,
  });

  final ImageProvider image;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 5),
        Text(
          description,
          style: Theme.of(context).textTheme.labelSmall,
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: image, height: iconSize, width: iconSize),
        const SizedBox(width: 10),
        Expanded(
          child: onTap == null ? text : InkWell(onTap: onTap, child: text),
        ),
        Icon(Iconsax.arrow_right_3, color: AppColors.primary),
      ],
    );
  }
}

class BarisMenu extends StatelessWidget {
  const BarisMenu({super.key, required this.image, required this.title});

  final ImageProvider image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(image: image, height: 35, width: 35),
            const SizedBox(width: 10),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        Icon(Iconsax.arrow_right_3, color: AppColors.primary),
      ],
    );
  }
}
