import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah_catalog.dart';
import 'package:desa_digital/features/pengaduan/domain/repositories/wilayah_repository.dart';

class LoadWilayahCatalog extends BaseAsyncUseCase<WilayahCatalog, NoParams> {
  const LoadWilayahCatalog(this._repository);

  final WilayahRepository _repository;

  @override
  Future<Result<WilayahCatalog>> execute(NoParams params) async {
    final result = await _repository.loadRegions();
    return result.fold(
      onSuccess: (regions) =>
          Result<WilayahCatalog>.success(WilayahCatalog(regions)),
      onFailure: (failure) => Result<WilayahCatalog>.failure(failure),
    );
  }
}

class WilayahSearchParams {
  const WilayahSearchParams({
    required this.catalog,
    required this.keyword,
    this.minChars = 3,
  });

  final WilayahCatalog catalog;
  final String keyword;
  final int minChars;
}

class SearchWilayah extends BaseUseCase<List<Wilayah>, WilayahSearchParams> {
  const SearchWilayah();

  @override
  Result<List<Wilayah>> execute(WilayahSearchParams params) =>
      Result<List<Wilayah>>.success(
        params.catalog.search(params.keyword, minChars: params.minChars),
      );
}
