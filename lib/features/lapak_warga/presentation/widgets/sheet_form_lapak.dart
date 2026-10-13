import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/widgets/rounded_image.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/header_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SheetFormLapak extends StatefulWidget {
  const SheetFormLapak({
    super.key,
    required this.judul,
    required this.kategori,
    required this.kondisi,
    required this.lokasi,
    required this.scrollController,
    this.tampilkanInfoPenjual = false,
  });

  final String judul;
  final List<String> kategori;
  final List<String> kondisi;
  final List<String> lokasi;
  final ScrollController scrollController;
  final bool tampilkanInfoPenjual;

  @override
  State<SheetFormLapak> createState() => _SheetFormLapakState();
}

class _SheetFormLapakState extends State<SheetFormLapak> {
  final ValueNotifier<String?> _kategoriTerpilih = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _kondisiTerpilih = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _lokasiTerpilih = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _lokasiTerpilih.value = widget.lokasi.isEmpty ? null : widget.lokasi.first;
  }

  @override
  void dispose() {
    _kategoriTerpilih.dispose();
    _kondisiTerpilih.dispose();
    _lokasiTerpilih.dispose();
    super.dispose();
  }

  InputDecoration _dekorasiField({
    required String label,
    required Color floatingLabelColor,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      floatingLabelStyle: TextStyle(color: floatingLabelColor, fontSize: 12),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.textSecondaryLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.primary),
      ),
    );
  }

  Widget _dropdown({
    required ValueNotifier<String?> value,
    required List<String> items,
    required String hint,
  }) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      valueListenable: value,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        floatingLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
      hint: Text(
        hint,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      items: items
          .map(
            (item) => DropdownItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (v) => value.value = v,
    );
  }

  Widget _dropdownLokasi() {
    return ValueListenableBuilder<String?>(
      valueListenable: _lokasiTerpilih,
      builder: (context, value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Lokasi", style: Theme.of(context).textTheme.titleLarge),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                value: value,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: AppColors.primary,
                ),
                items: widget.lokasi
                    .map(
                      (dusun) => DropdownMenuItem(
                        value: dusun,
                        child: Text(
                          dusun,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (v) => _lokasiTerpilih.value = v,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _infoPenjual() {
    return Row(
      children: [
        const AppRoundedImage(
          imageUrl: "assets/images/user-profile.jpg",
          height: 45,
          width: 45,
          fit: BoxFit.cover,
          borderRadius: 30,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unknown",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  Text(
                    "Jual di Marketplace Desa",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontSize: 10),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 2,
                    height: 2,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.store_mall_directory_rounded,
                    color: Colors.black54,
                    size: 13,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tambahFoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.grey.withAlpha(120),
                child: const Icon(
                  Icons.my_library_add_outlined,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Tambah foto",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Foto: 0/10",
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(fontSize: 10),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: 2,
              height: 2,
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              "Pilih foto utama jualanmu terlebih dahulu",
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fieldDeskripsi() {
    return TextFormField(
      maxLines: 10,
      minLines: 8,
      decoration: InputDecoration(
        hintText: "Tulis Deskripsi Produk",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary.withAlpha(120),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.grey.withAlpha(120),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          HeaderSheet(
            judul: widget.judul,
            showReset: true,
            publish: true,
            onReset: () {},
            onPublish: () {},
            onTutup: () => Navigator.pop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.tampilkanInfoPenjual) _infoPenjual(),
                  _tambahFoto(),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    decoration: _dekorasiField(
                      label: "Nama Produk",
                      floatingLabelColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    decoration: _dekorasiField(
                      label: "Harga",
                      floatingLabelColor: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _dropdown(
                    value: _kategoriTerpilih,
                    items: widget.kategori,
                    hint: 'Pilih kategori produk',
                  ),
                  const SizedBox(height: 10),
                  _dropdown(
                    value: _kondisiTerpilih,
                    items: widget.kondisi,
                    hint: 'Pilih kondisi produk',
                  ),
                  const SizedBox(height: 10),
                  _fieldDeskripsi(),
                  const SizedBox(height: 10),
                  _dropdownLokasi(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
