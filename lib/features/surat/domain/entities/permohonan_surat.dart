import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/sebab_kematian.dart';
import 'package:desa_digital/features/surat/domain/entities/yang_menerangkan.dart';
import 'package:desa_digital/features/surat/domain/entities/hubungan_keluarga.dart';
import 'package:desa_digital/features/surat/domain/entities/data_penduduk.dart';

class PermohonanKematian {
  const PermohonanKematian({
    required this.deceased,
    required this.deathDate,
    required this.deathTime,
    required this.deathPlace,
    required this.cause,
    required this.informer,
    required this.reporter,
    required this.reporterRelationship,
    required this.witnesses,
  });

  final DataPenduduk deceased;
  final DateTime deathDate;
  final String deathTime;
  final String deathPlace;
  final SebabKematian cause;
  final YangMenerangkan informer;
  final DataPenduduk reporter;
  final HubunganKeluarga reporterRelationship;
  final List<DataPenduduk> witnesses;

  JenisSurat get type => JenisSurat.death;

  Map<String, dynamic> toMap() => {
    'kode_surat': type.code,
    'lampiran': type.lampiran,
    'nama_kematian': deceased.name,
    'nik_kematian': deceased.nik,
    'sex_id': deceased.gender?.code,
    'tempat_lahir_kematian': deceased.birthPlace,
    'tanggal_lahir_kematian': deceased.birthDate?.toIso8601String(),
    'tanggal_kematian': deathDate.toIso8601String(),
    'jam_kematian': deathTime,
    'tempat_kematian': deathPlace,
    'sebab_kematian': cause.label,
    'sebab_kematian_id': cause.code,
    'yang_menerangkan': informer.label,
    'yang_menerangkan_id': informer.code,
    'nik_pelapor': reporter.nik,
    'nama_pelapor': reporter.name,
    'pekerjaan_pelapor': reporter.occupation?.label,
    'alamat_pelapor': reporter.address,
    'hubungan_pelapor': reporterRelationship.label,
    'hubungan_pelapor_id': reporterRelationship.code,
    'saksi_i': witnesses.isNotEmpty ? witnesses[0].toMap() : null,
    'saksi_ii': witnesses.length > 1 ? witnesses[1].toMap() : null,
  };
}

class PermohonanKelahiran {
  const PermohonanKelahiran({
    required this.baby,
    required this.birthDay,
    required this.birthTime,
    required this.childOrder,
    required this.mother,
    required this.father,
    required this.reporter,
    required this.reporterRelationship,
    required this.witnesses,
  });

  final DataPenduduk baby;
  final String birthDay;
  final String birthTime;
  final int childOrder;
  final DataPenduduk mother;
  final DataPenduduk father;
  final DataPenduduk reporter;
  final HubunganKeluarga reporterRelationship;
  final List<DataPenduduk> witnesses;

  JenisSurat get type => JenisSurat.birth;

  Map<String, dynamic> toMap() => {
    'kode_surat': type.code,
    'lampiran': type.lampiran,
    'nama_anak': baby.name,
    'jenis_kelamin_anak': baby.gender?.label,
    'sex_id': baby.gender?.code,
    'tempat_lahir_anak': baby.birthPlace,
    'tanggal_lahir_anak': baby.birthDate?.toIso8601String(),
    'hari_lahir': birthDay,
    'pukul_lahir': birthTime,
    'anak_ke': childOrder,
    'nik_ibu': mother.nik,
    'nama_ibu': mother.name,
    'tempat_lahir_ibu': mother.birthPlace,
    'tanggal_lahir_ibu': mother.birthDate?.toIso8601String(),
    'umur_ibu': mother.labelUmur,
    'pekerjaan_ibu': mother.occupation?.label,
    'pekerjaanid_ibu': mother.occupation?.code,
    'alamat_ibu': mother.address,
    'nik_ayah': father.nik,
    'nama_ayah': father.name,
    'tempat_lahir_ayah': father.birthPlace,
    'tanggal_lahir_ayah': father.birthDate?.toIso8601String(),
    'umur_ayah': father.labelUmur,
    'pekerjaan_ayah': father.occupation?.label,
    'pekerjaanid_ayah': father.occupation?.code,
    'alamat_ayah': father.address,
    'nik_pelapor': reporter.nik,
    'nama_pelapor': reporter.name,
    'umur_pelapor': reporter.labelUmur,
    'pekerjaan_pelapor': reporter.occupation?.label,
    'alamat_pelapor': reporter.address,
    'hubungan_pelapor': reporterRelationship.label,
    'hubungan_pelapor_id': reporterRelationship.code,
    'saksi_i': witnesses.isNotEmpty ? witnesses[0].toMap() : null,
    'saksi_ii': witnesses.length > 1 ? witnesses[1].toMap() : null,
  };
}
