import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:flutter/material.dart';

class ApbdesProgressItem extends StatelessWidget {
  const ApbdesProgressItem({
    super.key,
    required this.title,
    required this.realAmount,
    required this.targetAmount,
    required this.progress,
    required this.percentageText,
    this.stackAlignment = Alignment.centerLeft,
  });

  factory ApbdesProgressItem.fromItem(ApbdesItem item) => ApbdesProgressItem(
    title: item.title,
    realAmount: item.realAmount,
    targetAmount: item.targetAmount,
    progress: item.progress,
    percentageText: item.percentageText,
    stackAlignment: item.labelAlignment == ApbdesLabelAlignment.center
        ? Alignment.center
        : Alignment.centerLeft,
  );

  final String title;
  final String realAmount;
  final String targetAmount;
  final double progress;
  final String percentageText;
  final Alignment stackAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(realAmount, style: Theme.of(context).textTheme.labelSmall),
            Text(targetAmount, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: stackAlignment,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 15,
                backgroundColor: Colors.grey[200],
                color: AppColors.secondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                percentageText,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
