import 'package:desa_digital/features/agenda/domain/entities/jenis_agenda.dart';

class EventAgenda {
  const EventAgenda({
    required this.title,
    required this.image,
    required this.date,
    required this.lokasi,
    required this.penyelenggara,
    required this.deskripsi,
    this.jenis = JenisAgenda.lainnya,
  });

  final String title;
  final String image;
  final String date;
  final String lokasi;
  final String penyelenggara;
  final String deskripsi;
  final JenisAgenda jenis;
}
