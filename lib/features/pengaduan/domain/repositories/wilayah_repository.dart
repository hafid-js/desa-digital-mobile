import 'package:desa_digital/core/result/result.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah.dart';

abstract interface class WilayahRepository {
  Future<Result<List<Wilayah>>> loadRegions();
}
