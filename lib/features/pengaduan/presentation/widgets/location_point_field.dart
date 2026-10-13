import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:get/get.dart';

class LocationPointField extends StatefulWidget {
  const LocationPointField({super.key, this.onLocationPicked});

  final void Function(Map<String, dynamic> lokasi)? onLocationPicked;

  @override
  State<LocationPointField> createState() => _LocationPointFieldState();
}

class _LocationPointFieldState extends State<LocationPointField> {
  final TextEditingController _alamatController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _alamatController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pilihLokasi() async {
    final hasil = await Get.toNamed(Routes.pilihLokasi);
    if (!mounted || hasil is! Map) return;
    final alamat = hasil['alamat']?.toString().trim() ?? '';
    if (alamat.isEmpty) return;
    setState(() {
      _alamatController.text = alamat;
    });
    widget.onLocationPicked?.call(Map<String, dynamic>.from(hasil));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _pilihLokasi,
      child: TextFormField(
        controller: _alamatController,
        focusNode: _focusNode,
        readOnly: true,
        onTap: _pilihLokasi,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.map_outlined, color: AppColors.primary),
          labelText: "Tambah titik lokasi (opsional)",
          labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: AppColors.primary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.dark.withAlpha(50),
              width: 1.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.dark.withAlpha(50),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
