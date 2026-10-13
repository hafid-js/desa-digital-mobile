import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_preference.dart';

abstract interface class NotificationRepository {
  List<NotificationItem> getItems();

  List<NotificationPreference> getPreferences();
}
