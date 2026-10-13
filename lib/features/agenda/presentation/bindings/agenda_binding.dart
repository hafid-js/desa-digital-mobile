import 'package:desa_digital/core/di/injector.dart';
import 'package:desa_digital/features/agenda/data/datasources/agenda_local_data_source.dart';
import 'package:desa_digital/features/agenda/data/repositories/agenda_repository_impl.dart';
import 'package:desa_digital/features/agenda/domain/repositories/agenda_repository.dart';
import 'package:desa_digital/features/agenda/domain/usecases/get_events_on_date.dart';
import 'package:desa_digital/features/agenda/presentation/controllers/agenda_controller.dart';
import 'package:get/get.dart';

class AgendaBinding extends Bindings {
  @override
  void dependencies() {
    Injector.register<AgendaDataSource>(
      AgendaLocalDataSource.new,
      lazy: true,
      permanent: true,
    );

    Injector.register<AgendaRepository>(
      () => AgendaRepositoryImpl(Injector.resolve<AgendaDataSource>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<GetEventsOnDate>(
      () => GetEventsOnDate(Injector.resolve<AgendaRepository>()),
      lazy: true,
      permanent: true,
    );

    Injector.register<AgendaController>(
      () => AgendaController(Injector.resolve<GetEventsOnDate>()),
      lazy: true,
    );
  }
}
