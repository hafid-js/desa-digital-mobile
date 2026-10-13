import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah_catalog.dart';
import 'package:desa_digital/features/pengaduan/domain/usecases/wilayah_usecases.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PencarianWilayahController extends GetxController {
  PencarianWilayahController(this._loadCatalog, this._searchWilayah);

  final LoadWilayahCatalog _loadCatalog;
  final SearchWilayah _searchWilayah;

  final searchController = TextEditingController();
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();
  final RxList<Wilayah> results = <Wilayah>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt selectedIndex = 0.obs;

  static const int minChars = 3;
  static const double itemExtent = 40;

  WilayahCatalog? _catalog;

  void reset() {
    _attachedPosition?.removeListener(syncSelection);
    _attachedPosition = null;
    clear();
    if (scrollController.hasClients) {
      scrollController.jumpToItem(0);
    }
  }

  Future<void> onQueryChanged(String query) async {
    final keyword = query.trim().toLowerCase();

    if (keyword.length < minChars) {
      results.clear();
      return;
    }

    isLoading.value = true;

    try {
      final catalog = await _ensureCatalog();
      if (catalog == null) {
        results.clear();
        return;
      }

      final matches =
          _searchWilayah(
            WilayahSearchParams(
              catalog: catalog,
              keyword: keyword,
              minChars: minChars,
            ),
          ).valueOrNull ??
          const <Wilayah>[];

      results.assignAll(matches);
      selectedIndex.value = 0;
      if (scrollController.hasClients) {
        scrollController.jumpToItem(0);
      }
    } catch (_) {
      results.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<WilayahCatalog?> _ensureCatalog() async {
    final cached = _catalog;
    if (cached != null) return cached;

    final loaded = (await _loadCatalog(const NoParams())).valueOrNull;
    return _catalog = loaded;
  }

  void syncSelection() {
    if (results.isEmpty || !scrollController.hasClients) return;

    final item = scrollController.selectedItem.clamp(0, results.length - 1);
    if (item != selectedIndex.value) {
      selectedIndex.value = item;
    }
  }

  ScrollPosition? _attachedPosition;

  void attachScrollListener() {
    if (!scrollController.hasClients) return;

    final position = scrollController.position;
    if (_attachedPosition == position) return;

    _attachedPosition?.removeListener(syncSelection);
    position.addListener(syncSelection);
    _attachedPosition = position;
  }

  Wilayah? get selectedRegion {
    if (results.isEmpty) return null;
    if (selectedIndex.value < 0 || selectedIndex.value >= results.length) {
      return null;
    }
    return results[selectedIndex.value];
  }

  String pathOf(Wilayah region) => _catalog?.pathOf(region) ?? '';

  String? get fullLocation {
    final selected = selectedRegion;
    if (selected == null) return null;
    return pathOf(selected);
  }

  void clear() {
    searchController.clear();
    results.clear();
    isLoading.value = false;
    selectedIndex.value = 0;
  }

  @override
  void onClose() {
    _attachedPosition?.removeListener(syncSelection);
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
