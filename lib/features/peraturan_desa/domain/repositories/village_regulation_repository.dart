import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';

abstract interface class VillageRegulationRepository {
  List<VillageRegulation> getRegulations();
}
