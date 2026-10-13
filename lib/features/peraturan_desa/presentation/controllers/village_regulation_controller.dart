import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/peraturan_desa/domain/entities/village_regulation.dart';
import 'package:desa_digital/features/peraturan_desa/domain/usecases/get_village_regulations.dart';
import 'package:get/get.dart';

class VillageRegulationController extends GetxController {
  VillageRegulationController(this._getRegulations);

  final GetVillageRegulations _getRegulations;

  final RxList<VillageRegulation> regulations = <VillageRegulation>[].obs;

  @override
  void onInit() {
    super.onInit();
    regulations.assignAll(
      _getRegulations(const NoParams()).valueOrNull ??
          const <VillageRegulation>[],
    );
  }
}
