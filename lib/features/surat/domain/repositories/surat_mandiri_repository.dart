import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/surat/domain/entities/surat_mandiri.dart';

abstract interface class SuratMandiriRepository {
  Result<List<SuratMandiri>> katalog();

  Result<List<SuratMandiri>> katalogSiap();

  Result<List<SuratMandiri>> katalogPerluProses();

  Future<Result<void>> kirim(Map<String, dynamic> data);
}
