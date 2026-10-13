import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/agenda/data/datasources/agenda_local_data_source.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';
import 'package:desa_digital/features/agenda/domain/repositories/agenda_repository.dart';

class AgendaRepositoryImpl implements AgendaRepository {
  const AgendaRepositoryImpl(this._dataSource);

  final AgendaDataSource _dataSource;

  @override
  Result<List<EventAgenda>> eventsOn(DateTime day) {
    try {
      return Result<List<EventAgenda>>.success(_dataSource.eventsOn(day));
    } on Exception catch (error) {
      return Result<List<EventAgenda>>.failure(mapUnknownError(error));
    }
  }
}
