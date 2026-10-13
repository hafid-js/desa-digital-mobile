import 'package:desa_digital/features/pengaduan/presentation/widgets/attachment_picker_section.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/privacy_option_card.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/report_details_field.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/submit_section.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/location_point_field.dart';
import 'package:desa_digital/features/pengaduan/presentation/widgets/bagian_pemilih_wilayah.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

export 'package:desa_digital/features/pengaduan/presentation/widgets/privacy_option_card.dart'
    show ComplaintVisibility;

class FormulirPengaduanScreen extends StatefulWidget {
  const FormulirPengaduanScreen({super.key});

  @override
  State<FormulirPengaduanScreen> createState() =>
      _FormulirPengaduanScreenState();
}

class _FormulirPengaduanScreenState extends State<FormulirPengaduanScreen> {
  PlatformFile? selectedPdf;
  PlatformFile? selectedVideo;
  XFile? selectedPhoto;
  ComplaintVisibility? _selected = ComplaintVisibility.private;
  String? selectedRegion;
  Map<String, dynamic>? selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Isi Laporan",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AttachmentPickerSection(
                onLampiranSelesai: (aksi) {
                  setState(() {
                    selectedPdf = null;
                    selectedPhoto = null;
                  });
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          aksi == "hapus"
                              ? "Lampiran dihapus dari laporan"
                              : "Pilih ulang lampiran di form laporan",
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                },
                onPdfPicked: (file) {
                  setState(() {
                    selectedPdf = file;
                  });
                },
                onVideoPicked: (file) {
                  setState(() {
                    selectedVideo = file;
                  });
                },
                onPhotoPicked: (image) {
                  setState(() {
                    selectedPhoto = image;
                  });
                },
              ),
              SizedBox(height: 20),
              BagianPemilihWilayah(
                selectedRegion: selectedRegion,
                onRegionSelected: (region) {
                  setState(() {
                    selectedRegion = region;
                  });
                },
              ),
              SizedBox(height: 10),
              LocationPointField(
                onLocationPicked: (lokasi) {
                  setState(() {
                    selectedLocation = lokasi;
                  });
                },
              ),
              SizedBox(height: 20),
              ReportDetailsField(),
              SizedBox(height: 20),
              PrivacyOptionCard(
                selected: _selected,
                onChanged: (value) {
                  setState(() {
                    _selected = value;
                  });
                },
              ),
              SubmitSection(),
            ],
          ),
        ),
      ),
    );
  }
}
