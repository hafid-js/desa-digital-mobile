import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUploadField extends StatelessWidget {
  const PhotoUploadField({
    super.key,
    required this.hint,
    this.file,
    this.onTap,
    this.onRemove,
  });

  final String hint;
  final XFile? file;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final current = file;
    final hasFile = current != null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: hasFile ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: Icon(
              hasFile ? Iconsax.tick_circle : Icons.attach_file_rounded,
              size: 20,
              color: hasFile ? AppColors.green : AppColors.primary,
            ),
            suffixIcon: hasFile
                ? IconButton(
                    onPressed: onRemove,
                    icon: Icon(
                      Iconsax.close_circle,
                      size: 20,
                      color: AppColors.secondary,
                    ),
                  )
                : Icon(
                    Iconsax.arrow_down_1,
                    size: 20,
                    color: AppColors.primary,
                  ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
          child: hasFile
              ? Text(
                  current.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
