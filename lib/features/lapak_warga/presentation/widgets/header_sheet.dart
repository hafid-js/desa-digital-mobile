import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderSheet extends StatelessWidget {
  const HeaderSheet({
    super.key,
    required this.judul,
    required this.onReset,
    required this.onTutup,
    this.onPublish,
    this.publish = false,
    this.showReset = false,
  });

  final String judul;
  final VoidCallback onReset;
  final VoidCallback onTutup;
  final VoidCallback? onPublish;
  final bool publish;
  final bool showReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, right: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onTutup,
            icon: const Icon(Icons.close_rounded, size: 30),
          ),
          const Spacer(),
          Text(
            judul,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          if (publish)
            TextButton(
              onPressed: onPublish,
              child: Text(
                "Publish",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            TextButton(
              onPressed: onReset,
              child: showReset
                  ? Text(
                      "Reset",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
