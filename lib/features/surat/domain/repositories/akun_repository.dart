import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';

abstract interface class AkunRepository {
  Future<Result<Penduduk?>> profilAktif();
}
