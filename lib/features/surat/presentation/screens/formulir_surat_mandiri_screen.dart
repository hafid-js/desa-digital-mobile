import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/surat/presentation/controllers/surat_controller.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';
import 'package:desa_digital/features/surat/domain/utils/hitung_umur.dart';
import 'package:desa_digital/features/surat/presentation/widgets/address_text_field.dart';
import 'package:desa_digital/features/surat/presentation/widgets/date_field.dart';
import 'package:desa_digital/features/surat/presentation/widgets/field_label.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kartu_meta_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/konfirmasi_pemohon.dart';
import 'package:desa_digital/features/surat/presentation/widgets/kolom_teks_surat.dart';
import 'package:desa_digital/features/surat/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _GrupIsian {
  const _GrupIsian(this.kunci, this.fields);

  final String kunci;
  final List<FieldSurat> fields;
}

class FormulirSuratMandiriScreen extends StatefulWidget {
  const FormulirSuratMandiriScreen({super.key, required this.surat});

  final SuratMandiri surat;

  @override
  State<FormulirSuratMandiriScreen> createState() =>
      _FormulirSuratMandiriScreenState();
}

class _FormulirSuratMandiriScreenState
    extends State<FormulirSuratMandiriScreen> {
  final _formKey = GlobalKey<FormState>();
  final _berlakuDari = TextEditingController();

  SuratController get _surat => Get.find<SuratController>();

  Penduduk? _profil;
  bool _memuatProfil = true;
  bool _memuatGagal = false;
  bool _mengirim = false;
  DateTime? _tanggalBerlakuDari;
  DateTime? _tanggalBerlakuSampai;

  final Map<String, TextEditingController> _teks = {};
  final Map<String, String?> _opsi = {};
  final Map<String, DateTime?> _tanggal = {};
  late List<_GrupIsian> _grup;

  @override
  void initState() {
    super.initState();
    _siapkanGrup();
    _muatProfil();
  }

  @override
  void didUpdateWidget(covariant FormulirSuratMandiriScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.surat.code == widget.surat.code) return;
    _buangController();
    _tanggalBerlakuDari = null;
    _tanggalBerlakuSampai = null;
    _berlakuDari.clear();
    _siapkanGrup();
  }

  Future<void> _muatProfil() async {
    setState(() {
      _memuatProfil = true;
      _memuatGagal = false;
    });
    try {
      final profil = await _surat.muatProfilAktif();
      if (!mounted) return;
      setState(() {
        _profil = profil;
        _memuatProfil = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _memuatProfil = false;
        _memuatGagal = true;
      });
    }
  }

  List<_GrupIsian> _daftarGrup(SuratMandiri surat) => [
    if (surat.fields.isNotEmpty) _GrupIsian('isian', surat.fields),
    if (surat.butuhIdentitasKedua)
      _GrupIsian('identitas_kedua', surat.fieldsIdentitasKedua),
  ];

  void _siapkanGrup() {
    _grup = _daftarGrup(widget.surat);
    for (final grup in _grup) {
      for (var i = 0; i < grup.fields.length; i++) {
        final field = grup.fields[i];
        final kunci = _kunci(grup.kunci, i);
        if (field.tipe == TipeFieldSurat.opsi) {
          _opsi[kunci] = null;
        } else {
          _teks[kunci] = TextEditingController();
          if (field.tipe == TipeFieldSurat.tanggal) {
            _tanggal[kunci] = null;
          }
        }
      }
    }
  }

  void _buangController() {
    for (final controller in _teks.values) {
      controller.dispose();
    }
    _teks.clear();
    _opsi.clear();
    _tanggal.clear();
  }

  String _kunci(String grup, int index) => '$grup#$index';

  @override
  void dispose() {
    _buangController();
    _berlakuDari.dispose();
    super.dispose();
  }

  String? _validateTeks(FieldSurat field, String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) {
      return field.wajib ? '${field.label} wajib diisi' : null;
    }
    return null;
  }

  String? _validateTanggal(FieldSurat field, DateTime? value) {
    if (value == null) {
      return field.wajib ? '${field.label} wajib diisi' : null;
    }
    return null;
  }

  String? _validateOpsi(FieldSurat field, String? value) {
    if (value == null || value.isEmpty) {
      return field.wajib ? '${field.label} wajib dipilih' : null;
    }
    return null;
  }

  Future<void> _pilihTanggalIsian(String kunci, FieldSurat field) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal[kunci] ?? now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _tanggal[kunci] = picked;
        _teks[kunci]!.text = HitungUmur.formatTanggal(picked);
      });
    }
  }

  Future<void> _pilihBerlakuDari() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalBerlakuDari ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 1),
    );
    if (picked == null) return;
    setState(() {
      _tanggalBerlakuDari = picked;
      _tanggalBerlakuSampai = DateTime(
        picked.year,
        picked.month + widget.surat.masaBerlakuBulan,
        picked.day,
      );
      _berlakuDari.text = HitungUmur.formatTanggal(picked);
    });
  }

  Map<String, dynamic> _kumpulkanIsian(_GrupIsian grup) {
    final hasil = <String, dynamic>{};
    for (var i = 0; i < grup.fields.length; i++) {
      final field = grup.fields[i];
      final kunci = _kunci(grup.kunci, i);
      if (field.tipe == TipeFieldSurat.opsi) {
        hasil[field.label] = _opsi[kunci];
      } else if (field.tipe == TipeFieldSurat.tanggal) {
        hasil[field.label] = _tanggal[kunci]?.toIso8601String();
      } else {
        hasil[field.label] = _teks[kunci]!.text.trim();
      }
    }
    return hasil;
  }

  Future<void> _submit() async {
    final profil = _profil;
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid || profil == null) return;

    final isian = <String, dynamic>{};
    Map<String, dynamic>? identitasKedua;
    for (final grup in _grup) {
      final hasil = _kumpulkanIsian(grup);
      if (grup.kunci == 'identitas_kedua') {
        identitasKedua = hasil;
      } else {
        isian.addAll(hasil);
      }
    }

    final data = <String, dynamic>{
      'kode_surat': widget.surat.code,
      'nama_surat': widget.surat.title,
      'mandiri': true,
      'penduduk_id': profil.id,
      'nik': profil.nik,
      'identitas_kedua': ?identitasKedua,
      'isian_surat': isian,
      'berlaku_dari': _tanggalBerlakuDari?.toIso8601String(),
      'berlaku_sampai': _tanggalBerlakuSampai?.toIso8601String(),
    };

    setState(() => _mengirim = true);
    try {
      await _surat.kirim(data);
    } finally {
      if (mounted) setState(() => _mengirim = false);
    }

    if (!mounted) return;
    _tampilkanBerhasil();
  }

  void _tampilkanBerhasil() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Data Tersimpan"),
        content: Text(
          "Pengisian ${widget.surat.title} dengan kode ${widget.surat.code} "
          "atas nama ${_profil!.nama} telah disimpan.\n\n"
          "Surat ini termasuk layanan mandiri, sehingga warga dapat "
          "menghasilkannya tanpa diproses perangkat desa. "
          "Surat berlaku ${widget.surat.masaBerlakuBulan} bulan "
          "sejak diterbitkan.",
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

  @override
  Widget build(BuildContext context) {
    final surat = widget.surat;

    return Scaffold(
      appBar: AppBar(
        title: Text(surat.title, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KartuMetaSurat.mandiri(surat: surat),
                const SectionHeader(
                  "Keterangan Pemohon",
                  subtitle: "Data sesuai akun Anda dan tidak dapat diubah",
                ),
                _blokPemohon(),
                for (final grup in _grup) ...[
                  const SizedBox(height: 8),
                  SectionHeader(
                    grup.kunci == 'identitas_kedua'
                        ? "Identitas Kedua"
                        : surat.title,
                    subtitle: grup.kunci == 'identitas_kedua'
                        ? "Diisi manual karena bukan data penduduk desa"
                        : "Lengkapi isian surat berikut",
                  ),
                  for (var i = 0; i < grup.fields.length; i++)
                    ..._buildField(grup, grup.fields[i], i),
                ],
                if (surat.masaBerlakuBulan > 0) ...[
                  const SizedBox(height: 8),
                  const SectionHeader("Masa Berlaku"),
                  const FieldLabel("Berlaku Dari"),
                  DateField(
                    controller: _berlakuDari,
                    pickDate: _pilihBerlakuDari,
                    hint: 'Pilih tanggal',
                  ),
                  const FieldLabel("Berlaku Sampai"),
                  _readOnlyTanggal(_tanggalBerlakuSampai),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _mengirim ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withValues(
                        alpha: 0.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _mengirim
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Simpan",
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(color: Colors.white),
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

  Widget _blokPemohon() {
    if (_memuatProfil) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (_memuatGagal || _profil == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            const Text(
              'Data pemohon tidak dapat dimuat',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            TextButton(onPressed: _muatProfil, child: const Text('Coba lagi')),
          ],
        ),
      );
    }

    return KonfirmasiPemohon(penduduk: _profil!);
  }

  Widget _readOnlyTanggal(DateTime? value) => Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.black12),
    ),
    child: Text(
      value == null ? '-' : HitungUmur.formatTanggal(value),
      style: const TextStyle(fontSize: 14, color: Colors.black45),
    ),
  );

  List<Widget> _buildField(_GrupIsian grup, FieldSurat field, int index) {
    final kunci = _kunci(grup.kunci, index);
    final label = field.wajib ? field.label : "${field.label} (opsional)";

    if (field.tipe == TipeFieldSurat.tanggal) {
      final value = _tanggal[kunci];
      return [
        FieldLabel(label),
        DateField(
          controller: _teks[kunci]!,
          validator: (_) => _validateTanggal(field, value),
          pickDate: () => _pilihTanggalIsian(kunci, field),
        ),
      ];
    }

    if (field.tipe == TipeFieldSurat.opsi) {
      return [
        FieldLabel(label),
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: DropdownButtonFormField<String>(
            initialValue: _opsi[kunci],
            hint: Text(field.hint),
            isExpanded: true,
            borderRadius: BorderRadius.circular(20),
            style: const TextStyle(fontSize: 14, color: Colors.black),
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            items: [
              for (final item in field.pilihan)
                DropdownMenuItem(value: item, child: Text(item)),
            ],
            onChanged: (value) => setState(() => _opsi[kunci] = value),
            validator: (value) => _validateOpsi(field, value),
          ),
        ),
      ];
    }

    if (field.tipe == TipeFieldSurat.teksArea) {
      return [
        FieldLabel(label),
        AddressTextField(
          hint: field.hint,
          controller: _teks[kunci]!,
          validator: (value) => _validateTeks(field, value),
        ),
      ];
    }

    return [
      FieldLabel(label),
      KolomTeksSurat(
        label: field.hint,
        controller: _teks[kunci]!,
        validator: (value) => _validateTeks(field, value),
      ),
    ];
  }
}
