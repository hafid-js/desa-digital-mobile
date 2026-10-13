class ProfileFormOptions {
  const ProfileFormOptions({
    required this.religion,
    required this.marriedStatus,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
  });

  final List<String> religion;
  final List<String> marriedStatus;
  final List<String> provinsi;
  final List<String> kabupaten;
  final List<String> kecamatan;
  final List<String> kelurahan;
}
