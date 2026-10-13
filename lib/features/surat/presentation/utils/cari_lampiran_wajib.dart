import 'package:desa_digital/features/surat/presentation/controllers/pengunggah_lampiran.dart';
import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/syarat_surat.dart';

List<String> cariLampiranWajibYangBelumDiunggah(
  JenisSurat type,
  Map<String, PengunggahLampiran> controllers,
) => type.persyaratan
    .where((item) => item.wajib)
    .where((item) => controllers[item.label]?.file == null)
    .map((item) => item.label)
    .toList();
