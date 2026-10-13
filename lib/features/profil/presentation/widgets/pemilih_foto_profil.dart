import 'dart:io';

import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PemilihFotoProfil extends StatefulWidget {
  const PemilihFotoProfil({super.key});

  @override
  State<PemilihFotoProfil> createState() => _PemilihFotoProfilState();
}

class _PemilihFotoProfilState extends State<PemilihFotoProfil> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (!mounted) return;
    setState(() {
      _profileImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppCircularImage(
          image: _profileImage?.path ?? AppAssets.complaintExample,
          isNetworkImage: _profileImage != null,
          height: 100,
          width: 100,
        ),
        Positioned(
          bottom: -14,
          right: -1,
          top: 40,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: _pickImage,
              child: Icon(
                Icons.camera_alt_rounded,
                size: 16,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
