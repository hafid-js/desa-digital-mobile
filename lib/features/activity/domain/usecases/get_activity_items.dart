import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/activity/domain/entities/activity_item.dart';
import 'package:desa_digital/features/activity/domain/repositories/activity_repository.dart';

class GetActivityItems extends BaseUseCase<List<ActivityItem>, ActivityFeed> {
  const GetActivityItems(this._repository);

  final ActivityRepository _repository;

  @override
  Result<List<ActivityItem>> execute(ActivityFeed params) =>
      _repository.items(params);
}
