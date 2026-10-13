import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/profil/domain/entities/jenis_kelamin.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalDataForm extends StatelessWidget {
  final TextEditingController dateController;
  final VoidCallback pickDate;
  final JenisKelamin? selectedGender;
  final ValueChanged<JenisKelamin?> onGenderChanged;
  final List<String> religionItems;
  final List<String> marriedStatus;
  final List<String> provinsiItems;
  final List<String> kabupatenItems;
  final List<String> kecamatanItems;
  final List<String> kelurahanItems;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final Map<String, ValueNotifier<String?>> dropdownValues;
  final VoidCallback onSimpan;

  const PersonalDataForm({
    super.key,
    required this.onSimpan,
    required this.dateController,
    required this.pickDate,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.religionItems,
    required this.marriedStatus,
    required this.provinsiItems,
    required this.kabupatenItems,
    required this.kecamatanItems,
    required this.kelurahanItems,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.dropdownValues,
  });

  Widget _buildTextField({
    required String label,
    bool isNumber = false,
    bool isReadOnly = false,
    int? maxLength,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        enabled: !isReadOnly,
        keyboardType: isNumber ? TextInputType.number : null,
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        maxLength: maxLength,
        style: isReadOnly
            ? TextStyle(color: Colors.black87, fontSize: 14)
            : null,
        decoration: InputDecoration(
          floatingLabelBehavior: isReadOnly
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
          floatingLabelStyle: TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 12,
          ),

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.textSecondaryLight,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: isReadOnly ? AppColors.textSecondaryLight : AppColors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: isReadOnly ? AppColors.grey : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  ValueNotifier<String?> _dropdownValue(String label) {
    return dropdownValues.putIfAbsent(
      label,
      () => ValueNotifier<String?>(null),
    );
  }

  Widget _buildDropdown({required String label, required List<String> items}) {
    final value = _dropdownValue(label);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        valueListenable: value,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
        ),
        hint: Text(
          'Pilih $label',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryLight,
          ),
        ),
        items: items
            .map(
              (item) => DropdownItem(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            )
            .toList(),
        onChanged: (v) => value.value = v,
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Jenis Kelamin",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _genderRadio(
                label: "Laki-Laki",
                value: JenisKelamin.male,
                groupValue: selectedGender,
                onChanged: onGenderChanged,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _genderRadio(
                label: "Perempuan",
                value: JenisKelamin.female,
                groupValue: selectedGender,
                onChanged: onGenderChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _genderRadio({
    required String label,
    required JenisKelamin value,
    required JenisKelamin? groupValue,
    required ValueChanged<JenisKelamin?> onChanged,
  }) {
    final isSelected = value == groupValue;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.grey,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onChanged(value),
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<JenisKelamin>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                fillColor: WidgetStateProperty.resolveWith(
                  (states) => states.contains(WidgetState.selected)
                      ? AppColors.primary
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Data Diri", style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 10),
        _buildTextField(
          label: "Email",
          isReadOnly: true,
          controller: emailController,
        ),
        _buildTextField(
          label: "Nama Lengkap",
          isReadOnly: true,
          controller: fullNameController,
        ),
        _buildTextField(
          label: "Nomor Whatsapp",
          isReadOnly: true,
          controller: phoneController,
        ),
        _buildTextField(label: "NIK", isNumber: true, maxLength: 16),
        Text(
          "Tempat Lahir",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        SizedBox(height: 8),
        _buildTextField(label: ""),
        Text(
          "Tanggal Lahir",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: TextFormField(
            controller: dateController,
            readOnly: true,
            onTap: pickDate,
            decoration: InputDecoration(
              labelText: "-",
              labelStyle: TextStyle(fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        _buildGenderSelector(),
        _buildDropdown(label: "Agama", items: religionItems),
        _buildDropdown(label: "Status Perkawinan", items: marriedStatus),
        Text("Alamat", style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 10),
        _buildDropdown(label: "Provinsi", items: provinsiItems),
        _buildDropdown(label: "Kabupaten/Kota", items: kabupatenItems),
        _buildDropdown(label: "Kecamatan", items: kecamatanItems),
        _buildDropdown(label: "Kelurahan/Desa", items: kelurahanItems),
        TextFormField(
          maxLines: 10,
          minLines: 8,
          decoration: InputDecoration(
            labelText: "Alamat Lengkap",
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            hintText: "Masukkan alamat lengkap, contoh : Jl. Wangsajaya No.9",
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondaryLight,
            ),
            alignLabelWithHint: false,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.grey, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: onSimpan,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.primary,
            elevation: 0,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Simpan",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
