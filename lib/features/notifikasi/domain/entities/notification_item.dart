enum NotificationCategory { semua, aduan, event, berita }

class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.timeAgo,
  });

  final String id;
  final NotificationCategory category;
  final String title;
  final String body;

  final String timeAgo;
}
