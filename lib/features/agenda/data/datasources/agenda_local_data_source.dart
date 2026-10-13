import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';

abstract interface class AgendaDataSource {
  List<EventAgenda> eventsOn(DateTime day);
}

class AgendaLocalDataSource implements AgendaDataSource {
  const AgendaLocalDataSource();

  @override
  List<EventAgenda> eventsOn(DateTime day) =>
      eventsData[DateTime.utc(day.year, day.month, day.day)] ?? const [];
}

const EventAgenda _tazkia = EventAgenda(
  title: 'Kampung Ramadhan Tazkia 1447 H',
  image: AppAssets.event1,
  date: '01-28 Februari 2026',
  lokasi: 'Halaman Masjid Agung Desa',
  penyelenggara: 'Takmir Masjid Agung Desa',
  deskripsi:
      'Kampung Ramadhan Tazkia dibuka selama sebulan penuh di halaman Masjid Agung '
      'Desa. Setiap malam diisi kajian, mengaji anak-anak, dan bazar.',
);

const EventAgenda _umkm = EventAgenda(
  title: 'Festival UMKM Jateng 2026',
  image: AppAssets.event2,
  date: '05-20 Februari 2026',
  lokasi: 'Lapangan Serbaguna Desa',
  penyelenggara: 'Dinas Koperasi dan UMKM',
  deskripsi:
      'Festival UMKM menampilkan produk khas dari pelaku usaha rumahan warga '
      'desa. Stan buka setiap hari pukul 09.00 sampai 21.00 WIB.',
);

const EventAgenda _tabligh = EventAgenda(
  title: 'Tabligh Akbar Bersama Para tokoh Nasional.',
  image: AppAssets.event3,
  date: '25 Februari 2026',
  lokasi: 'Lapangan Serbaguna Desa',
  penyelenggara: 'Majelis Taklim Desa',
  deskripsi:
      'Tabligh Akbar dipandu tokoh nasional bertema menjaga persatuan dan '
      'ketenteraman. Kegiatan terbuka untuk warga desa.',
);

const EventAgenda _takjil = EventAgenda(
  title: 'Rame Rame Gelaran Takjil',
  image: AppAssets.event4,
  date: '25 Februari 2026',
  lokasi: 'Halaman Masjid Agung Desa',
  penyelenggara: 'Karang Taruna Desa',
  deskripsi:
      'Gelaran takjil hidangan dari warga desa. Warga bergantian menyiapkan '
      'hidangan setelah magrib.',
);

const EventAgenda _jalanSehat = EventAgenda(
  title: 'Jalan Sehat Desa Gunung Condong',
  image: AppAssets.event5,
  date: '25 Februari 2026',
  lokasi: 'Titik awal Pasar Desa',
  penyelenggara: 'KNID Desa bersama warga desa',
  deskripsi:
      'Jalan Sehat desa dimulai dari Pasar Desa. Rute garantizando kembali ke '
      'titik awal.',
);

final Map<DateTime, List<EventAgenda>> eventsData = {
  DateTime.utc(2026, 9, 17): [_tazkia, _umkm],
  DateTime.utc(2026, 10, 2): [_tabligh, _takjil, _jalanSehat, _jalanSehat],
};
