import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/activity/data/datasources/activity_local_data_source.dart';
import 'package:desa_digital/features/activity/domain/entities/activity_item.dart';
import 'package:desa_digital/features/activity/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  const ActivityRepositoryImpl(this._dataSource);

  final ActivityDataSource _dataSource;

  @override
  Result<List<ActivityItem>> items(ActivityFeed feed) {
    try {
      return Result<List<ActivityItem>>.success(_dataSource.items(feed));
    } on Exception catch (error) {
      return Result<List<ActivityItem>>.failure(mapUnknownError(error));
    }
  }
}
