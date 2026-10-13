import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';
import 'package:desa_digital/features/agenda/domain/entities/jenis_agenda.dart';
import 'package:desa_digital/features/agenda/domain/usecases/get_events_on_date.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController {
  AgendaController(this._getEventsOnDate);

  final GetEventsOnDate _getEventsOnDate;

  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx<DateTime?>(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  final Rxn<List<EventAgenda>> acaraTerpilih = Rxn<List<EventAgenda>>();
  final Rx<JenisAgenda?> jenisTerpilih = Rx<JenisAgenda?>(null);

  List<JenisAgenda> get opsiJenis => JenisAgenda.values;

  @override
  void onInit() {
    super.onInit();
    final hariIni = DateTime.now();
    selectedDay.value = DateTime.utc(hariIni.year, hariIni.month, hariIni.day);
    _muat(selectedDay.value!);

    initializeDateFormatting('id_ID', null);
  }

  List<EventAgenda> eventsOn(DateTime day) {
    final events = _getEventsOnDate(day).valueOrNull ?? const <EventAgenda>[];
    final jenis = jenisTerpilih.value;
    if (jenis == null) return events;
    return events.where((event) => event.jenis == jenis).toList();
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
    _muat(selected);
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void pilihJenis(JenisAgenda? jenis) {
    jenisTerpilih.value = jenisTerpilih.value == jenis ? null : jenis;
  }

  void _muat(DateTime day) {
    _getEventsOnDate(day).fold(
      onSuccess: (events) => acaraTerpilih.value = events,
      onFailure: (_) => acaraTerpilih.value = const <EventAgenda>[],
    );
  }
}
