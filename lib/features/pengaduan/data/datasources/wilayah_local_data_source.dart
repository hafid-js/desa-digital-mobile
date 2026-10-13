import 'package:desa_digital/core/constants/app_assets.dart';
import 'package:desa_digital/features/pengaduan/domain/entities/wilayah.dart';
import 'package:flutter/services.dart';

class WilayahDataSource {
  const WilayahDataSource();

  Future<List<Wilayah>> loadRegions() async {
    final provinces = await _parse(AppAssets.dataProvinsi);
    final regencies = await _parse(AppAssets.dataKabupaten);
    final districts = await _parse(AppAssets.dataKecamatan);
    final villages = await _parse(AppAssets.dataDesa);

    return [
      ...provinces.map(
        (r) => Wilayah(code: r[0], parentCode: '', name: r[1], level: 1),
      ),
      ...regencies.map(
        (r) => Wilayah(code: r[0], parentCode: r[1], name: r[2], level: 2),
      ),
      ...districts.map(
        (r) => Wilayah(code: r[0], parentCode: r[1], name: r[2], level: 3),
      ),
      ...villages.map(
        (r) => Wilayah(code: r[0], parentCode: r[1], name: r[2], level: 4),
      ),
    ];
  }

  Future<List<List<String>>> _parse(String asset) async {
    final raw = await rootBundle.loadString(asset);
    return raw.trim().split('\n').map((line) => line.split(',')).toList();
  }
}
