import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/presentation/widgets/apbdes_card_shell.dart';
import 'package:desa_digital/features/home/presentation/widgets/apbdes_progress_item.dart';
import 'package:flutter/material.dart';

class ApbdesPelaksanaanCard extends StatelessWidget {
  const ApbdesPelaksanaanCard({super.key, required this.section});

  final ApbdesSection section;

  @override
  Widget build(BuildContext context) {
    return ApbdesCardShell(
      title: section.title,
      children: [
        for (var index = 0; index < section.items.length; index++) ...[
          ApbdesProgressItem.fromItem(section.items[index]),
          if (index < section.items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}
