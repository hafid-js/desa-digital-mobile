enum HubunganKeluarga {
  kepalaKeluarga('Kepala Keluarga', 1),
  suamiIstri('Suami/Istri', 2),
  anakLakiLaki('Anak Laki-laki', 3),
  anakPerempuan('Anak Perempuan', 4),
  cucuLakiLaki('Cucu Laki-laki', 5),
  cucuPerempuan('Cucu Perempuan', 6),
  orangTua('Orang Tua', 7),
  mertua('Mertua', 8),
  keponakan('Keponakan', 9),
  omTante('Om/Tante', 10),
  ahliWaris('Ahli Waris', 11),
  lainnya('Lainnya', 12);

  const HubunganKeluarga(this.label, this.code);

  final String label;
  final int code;
}

extension HubunganKeluargaLabels on List<HubunganKeluarga> {
  List<String> get labels => map((item) => item.label).toList();
}
