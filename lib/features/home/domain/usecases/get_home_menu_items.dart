import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/home/domain/entities/home_menu_item.dart';
import 'package:desa_digital/features/home/domain/repositories/home_repository.dart';

class GetHomeMenuItems extends BaseUseCase<List<HomeMenuItem>, NoParams> {
  const GetHomeMenuItems(this._repository);

  final HomeRepository _repository;

  @override
  Result<List<HomeMenuItem>> execute(NoParams params) =>
      Result<List<HomeMenuItem>>.success(_repository.getMenuItems());
}
