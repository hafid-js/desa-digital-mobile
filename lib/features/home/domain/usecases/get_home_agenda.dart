import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/domain/repositories/home_repository.dart';

class GetHomeAgenda extends BaseUseCase<List<ContentItem>, NoParams> {
  const GetHomeAgenda(this._repository);

  final HomeRepository _repository;

  @override
  Result<List<ContentItem>> execute(NoParams params) =>
      Result<List<ContentItem>>.success(_repository.getAgendaHariIni());
}
