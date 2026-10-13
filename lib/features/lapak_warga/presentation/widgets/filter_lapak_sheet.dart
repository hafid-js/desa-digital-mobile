import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/theme/app_text_theme.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/filter_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/urutan.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_chip.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/tombol_terapkan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FilterLapakSheet extends StatefulWidget {
  const FilterLapakSheet({
    super.key,
    required this.kategori,
    required this.lokasi,
    required this.awal,
    required this.penawaran,
    required this.kondisi,
    required this.terakhirDitambahkan,
    required this.ketersediaan,
    required this.urutan,
  });

  final List<String> kategori;
  final List<String> lokasi;
  final List<String> penawaran;
  final List<String> kondisi;
  final List<String> terakhirDitambahkan;
  final List<String> ketersediaan;
  final FilterLapak awal;
  final Urutan urutan;

  @override
  State<FilterLapakSheet> createState() => _FilterLapakSheetState();
}

class _FilterLapakSheetState extends State<FilterLapakSheet> {
  late Set<String> _kategori;
  late Set<String> _lokasi;
  late Set<String> _penawaran;
  late Set<String> _kondisi;
  late Set<String> _terakhirDitambahkan;
  late Set<String> _ketersediaan;
  late int? _hargaMinimum;
  late int? _hargaMaksimum;
  late Urutan _urutan;

  final TextEditingController _hargaMinController = TextEditingController();
  final TextEditingController _hargaMaxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _kategori = {...widget.awal.kategori};
    _lokasi = {...widget.awal.lokasi};
    _kondisi = {...widget.awal.kondisi};
    _terakhirDitambahkan = {...widget.awal.terakhirDitambahkan};
    _ketersediaan = {...widget.awal.ketersediaan};
    _penawaran = {...widget.awal.penawaran};
    _hargaMinimum = widget.awal.hargaMinimum;
    _hargaMaksimum = widget.awal.hargaMaksimum;
    _urutan = widget.urutan;
    _hargaMinController.text = _hargaMinimum?.toString() ?? '';
    _hargaMaxController.text = _hargaMaksimum?.toString() ?? '';
  }

  @override
  void dispose() {
    _hargaMinController.dispose();
    _hargaMaxController.dispose();
    super.dispose();
  }

  int? _parseHarga(String value) {
    final bersih = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (bersih.isEmpty) return null;
    return int.tryParse(bersih);
  }

  FilterLapak hasil() {
    return FilterLapak(
      kategori: _kategori,
      hargaMinimum: _hargaMinimum,
      hargaMaksimum: _hargaMaksimum,
      lokasi: _lokasi,
      penawaran: _penawaran,
      kondisi: _kondisi,
      terakhirDitambahkan: _terakhirDitambahkan,
      ketersediaan: _ketersediaan,
    );
  }

  void _terapkan() {
    Navigator.pop(context, (hasil(), _urutan));
  }

  void _resetSemua() {
    setState(() {
      _kategori = {};
      _lokasi = {};
      _penawaran = {};
      _kondisi = {};
      _terakhirDitambahkan = {};
      _ketersediaan = {};
      _hargaMinimum = null;
      _hargaMaksimum = null;
      _urutan = Urutan.palingSesuai;
      _hargaMinController.clear();
      _hargaMaxController.clear();
    });
  }

  void _toggle(Set<String> target, String nilai) {
    setState(() {
      if (!target.remove(nilai)) target.add(nilai);
    });
  }

  Widget _bagian(String label, Widget isi, {bool denganSpasiBawah = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Label(label),
        (label == "Urutkan")
            ? const SizedBox(height: 10)
            : const SizedBox(height: 15),
        isi,
        if (denganSpasiBawah) const SizedBox(height: 15),
      ],
    );
  }

  Widget _grupChip({
    required List<String> opsi,
    required Set<String> terpilih,
    required Set<String> Function() target,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final item in opsi)
          LapakChip(
            label: item,
            aktif: terpilih.contains(item),
            onTap: () => _toggle(target(), item),
          ),
      ],
    );
  }

  Widget _rentangHarga() {
    return Row(
      children: [
        Expanded(
          child: _InputHarga(
            controller: _hargaMinController,
            hint: "Harga terendah",
            onChanged: (value) => _hargaMinimum = _parseHarga(value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "—",
            style: TextStyle(color: AppColors.grey.withAlpha(180)),
          ),
        ),
        Expanded(
          child: _InputHarga(
            controller: _hargaMaxController,
            hint: "Harga tertinggi",
            onChanged: (value) => _hargaMaksimum = _parseHarga(value),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.5, 0.9],
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              _Header(
                judul: "Filter",
                onReset: _resetSemua,
                onTutup: () => Navigator.pop(context),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  children: [
                    _bagian(
                      "Urutkan",
                      RadioGroup<Urutan>(
                        groupValue: _urutan,
                        onChanged: (Urutan? value) {
                          if (value == null) return;
                          setState(() => _urutan = value);
                        },
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _BarisUrutkan(
                              title: "Paling Sesuai",
                              nilai: Urutan.palingSesuai,
                            ),
                            _BarisUrutkan(
                              title: "Terbaru",
                              nilai: Urutan.terbaru,
                            ),
                            _BarisUrutkan(
                              title: "Harga Tertinggi",
                              nilai: Urutan.hargaTertinggi,
                            ),
                            _BarisUrutkan(
                              title: "Harga Terendah",
                              nilai: Urutan.hargaTerendah,
                            ),
                          ],
                        ),
                      ),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Lokasi",
                      _grupChip(
                        opsi: widget.lokasi,
                        terpilih: _lokasi,
                        target: () => _lokasi,
                      ),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Kategori",
                      _grupChip(
                        opsi: widget.kategori,
                        terpilih: _kategori,
                        target: () => _kategori,
                      ),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Rentang Harga",
                      _rentangHarga(),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Penawaran",
                      _grupChip(
                        opsi: widget.penawaran,
                        terpilih: _penawaran,
                        target: () => _penawaran,
                      ),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Kondisi",
                      _grupChip(
                        opsi: widget.kondisi,
                        terpilih: _kondisi,
                        target: () => _kondisi,
                      ),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Terakhir Ditambahkan",
                      _grupChip(
                        opsi: widget.terakhirDitambahkan,
                        terpilih: _terakhirDitambahkan,
                        target: () => _terakhirDitambahkan,
                      ),
                      denganSpasiBawah: true,
                    ),
                    _bagian(
                      "Lainnya",
                      _grupChip(
                        opsi: widget.ketersediaan,
                        terpilih: _ketersediaan,
                        target: () => _ketersediaan,
                      ),
                    ),
                  ],
                ),
              ),
              TombolTerapkan(onTap: _terapkan, label: "Tampilkan Produk"),
            ],
          ),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.teks);

  final String teks;

  @override
  Widget build(BuildContext context) {
    return Text(
      teks,
      style: AppTextTheme.lightTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _InputHarga extends StatelessWidget {
  const _InputHarga({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.grey.withAlpha(50),
        hintStyle: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondaryLight,
          fontWeight: FontWeight.w300,
        ),
        isDense: true,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 6),
            child: Center(
              child: Text(
                "Rp.",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.judul,
    required this.onReset,
    required this.onTutup,
  });

  final String judul;
  final VoidCallback onReset;
  final VoidCallback onTutup;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onTutup,
            icon: Icon(
              LucideIcons.x,
              size: 25,
              // color: Colors.grey,
            ),
          ),
          Text(
            judul,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          TextButton(
            onPressed: onReset,
            child: const Text(
              "Reset",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarisUrutkan extends StatelessWidget {
  const _BarisUrutkan({required this.title, required this.nilai});

  final String title;
  final Urutan nilai;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final group = RadioGroup.maybeOf<Urutan>(context);

        group?.onChanged(nilai);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(color: Colors.black),
          ),
          Radio<Urutan>(value: nilai, visualDensity: VisualDensity.compact),
        ],
      ),
    );
  }
}
