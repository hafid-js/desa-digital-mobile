class Wilayah {
  final String code;
  final String parentCode;
  final String name;
  final int level;

  const Wilayah({
    required this.code,
    required this.parentCode,
    required this.name,
    required this.level,
  });

  String get levelLabel {
    switch (level) {
      case 1:
        return 'Provinsi';
      case 2:
        return 'Kabupaten/Kota';
      case 3:
        return 'Kecamatan';
      default:
        return 'Kelurahan/Desa';
    }
  }
}
