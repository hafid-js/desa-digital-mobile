import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_preference.dart';
import 'package:desa_digital/features/notifikasi/domain/repositories/notification_repository.dart';

class GetNotifications
    extends BaseUseCase<List<NotificationItem>, NotificationCategory> {
  const GetNotifications(this._repository);

  final NotificationRepository _repository;

  @override
  Result<List<NotificationItem>> execute(NotificationCategory params) {
    final items = _repository.getItems();
    if (params == NotificationCategory.semua) {
      return Result<List<NotificationItem>>.success(items);
    }
    return Result<List<NotificationItem>>.success(
      items.where((item) => item.category == params).toList(),
    );
  }
}

class GetNotificationPreferences
    extends BaseUseCase<List<NotificationPreference>, NoParams> {
  const GetNotificationPreferences(this._repository);

  final NotificationRepository _repository;

  @override
  Result<List<NotificationPreference>> execute(NoParams params) =>
      Result<List<NotificationPreference>>.success(
        _repository.getPreferences(),
      );
}
