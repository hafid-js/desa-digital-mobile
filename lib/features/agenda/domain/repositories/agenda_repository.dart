import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';

abstract interface class AgendaRepository {
  Result<List<EventAgenda>> eventsOn(DateTime day);
}
