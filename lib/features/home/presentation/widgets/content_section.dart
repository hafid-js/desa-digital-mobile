import 'package:desa_digital/core/widgets/rounded_container.dart';
import 'package:desa_digital/core/widgets/section_heading.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/presentation/widgets/content_card.dart';
import 'package:flutter/material.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    super.key,
    required this.title,
    required this.items,
    required this.onTap,
    this.buttonTitle = "Lihat Semua",
    this.onButtonPressed,
    this.padding = const EdgeInsets.only(left: 15, top: 5, bottom: 8),
  });

  final String title;
  final String buttonTitle;
  final List<ContentItem> items;
  final void Function(ContentItem) onTap;
  final VoidCallback? onButtonPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      color: Colors.white,
      child: Column(
        children: [
          AppSectionHeading(
            title: title,
            buttonTitle: buttonTitle,
            onPressed: onButtonPressed,
          ),
          AppRoundedContainer(
            child: SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ContentCard(item: item, onTap: () => onTap(item));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
