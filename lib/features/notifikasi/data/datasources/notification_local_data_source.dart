import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_preference.dart';

abstract interface class NotificationDataSource {
  List<NotificationItem> items();

  List<NotificationPreference> preferences();
}

class NotificationLocalDataSource implements NotificationDataSource {
  const NotificationLocalDataSource();

  @override
  List<NotificationItem> items() => List.unmodifiable(_items);

  @override
  List<NotificationPreference> preferences() => List.unmodifiable(_preferences);
}

const _judulEvent = "Event Desa Hari Ini";

const _isiEvent =
    "Husabaqah Tilawatil Qur'an (MTq) Tingkat Nasional XXI Tahun 2026 Berlangsung Di Kota Semarang";

const _waktuEvent = "13 jam yang lalu";

const List<NotificationItem> _items = [
  NotificationItem(
    id: "event-1",
    category: NotificationCategory.event,
    title: _judulEvent,
    body: _isiEvent,
    timeAgo: _waktuEvent,
  ),
  NotificationItem(
    id: "event-2",
    category: NotificationCategory.event,
    title: _judulEvent,
    body: _isiEvent,
    timeAgo: _waktuEvent,
  ),
];

const List<NotificationPreference> _preferences = [
  NotificationPreference(
    type: NotificationPreferenceType.beritaTerkini,
    title: "Berita Terkini",
    subtitle: "Informasi terbaru seputar Desa",
  ),
  NotificationPreference(
    type: NotificationPreferenceType.peringatanCuaca,
    title: "Peringatan Dini Cuaca",
    subtitle: "Informasi potensi cuaca buruk di wilayah Desa",
  ),
  NotificationPreference(
    type: NotificationPreferenceType.eventDesa,
    title: "Event Desa Hari Ini",
    subtitle: "Informasi acara di Desa hari ini",
  ),
];
