import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/syarat_surat.dart';
import 'package:desa_digital/features/surat/presentation/controllers/pengunggah_lampiran.dart';
import 'package:desa_digital/features/surat/presentation/widgets/field_label.dart';
import 'package:desa_digital/features/surat/presentation/widgets/photo_upload_field.dart';
import 'package:flutter/material.dart';

class DaftarLampiranSurat extends StatelessWidget {
  const DaftarLampiranSurat({
    super.key,
    required this.type,
    required this.controllers,
  });

  final JenisSurat type;
  final Map<String, PengunggahLampiran> controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: type.persyaratan.map((item) {
        final controller = controllers[item.label];
        if (controller == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: FieldLabel(item.label)),
                  Text(
                    item.labelKeterangan,
                    style: TextStyle(
                      fontSize: 11,
                      color: item.wajib ? Colors.redAccent : Colors.black45,
                    ),
                  ),
                ],
              ),
              if (item.hint != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    item.hint!,
                    style: const TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                ),
              ListenableBuilder(
                listenable: controller,
                builder: (context, _) => PhotoUploadField(
                  hint: "Pilih File Gambar",
                  file: controller.file,
                  onTap: () => controller.pick(context),
                  onRemove: controller.clear,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
