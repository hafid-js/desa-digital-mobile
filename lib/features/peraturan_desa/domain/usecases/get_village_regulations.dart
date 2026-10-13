import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';
import 'package:desa_digital/features/peraturan_desa/domain/repositories/village_regulation_repository.dart';

class GetVillageRegulations
    extends BaseUseCase<List<VillageRegulation>, NoParams> {
  const GetVillageRegulations(this._repository);

  final VillageRegulationRepository _repository;

  @override
  Result<List<VillageRegulation>> execute(NoParams params) =>
      Result<List<VillageRegulation>>.success(_repository.getRegulations());
}
