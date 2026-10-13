enum NotificationPreferenceType { beritaTerkini, peringatanCuaca, eventDesa }

class NotificationPreference {
  const NotificationPreference({
    required this.type,
    required this.title,
    required this.subtitle,
    this.aktif = false,
  });

  final NotificationPreferenceType type;
  final String title;
  final String subtitle;

  final bool aktif;

  NotificationPreference copyWith({bool? aktif}) => NotificationPreference(
    type: type,
    title: title,
    subtitle: subtitle,
    aktif: aktif ?? this.aktif,
  );
}
