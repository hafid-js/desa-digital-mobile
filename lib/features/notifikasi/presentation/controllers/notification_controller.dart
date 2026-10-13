import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_preference.dart';
import 'package:desa_digital/features/notifikasi/domain/usecases/get_notifications.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationController(this._getNotifications, this._getPreferences);

  final GetNotifications _getNotifications;
  final GetNotificationPreferences _getPreferences;

  final RxList<NotificationItem> items = <NotificationItem>[].obs;
  final RxList<NotificationPreference> preferences =
      <NotificationPreference>[].obs;

  final RxBool terbaca = false.obs;

  @override
  void onInit() {
    super.onInit();
    _muatNotifikasi();
    _muatPreferensi();
  }

  List<NotificationItem> itemsByCategory(NotificationCategory category) =>
      _getNotifications(category).valueOrNull ?? const <NotificationItem>[];

  void toggleTerbaca() => terbaca.toggle();

  void setPreferensi(NotificationPreferenceType type, bool aktif) {
    final index = preferences.indexWhere((item) => item.type == type);
    if (index == -1) return;
    preferences[index] = preferences[index].copyWith(aktif: aktif);
  }

  void _muatNotifikasi() {
    items.assignAll(
      _getNotifications(NotificationCategory.semua).valueOrNull ??
          const <NotificationItem>[],
    );
  }

  void _muatPreferensi() {
    preferences.assignAll(
      _getPreferences(const NoParams()).valueOrNull ??
          const <NotificationPreference>[],
    );
  }
}
