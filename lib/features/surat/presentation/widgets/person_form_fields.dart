import 'package:desa_digital/features/surat/domain/entities/agama.dart';
import 'package:desa_digital/features/surat/domain/entities/data_penduduk.dart';
import 'package:desa_digital/features/surat/domain/entities/jenis_kelamin.dart';
import 'package:desa_digital/features/surat/domain/entities/pekerjaan.dart';
import 'package:desa_digital/features/surat/domain/entities/pendidikan.dart';
import 'package:desa_digital/features/surat/domain/entities/status_perkawinan.dart';
import 'package:desa_digital/features/surat/domain/entities/warga_negara.dart';
import 'package:desa_digital/features/surat/domain/utils/hitung_umur.dart';
import 'package:desa_digital/features/surat/domain/utils/validasi_nik.dart';
import 'package:desa_digital/features/surat/presentation/widgets/address_text_field.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kolom_dropdown_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kolom_teks_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/date_field.dart';
import 'package:desa_digital/features/surat/presentation/widgets/field_label.dart';
import 'package:flutter/material.dart';

class DataOrangForm {
  DataOrangForm({
    this.requireNik = true,
    this.requireBirthDate = true,
    this.withDataLanjut = true,
  });

  final bool requireNik;
  final bool requireBirthDate;
  final bool withDataLanjut;

  final nik = TextEditingController();
  final name = TextEditingController();
  final birthPlace = TextEditingController();
  final birthDate = TextEditingController();
  final address = TextEditingController();

  final gender = ValueNotifier<JenisKelamin?>(null);
  final religion = ValueNotifier<Agama?>(null);
  final maritalStatus = ValueNotifier<StatusPerkawinan?>(null);
  final education = ValueNotifier<Pendidikan?>(null);
  final occupation = ValueNotifier<Pekerjaan?>(null);
  final citizenship = ValueNotifier<WargaNegara?>(null);
  final age = ValueNotifier<String?>(null);

  DateTime? birthDateValue;

  void setBirthDate(DateTime? value) {
    birthDateValue = value;
    birthDate.text = value == null ? '' : HitungUmur.formatTanggal(value);
    age.value = value == null ? null : HitungUmur.formatTahunSejak(value);
  }

  String? validateNik(String? value) {
    if (!requireNik) return null;
    return ValidasiNik.validate(value);
  }

  String? validateName(String? value) {
    if ((value ?? '').trim().isEmpty) return 'Nama wajib diisi';
    return null;
  }

  String? validateBirthPlace(String? value) {
    if ((value ?? '').trim().isEmpty) return 'Tempat lahir wajib diisi';
    return null;
  }

  String? validateBirthDate(String? value) {
    if (!requireBirthDate) return null;
    if ((value ?? '').trim().isEmpty) return 'Tanggal lahir wajib diisi';
    if (birthDateValue == null) return 'Tanggal lahir tidak valid';
    if (birthDateValue!.isAfter(DateTime.now())) {
      return 'Tanggal lahir tidak boleh di masa depan';
    }
    return null;
  }

  String? validateGender(JenisKelamin? value) {
    if (value == null) return 'Jenis kelamin wajib dipilih';
    return null;
  }

  String? validateReligion(Agama? value) {
    if (value == null) return 'Agama wajib dipilih';
    return null;
  }

  String? validateMaritalStatus(StatusPerkawinan? value) {
    if (value == null) return 'Status perkawinan wajib dipilih';
    return null;
  }

  String? validateEducation(Pendidikan? value) {
    if (value == null) return 'Pendidikan wajib dipilih';
    return null;
  }

  String? validateOccupation(Pekerjaan? value) {
    if (value == null) return 'Pekerjaan wajib dipilih';
    return null;
  }

  String? validateCitizenship(WargaNegara? value) {
    if (value == null) return 'Kewarganegaraan wajib dipilih';
    return null;
  }

  String? validateAddress(String? value) {
    if ((value ?? '').trim().isEmpty) return 'Alamat wajib diisi';
    return null;
  }

  DataPenduduk keDataPenduduk() => DataPenduduk(
    nik: nik.text.trim().isEmpty ? null : nik.text.trim(),
    name: name.text.trim().isEmpty ? null : name.text.trim(),
    birthPlace: birthPlace.text.trim().isEmpty ? null : birthPlace.text.trim(),
    birthDate: birthDateValue,
    gender: gender.value,
    occupation: occupation.value,
    address: address.text.trim().isEmpty ? null : address.text.trim(),
  );

  Map<String, dynamic> keMap() => {
    ...keDataPenduduk().toMap(),
    'agama': religion.value?.label,
    'status_perkawinan': maritalStatus.value?.label,
    'pendidikan': education.value?.label,
    'kewarganegaraan': citizenship.value?.label,
  };

  void dispose() {
    nik.dispose();
    name.dispose();
    birthPlace.dispose();
    birthDate.dispose();
    address.dispose();
    gender.dispose();
    religion.dispose();
    maritalStatus.dispose();
    education.dispose();
    occupation.dispose();
    citizenship.dispose();
    age.dispose();
  }
}

class KolomDataOrang extends StatelessWidget {
  const KolomDataOrang({
    super.key,
    required this.state,
    required this.nikHint,
    this.showAddress = true,
    this.showBirthPlace = true,
  });

  final DataOrangForm state;
  final String nikHint;
  final bool showAddress;
  final bool showBirthPlace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel("NIK"),
        KolomTeksSurat(
          label: nikHint,
          controller: state.nik,
          validator: state.validateNik,
          isNumber: true,
          maxLength: ValidasiNik.length,
        ),
        const FieldLabel("Nama Lengkap"),
        KolomTeksSurat(
          label: "Nama Lengkap",
          controller: state.name,
          validator: state.validateName,
        ),
        if (showBirthPlace)
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
                    FieldLabel(
                      state.requireBirthDate
                          ? "Tanggal Lahir"
                          : "Tanggal Lahir (opsional)",
                    ),
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
        if (state.requireBirthDate)
          ValueListenableBuilder<String?>(
            valueListenable: state.age,
            builder: (context, value, _) => Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  'Umur: ${value ?? '-'} tahun',
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ),
            ),
          ),
        const FieldLabel("Jenis Kelamin"),
        KolomDropdownSurat<JenisKelamin>(
          label: "Jenis Kelamin",
          items: JenisKelamin.values,
          value: state.gender,
          validator: state.validateGender,
          itemBuilder: (_, item) => Text(
            item.label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        const FieldLabel("Agama"),
        KolomDropdownSurat<Agama>(
          label: "Agama",
          items: Agama.values,
          value: state.religion,
          validator: state.validateReligion,
          itemBuilder: (_, item) => Text(
            item.label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        if (state.withDataLanjut) ...[
          const FieldLabel("Status Perkawinan"),
          KolomDropdownSurat<StatusPerkawinan>(
            label: "Status Perkawinan",
            items: StatusPerkawinan.values,
            value: state.maritalStatus,
            validator: state.validateMaritalStatus,
            itemBuilder: (_, item) => Text(
              item.label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          const FieldLabel("Pendidikan Terakhir"),
          KolomDropdownSurat<Pendidikan>(
            label: "Pendidikan",
            items: Pendidikan.values,
            value: state.education,
            validator: state.validateEducation,
            itemBuilder: (_, item) => Text(
              item.label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
        const FieldLabel("Pekerjaan"),
        KolomDropdownSurat<Pekerjaan>(
          label: "Pekerjaan",
          items: Pekerjaan.values,
          value: state.occupation,
          validator: state.validateOccupation,
          itemBuilder: (_, item) => Text(
            item.label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        const FieldLabel("Kewarganegaraan"),
        KolomDropdownSurat<WargaNegara>(
          label: "Kewarganegaraan",
          items: WargaNegara.values,
          value: state.citizenship,
          validator: state.validateCitizenship,
          itemBuilder: (_, item) => Text(
            item.label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        if (showAddress) ...[
          const FieldLabel("Alamat / Tempat Tinggal"),
          AddressTextField(
            hint:
                "Contoh: Dukuh Krajan RT003 RW001, "
                "Desa Gunung Condong, Kecamatan Bruno",
            controller: state.address,
            validator: state.validateAddress,
          ),
        ],
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.birthDateValue ?? now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      state.setBirthDate(picked);
    }
  }
}
