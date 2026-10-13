import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/notifikasi/data/datasources/notification_local_data_source.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_item.dart';
import 'package:desa_digital/features/notifikasi/domain/entities/notification_preference.dart';
import 'package:desa_digital/features/notifikasi/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._dataSource);

  final NotificationDataSource _dataSource;

  @override
  List<NotificationItem> getItems() => _dataSource.items();

  @override
  List<NotificationPreference> getPreferences() => _dataSource.preferences();

  static Result<T> guard<T>(T Function() reader) {
    try {
      return Result<T>.success(reader());
    } on Exception catch (error) {
      return Result<T>.failure(mapUnknownError(error));
    }
  }
}
