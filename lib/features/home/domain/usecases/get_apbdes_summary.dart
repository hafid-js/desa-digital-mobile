import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/domain/repositories/home_repository.dart';

class GetApbdesSummary extends BaseUseCase<ApbdesSummary, NoParams> {
  const GetApbdesSummary(this._repository);

  final HomeRepository _repository;

  @override
  Result<ApbdesSummary> execute(NoParams params) =>
      Result<ApbdesSummary>.success(_repository.getApbdes());
}
