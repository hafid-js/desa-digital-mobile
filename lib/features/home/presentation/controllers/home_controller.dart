import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/domain/entities/home_menu_item.dart';
import 'package:desa_digital/features/home/domain/usecases/get_apbdes_summary.dart';
import 'package:desa_digital/features/home/domain/usecases/get_home_agenda.dart';
import 'package:desa_digital/features/home/domain/usecases/get_home_articles.dart';
import 'package:desa_digital/features/home/domain/usecases/get_home_menu_items.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController(
    this._getMenuItems,
    this._getAgenda,
    this._getArticles,
    this._getApbdesSummary,
  );

  final GetHomeMenuItems _getMenuItems;
  final GetHomeAgenda _getAgenda;
  final GetHomeArticles _getArticles;
  final GetApbdesSummary _getApbdesSummary;

  final RxList<HomeMenuItem> menuItems = <HomeMenuItem>[].obs;
  final RxList<ContentItem> agendaHariIni = <ContentItem>[].obs;
  final RxList<ContentItem> artikelTerbaru = <ContentItem>[].obs;
  final Rxn<ApbdesSummary> ringkasanApbdes = Rxn<ApbdesSummary>();

  @override
  void onInit() {
    super.onInit();
    _muat();
  }

  void _muat() {
    menuItems.assignAll(
      _getMenuItems(const NoParams()).valueOrNull ?? const <HomeMenuItem>[],
    );
    agendaHariIni.assignAll(
      _getAgenda(const NoParams()).valueOrNull ?? const <ContentItem>[],
    );
    artikelTerbaru.assignAll(
      _getArticles(const NoParams()).valueOrNull ?? const <ContentItem>[],
    );
    ringkasanApbdes.value = _getApbdesSummary(const NoParams()).valueOrNull;
  }
}
