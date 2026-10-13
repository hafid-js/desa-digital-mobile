import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/agenda/domain/entities/event_agenda.dart';
import 'package:desa_digital/features/agenda/presentation/controllers/agenda_controller.dart';
import 'package:desa_digital/features/agenda/presentation/widgets/kartu_agenda.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  AgendaController get _controller => Get.find<AgendaController>();

  TableCalendar _buildKalender(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2000),
      lastDay: DateTime(2100),
      focusedDay: _controller.focusedDay.value,
      selectedDayPredicate: (day) =>
          isSameDay(_controller.selectedDay.value, day),
      onDaySelected: _controller.onDaySelected,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Bulanan',
        CalendarFormat.twoWeeks: '2 Mingguan',
        CalendarFormat.week: 'Mingguan',
      },
      calendarFormat: _controller.calendarFormat.value,
      onFormatChanged: _controller.onFormatChanged,
      headerVisible: true,
      headerStyle: HeaderStyle(
        titleTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        formatButtonVisible: true,
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        weekendTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.primary.withAlpha(130),
          shape: BoxShape.circle,
        ),
      ),
      eventLoader: (day) => _controller.eventsOn(day),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              child: CircleAvatar(
                radius: 4,
                backgroundColor: AppColors.primary,
              ),
            );
          }
          return const SizedBox();
        },
      ),
      enabledDayPredicate: (day) {
        return day.isAfter(DateTime.now().subtract(const Duration(days: 1))) ||
            isSameDay(day, DateTime.now());
      },
    );
  }

  Widget _buildDaftarEvent(BuildContext context, List<EventAgenda> events) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${events.length} Event",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: KartuAgenda(event: events[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Acara", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(color: AppColors.grey.withAlpha(35)),
            child: Obx(() => _buildKalender(context)),
          ),
          Obx(() {
            final events = _controller.acaraTerpilih.value;
            if (events == null) return const SizedBox.shrink();
            return Expanded(child: _buildDaftarEvent(context, events));
          }),
        ],
      ),
    );
  }
}
