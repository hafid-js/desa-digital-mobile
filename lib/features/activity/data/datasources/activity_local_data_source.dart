import 'package:desa_digital/features/activity/domain/entities/activity_item.dart';

abstract interface class ActivityDataSource {
  List<ActivityItem> items(ActivityFeed feed);
}

class ActivityLocalDataSource implements ActivityDataSource {
  const ActivityLocalDataSource();

  @override
  List<ActivityItem> items(ActivityFeed feed) => switch (feed) {
    ActivityFeed.laporanProses => inProgressReports,
    ActivityFeed.laporanSelesai => finishedReports,
    ActivityFeed.keluhanTersimpan => savedComplaints,
    ActivityFeed.beritaTersimpan => savedNews,
  };
}

const String _reportTitle = "LGWS67947799";
const String _reportMeta = "Sukoharjo, 6 jam yang lalu";
const String _newsTitle =
    "Timsel Calon Anggota Komisi Informasi Jamin Kerahasiaan Soal Seleksi";
const String _newsMeta = "17 Sept 2026";

const ActivityItem _report = ActivityItem(
  title: _reportTitle,
  meta: _reportMeta,
  isReportCode: true,
);

const ActivityItem _news = ActivityItem(title: _newsTitle, meta: _newsMeta);

const List<ActivityItem> inProgressReports = [_report, _report, _report];
const List<ActivityItem> finishedReports = [_news, _news, _news];
const List<ActivityItem> savedComplaints = [_report, _report, _report];
const List<ActivityItem> savedNews = [_news, _news, _news];
