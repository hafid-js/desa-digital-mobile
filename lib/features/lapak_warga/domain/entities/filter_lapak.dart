class FilterLapak {
  const FilterLapak({
    this.kategori = const <String>{},
    this.hargaMinimum,
    this.hargaMaksimum,
    this.lokasi = const <String>{},
    this.penawaran = const <String>{},
    this.kondisi = const <String>{},
    this.terakhirDitambahkan = const <String>{},
    this.ketersediaan = const <String>{},
  });

  final Set<String> kategori;
  final int? hargaMinimum;
  final int? hargaMaksimum;
  final Set<String> lokasi;
  final Set<String> penawaran;
  final Set<String> kondisi;
  final Set<String> terakhirDitambahkan;
  final Set<String> ketersediaan;

  bool get aktif =>
      kategori.isNotEmpty ||
      hargaMinimum != null ||
      hargaMaksimum != null ||
      lokasi.isNotEmpty;

  int get jumlahFilterAktif {
    var jumlah = kategori.length + lokasi.length;

    if (hargaMinimum != null || hargaMaksimum != null) jumlah++;

    return jumlah;
  }

  FilterLapak copyWith({
    Set<String>? kategori,
    int? hargaMinimum,
    int? hargaMaksimum,
    bool clearHargaMinimum = false,
    bool clearHargaMaksimum = false,
    Set<String>? lokasi,
    Set<String>? penawaran,
    Set<String>? kondisi,
    Set<String>? terakhirDitambahkan,
    Set<String>? ketersediaan,
  }) {
    return FilterLapak(
      kategori: kategori ?? this.kategori,
      hargaMinimum: clearHargaMinimum
          ? null
          : (hargaMinimum ?? this.hargaMinimum),
      hargaMaksimum: clearHargaMaksimum
          ? null
          : (hargaMaksimum ?? this.hargaMaksimum),
      lokasi: lokasi ?? this.lokasi,
      penawaran: penawaran ?? this.penawaran,
      kondisi: kondisi ?? this.kondisi,
      terakhirDitambahkan: terakhirDitambahkan ?? this.terakhirDitambahkan,
      ketersediaan: ketersediaan ?? this.ketersediaan,
    );
  }
}
