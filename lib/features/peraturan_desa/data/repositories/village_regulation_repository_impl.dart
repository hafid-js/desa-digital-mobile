import 'package:desa_digital/core/error/failure_mapper.dart';
import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/peraturan_desa/data/datasources/village_regulation_local_data_source.dart';
import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';
import 'package:desa_digital/features/peraturan_desa/domain/repositories/village_regulation_repository.dart';

class VillageRegulationRepositoryImpl implements VillageRegulationRepository {
  const VillageRegulationRepositoryImpl(this._dataSource);

  final VillageRegulationDataSource _dataSource;

  @override
  List<VillageRegulation> getRegulations() => _dataSource.regulations();

  static Result<T> guard<T>(T Function() reader) {
    try {
      return Result<T>.success(reader());
    } on Exception catch (error) {
      return Result<T>.failure(mapUnknownError(error));
    }
  }
}
