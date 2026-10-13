import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';

class SyaratSurat {
  const SyaratSurat({required this.label, required this.wajib, this.hint});

  final String label;
  final bool wajib;
  final String? hint;

  String get labelKeterangan => wajib ? 'Wajib' : 'Opsional';
}

extension PersyaratanSurat on JenisSurat {
  List<SyaratSurat> get persyaratan => switch (this) {
    JenisSurat.domicile => const [
      SyaratSurat(label: "Foto KTP", wajib: true),
      SyaratSurat(label: "Kartu Keluarga", wajib: true),
      SyaratSurat(
        label: "Surat Pernyataan Alamat Domisili",
        wajib: false,
        hint: "Diperlukan bila alamat KTP berbeda dengan domisili",
      ),
    ],
    JenisSurat.birth => const [
      SyaratSurat(label: "Foto KTP Ayah", wajib: true),
      SyaratSurat(label: "Foto KTP Ibu", wajib: true),
      SyaratSurat(label: "Kartu Keluarga", wajib: true),
      SyaratSurat(
        label: "Surat Keterangan Lahir dari Bidan/Puskesmas",
        wajib: true,
      ),
    ],
    JenisSurat.death => const [
      SyaratSurat(label: "Foto KTP Almarhum", wajib: true),
      SyaratSurat(label: "Kartu Keluarga", wajib: true),
      SyaratSurat(
        label: "Surat Keterangan Meninggal dari Dokter/Puskesmas",
        wajib: true,
        hint: "Menjadi dasar-data causality penyebab kematian",
      ),
    ],
  };
}
