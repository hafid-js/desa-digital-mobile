import 'package:desa_digital/features/home/domain/entities/apbdes.dart';
import 'package:desa_digital/features/home/domain/entities/content_item.dart';
import 'package:desa_digital/features/home/domain/entities/home_menu_item.dart';

abstract interface class HomeRepository {
  List<HomeMenuItem> getMenuItems();

  List<ContentItem> getAgendaHariIni();

  List<ContentItem> getArtikelTerbaru();

  ApbdesSummary getApbdes();
}
