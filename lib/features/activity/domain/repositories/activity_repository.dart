import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/activity/domain/entities/activity_item.dart';

abstract interface class ActivityRepository {
  Result<List<ActivityItem>> items(ActivityFeed feed);
}
