import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:desa_digital/features/surat/presentation/controllers/pengunggah_lampiran.dart';
import 'package:desa_digital/features/surat/presentation/utils/cari_lampiran_wajib.dart';
import 'package:desa_digital/features/surat/domain/entities/permohonan_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/jenis_surat.dart';
import 'package:desa_digital/features/surat/domain/entities/hubungan_keluarga.dart';
import 'package:desa_digital/features/surat/domain/entities/jenis_kelamin.dart';
import 'package:desa_digital/features/surat/domain/utils/hitung_umur.dart';
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

class KeteranganKelahiranScreen extends StatefulWidget {
  const KeteranganKelahiranScreen({super.key});

  @override
  State<KeteranganKelahiranScreen> createState() =>
      _KeteranganKelahiranScreenState();
}

class _KeteranganKelahiranScreenState extends State<KeteranganKelahiranScreen> {
  static const _type = JenisSurat.birth;

  final _baby = DataOrangForm(
    requireNik: false,
    requireBirthDate: false,
    withDataLanjut: false,
  );
  final _mother = DataOrangForm();
  final _father = DataOrangForm();
  final _reporter = DataOrangForm();
  final _witnessOne = DataOrangForm(requireNik: false);
  final _witnessTwo = DataOrangForm(requireNik: false);

  final _birthTime = TextEditingController();
  final _childOrder = TextEditingController(text: '1');

  final _gender = ValueNotifier<JenisKelamin?>(null);
  final _relationship = ValueNotifier<HubunganKeluarga?>(null);
  final _birthDay = ValueNotifier<String?>(null);

  final _attachments = <String, PengunggahLampiran>{
    "Foto KTP Ayah": PengunggahLampiran(),
    "Foto KTP Ibu": PengunggahLampiran(),
    "Kartu Keluarga": PengunggahLampiran(),
    "Surat Keterangan Lahir dari Bidan/Puskesmas": PengunggahLampiran(),
  };

  final _formKey = GlobalKey<FormState>();

  String? _validateChildOrder(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return "Anak ke wajib diisi";
    final order = int.tryParse(text);
    if (order == null) return "Anak ke harus berupa angka";
    if (order < 1) return "Anak ke minimal 1";
    return null;
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

    final request = PermohonanKelahiran(
      baby: _baby.keDataPenduduk(),
      birthDay:
          _birthDay.value ??
          HitungUmur.formatHari(_baby.birthDateValue ?? DateTime.now()),
      birthTime: _birthTime.text,
      childOrder: int.parse(_childOrder.text.trim()),
      mother: _mother.keDataPenduduk(),
      father: _father.keDataPenduduk(),
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
          "Permohonan ini sekaligus sekaligus menjadi permintaan penyelesaian "
          "akta kelahiran. Formulir ${_type.labelLampiran} akan dilampirkan.",
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

  Future<void> _pickBirthTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );
    if (picked == null) return;
    final hour = picked.hour.toString().padLeft(2, '0');
    final minute = picked.minute.toString().padLeft(2, '0');
    setState(() => _birthTime.text = '$hour:$minute');
  }

  void _onBabyBirthDate(DateTime? value) {
    _baby.setBirthDate(value);
    if (value != null) {
      _birthDay.value = HitungUmur.formatHari(value);
    }
  }

  @override
  void dispose() {
    _baby.dispose();
    _mother.dispose();
    _father.dispose();
    _reporter.dispose();
    _witnessOne.dispose();
    _witnessTwo.dispose();
    _birthTime.dispose();
    _childOrder.dispose();
    _gender.dispose();
    _relationship.dispose();
    _birthDay.dispose();
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
                  "Data Bayi",
                  subtitle: "Nomor 1 sampai 5 pada Surat Keterangan Kelahiran",
                ),
                _BabyFields(
                  state: _baby,
                  childOrder: _childOrder,
                  birthTime: _birthTime,
                  validateChildOrder: _validateChildOrder,
                  pickBirthTime: _pickBirthTime,
                  onBirthDate: _onBabyBirthDate,
                ),
                const SizedBox(height: 8),
                const SectionHeader(
                  "Data Ibu",
                  subtitle: "Nomor 6 sampai 10 pada Surat Keterangan Kelahiran",
                ),
                KolomDataOrang(
                  state: _mother,
                  nikHint: "Contoh: 3306135507900001",
                ),
                const SizedBox(height: 8),
                const SectionHeader(
                  "Data Ayah",
                  subtitle:
                      "Nomor 11 sampai 15 pada Surat Keterangan Kelahiran",
                ),
                KolomDataOrang(
                  state: _father,
                  nikHint: "Contoh: 3306131205880002",
                ),
                const SizedBox(height: 8),
                const SectionHeader(
                  "Keterangan Pelapor",
                  subtitle:
                      "Nomor 16 sampai 21 pada Surat Keterangan Kelahiran",
                ),
                KolomDataOrang(state: _reporter, nikHint: "NIK pelapor"),
                const FieldLabel("Hubungan Pelapor dengan Bayi"),
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

class _BabyFields extends StatelessWidget {
  const _BabyFields({
    required this.state,
    required this.childOrder,
    required this.birthTime,
    required this.validateChildOrder,
    required this.pickBirthTime,
    required this.onBirthDate,
  });

  final DataOrangForm state;
  final TextEditingController childOrder;
  final TextEditingController birthTime;
  final FormFieldValidator<String> validateChildOrder;
  final VoidCallback pickBirthTime;
  final ValueChanged<DateTime?> onBirthDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel("Nama Lengkap Bayi"),
        KolomTeksSurat(
          label: "Nama yang akan dicatat",
          controller: state.name,
          validator: state.validateName,
        ),
        const FieldLabel("Jenis Kelamin"),
        KolomDropdownSurat<JenisKelamin>(
          label: "Jenis Kelamin",
          items: JenisKelamin.values,
          value: state.gender,
          validator: (v) => v == null ? "Jenis kelamin wajib dipilih" : null,
          itemBuilder: (_, item) =>
              Text(item.label, style: const TextStyle(fontSize: 14)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel("Tempat Lahir"),
                  KolomTeksSurat(
                    label: "Contoh: Purworejo",
                    controller: state.birthPlace,
                    validator: state.validateBirthPlace,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel("Tanggal Lahir"),
                  DateField(
                    controller: state.birthDate,
                    validator: state.validateBirthDate,
                    pickDate: () => _pickDate(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel("Pukul Lahir"),
                  TimeField(controller: birthTime, pickTime: pickBirthTime),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel("Anak Ke"),
                  KolomTeksSurat(
                    label: "1",
                    controller: childOrder,
                    validator: validateChildOrder,
                    isNumber: true,
                    maxLength: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.birthDateValue ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    if (picked != null) {
      onBirthDate(picked);
    }
  }
}
