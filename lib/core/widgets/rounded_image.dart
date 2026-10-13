import 'package:desa_digital/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';

class AppRoundedImage extends StatelessWidget {
  const AppRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = AppSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: Colors.pink,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl.isEmpty) {
      return const Icon(Icons.image_not_supported, color: Colors.grey);
    }

    if (isNetworkImage) {
      return Image.network(
        imageUrl,
        fit: fit,
        errorBuilder: (_, _, _) =>
            const Icon(Icons.broken_image, color: Colors.grey),
      );
    }

    return Image.asset(
      imageUrl,
      fit: fit,
      errorBuilder: (_, _, _) =>
          const Icon(Icons.broken_image, color: Colors.grey),
    );
  }
}
