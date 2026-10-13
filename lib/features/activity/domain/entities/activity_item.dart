class ActivityItem {
  const ActivityItem({
    required this.title,
    required this.meta,
    this.isReportCode = false,
  });

  final String title;
  final String meta;

  final bool isReportCode;
}

enum ActivityFeed {
  laporanProses,
  laporanSelesai,
  keluhanTersimpan,
  beritaTersimpan,
}
