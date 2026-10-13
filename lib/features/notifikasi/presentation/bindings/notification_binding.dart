import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/notifikasi/data/datasources/notification_local_data_source.dart';
import 'package:desa_digital/features/notifikasi/data/repositories/notification_repository_impl.dart';
import 'package:desa_digital/features/notifikasi/domain/repositories/notification_repository.dart';
import 'package:desa_digital/features/notifikasi/domain/usecases/get_notifications.dart';
import 'package:desa_digital/features/notifikasi/presentation/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<NotificationDataSource>(
      NotificationLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<NotificationRepository>(
      () => NotificationRepositoryImpl(
        Injector.resolve<NotificationDataSource>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetNotifications>(
      () => GetNotifications(Injector.resolve<NotificationRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetNotificationPreferences>(
      () => GetNotificationPreferences(
        Injector.resolve<NotificationRepository>(),
      ),
      lazy: true,
      permanent: true,
    );

    Injector.register<NotificationController>(
      () => NotificationController(
        Injector.resolve<GetNotifications>(),
        Injector.resolve<GetNotificationPreferences>(),
      ),
      lazy: true,
      permanent: true,
    );
  }
}
