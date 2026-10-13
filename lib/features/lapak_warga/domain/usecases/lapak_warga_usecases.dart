import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/opsi_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/repositories/lapak_warga_repository.dart';

class LoadProdukLapak extends BaseUseCase<List<ProdukLapak>, NoParams> {
  const LoadProdukLapak(this._repository);

  final LapakWargaRepository _repository;

  @override
  Result<List<ProdukLapak>> execute(NoParams params) =>
      _repository.loadProduk();
}

class GetOpsiLapak extends BaseUseCase<OpsiLapak, NoParams> {
  const GetOpsiLapak(this._repository);

  final LapakWargaRepository _repository;

  @override
  Result<OpsiLapak> execute(NoParams params) => _repository.loadOpsi();
}
