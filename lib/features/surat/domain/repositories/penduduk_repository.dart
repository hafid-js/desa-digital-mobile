import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/surat/domain/entities/penduduk.dart';

abstract interface class PendudukRepository {
  Future<Result<List<Penduduk>>> semua();

  Future<Result<List<Penduduk>>> cari(String kataKunci);
}
