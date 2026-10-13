import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:desa_digital/features/surat/presentation/controllers/pengunggah_lampiran.dart';
import 'package:desa_digital/features/surat/presentation/utils/cari_lampiran_wajib.dart';
import 'package:desa_digital/features/surat/domain/entities/permohonan_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/sebab_kematian.dart';
import 'package:desa_digital/features/surat/domain/entities/yang_menerangkan.dart';
import 'package:desa_digital/features/surat/domain/entities/hubungan_keluarga.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kolom_dropdown_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kolom_teks_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/date_field.dart';
import 'package:desa_digital/features/surat/presentation/widgets/field_label.dart';
import 'package:desa_digital/features/surat/presentation/widgets/daftar_lampiran_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kartu_meta_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/person_form_fields.dart';
import 'package:desa_digital/features/surat/presentation/widgets/section_header.dart';
import 'package:desa_digital/features/surat/presentation/widgets/time_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeteranganKematianScreen extends StatefulWidget {
  const KeteranganKematianScreen({super.key});

  @override
  State<KeteranganKematianScreen> createState() =>
      _KeteranganKematianScreenState();
}

class _KeteranganKematianScreenState extends State<KeteranganKematianScreen> {
  static const _type = JenisSurat.death;

  final _deceased = DataOrangForm();
  final _reporter = DataOrangForm();
  final _witnessOne = DataOrangForm(requireNik: false);
  final _witnessTwo = DataOrangForm(requireNik: false);

  final _deathDate = TextEditingController();
  final _deathTime = TextEditingController();
  final _deathPlace = TextEditingController();

  final _cause = ValueNotifier<SebabKematian?>(null);
  final _informer = ValueNotifier<YangMenerangkan?>(null);
  final _relationship = ValueNotifier<HubunganKeluarga?>(null);

  final _attachments = <String, PengunggahLampiran>{
    "Foto KTP Almarhum": PengunggahLampiran(),
    "Kartu Keluarga": PengunggahLampiran(),
    "Surat Keterangan Meninggal dari Dokter/Puskesmas": PengunggahLampiran(),
  };

  final _formKey = GlobalKey<FormState>();

  String? _validateDeathPlace(String? value) =>
      (value ?? '').trim().isEmpty ? "Tempat kematian wajib diisi" : null;

  String? _validateDeathDate(String? value) {
    if ((value ?? '').trim().isEmpty) return "Tanggal kematian wajib diisi";
    final birth = _deceased.birthDateValue;
    if (birth != null && _deceased.birthDate.text.trim().isNotEmpty) {
      final death = _parseDeathDate();
      if (death != null && death.isBefore(birth)) {
        return "Tanggal kematian sebelum tanggal lahir almarhum";
      }
    }
    return null;
  }

  DateTime? _parseDeathDate() {
    final parts = _deathDate.text.split('-');
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    return DateTime(year, month, day);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final belumLengkap = cariLampiranWajibYangBelumDiunggah(
      _type,
      _attachments,
    );
    if (belumLengkap.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Lampiran wajib belum diunggah: ${belumLengkap.join(', ')}",
          ),
        ),
      );
      return;
    }

    final request = PermohonanKematian(
      deceased: _deceased.keDataPenduduk(),
      deathDate: _parseDeathDate() ?? DateTime.now(),
      deathTime: _deathTime.text,
      deathPlace: _deathPlace.text.trim(),
      cause: _cause.value!,
      informer: _informer.value!,
      reporter: _reporter.keDataPenduduk(),
      reporterRelationship: _relationship.value!,
      witnesses: [_witnessOne.keDataPenduduk(), _witnessTwo.keDataPenduduk()],
    );

    await Get.find<SuratController>().kirim(request.toMap());
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permohonan Diterima"),
        content: Text(
          "Permohonan ${_type.title} dengan kode ${_type.code} "
          "telah dikirim ke petugas desa untuk diverifikasi.\n\n"
          "Formulir pelaporan ${_type.labelLampiran} akan dilampirkan.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Selesai"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDeathDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _parseDeathDate() ?? now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _deathDate.text = _formatDate(picked));
    }
  }

  Future<void> _pickDeathTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    if (picked == null) return;
    final hour = picked.hour.toString().padLeft(2, '0');
    final minute = picked.minute.toString().padLeft(2, '0');
    setState(() => _deathTime.text = '$hour:$minute');
  }

  String _formatDate(DateTime value) =>
      '${value.day.toString().padLeft(2, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.year}';

  @override
  void dispose() {
    _deceased.dispose();
    _reporter.dispose();
    _witnessOne.dispose();
    _witnessTwo.dispose();
    _deathDate.dispose();
    _deathTime.dispose();
    _deathPlace.dispose();
    _cause.dispose();
    _informer.dispose();
    _relationship.dispose();
    for (final controller in _attachments.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_type.title, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KartuMetaSurat(type: _type),
                const SectionHeader(
                  "Data Almarhum",
                  subtitle: "Bagian Jenazah pada formulir pelaporan",
                ),
                KolomDataOrang(
                  state: _deceased,
                  nikHint: "Contoh: 3306132208990002",
                ),
                const SizedBox(height: 8),
                const SectionHeader(
                  "Keterangan Kematian",
                  subtitle: "Nomor 7 sampai 14 pada formulir pelaporan",
                ),
                const FieldLabel("Tanggal Kematian"),
                DateField(
                  controller: _deathDate,
                  validator: _validateDeathDate,
                  pickDate: _pickDeathDate,
                ),
                const FieldLabel("Pukul Kematian"),
                TimeField(controller: _deathTime, pickTime: _pickDeathTime),
                const SizedBox(height: 14),
                const FieldLabel("Tempat Kematian"),
                KolomTeksSurat(
                  label: "Contoh: RSA Bruno",
                  controller: _deathPlace,
                  validator: _validateDeathPlace,
                ),
                const FieldLabel("Sebab Kematian"),
                KolomDropdownSurat<SebabKematian>(
                  label: "Sebab Kematian",
                  items: SebabKematian.values,
                  value: _cause,
                  validator: (v) =>
                      v == null ? "Sebab kematian wajib dipilih" : null,
                  itemBuilder: (_, item) =>
                      Text(item.label, style: const TextStyle(fontSize: 14)),
                ),
                const FieldLabel("Yang Menerangkan"),
                KolomDropdownSurat<YangMenerangkan>(
                  label: "Yang Menerangkan",
                  items: YangMenerangkan.values,
                  value: _informer,
                  validator: (v) =>
                      v == null ? "Yang menerangkan wajib dipilih" : null,
                  itemBuilder: (_, item) =>
                      Text(item.label, style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(height: 8),
                const SectionHeader(
                  "Keterangan Pelapor",
                  subtitle: "Nomor 10 sampai 15 pada formulir pelaporan",
                ),
                KolomDataOrang(state: _reporter, nikHint: "NIK pelapor"),
                const FieldLabel("Hubungan dengan yang Mati"),
                KolomDropdownSurat<HubunganKeluarga>(
                  label: "Hubungan",
                  items: HubunganKeluarga.values,
                  value: _relationship,
                  validator: (v) => v == null ? "Hubungan wajib dipilih" : null,
                  itemBuilder: (_, item) =>
                      Text(item.label, style: const TextStyle(fontSize: 14)),
                ),
                const SizedBox(height: 8),
                const SectionHeader(
                  "Data Saksi",
                  subtitle: "Saksi I dan Saksi II pada formulir pelaporan",
                ),
                KolomDataOrang(
                  state: _witnessOne,
                  nikHint: "NIK Saksi I (boleh dikosongkan)",
                  showAddress: false,
                ),
                const SizedBox(height: 8),
                KolomDataOrang(
                  state: _witnessTwo,
                  nikHint: "NIK Saksi II (boleh dikosongkan)",
                  showAddress: false,
                ),
                const SizedBox(height: 8),
                const SectionHeader("Lampiran Persyaratan"),
                DaftarLampiranSurat(type: _type, controllers: _attachments),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Simpan",
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
