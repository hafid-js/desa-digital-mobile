import 'package:desa_digital/features/pengaduan/domain/entities/wilayah.dart';

class WilayahCatalog {
  WilayahCatalog(List<Wilayah> regions)
    : regions = List.unmodifiable(regions),
      _byCode = {for (final region in regions) region.code: region};

  final List<Wilayah> regions;
  final Map<String, Wilayah> _byCode;

  List<Wilayah> search(String keyword, {int minChars = 3}) {
    final keywordLower = keyword.trim().toLowerCase();
    if (keywordLower.length < minChars) return const <Wilayah>[];

    final matches =
        regions
            .where(
              (region) =>
                  region.level >= 2 &&
                  region.name.toLowerCase().contains(keywordLower),
            )
            .toList()
          ..sort((a, b) {
            if (a.level != b.level) return a.level.compareTo(b.level);
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });

    return matches;
  }

  String pathOf(Wilayah region) {
    final names = <String>[];
    Wilayah? current = region;

    while (current != null) {
      if (current.level >= 2) names.add(current.name);
      current = current.parentCode.isEmpty ? null : _byCode[current.parentCode];
    }

    return names.reversed.map((name) => name.toUpperCase()).join(', ');
  }
}
