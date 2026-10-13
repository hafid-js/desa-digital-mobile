import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';
import 'package:desa_digital/features/agenda/domain/repositories/agenda_repository.dart';

class GetEventsOnDate extends BaseUseCase<List<EventAgenda>, DateTime> {
  const GetEventsOnDate(this._repository);

  final AgendaRepository _repository;

  @override
  Result<List<EventAgenda>> execute(DateTime params) =>
      _repository.eventsOn(params);
}
