import 'package:desa_digital/core/usecase/usecase.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/filter_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/opsi_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/urutan.dart';
import 'package:desa_digital/features/lapak_warga/domain/usecases/lapak_warga_usecases.dart';
import 'package:get/get.dart';

class LapakWargaController extends GetxController {
  LapakWargaController(this._loadProduk, this._loadOpsi);

  final LoadProdukLapak _loadProduk;
  final GetOpsiLapak _loadOpsi;

  final Rx<FilterLapak> filter = const FilterLapak().obs;
  final Rx<Urutan> urutan = Urutan.palingSesuai.obs;

  List<ProdukLapak> get produk =>
      _produk ??= _loadProduk(const NoParams()).valueOrNull ?? const [];
  List<ProdukLapak>? _produk;

  OpsiLapak? get opsi => _opsi ??= _loadOpsi(const NoParams()).valueOrNull;
  OpsiLapak? _opsi;

  final RxString kategoriTerpilih = ''.obs;

  void pilihKategori(String value) {
    kategoriTerpilih.value = kategoriTerpilih.value == value ? '' : value;
  }

  void setFilter(FilterLapak value) => filter.value = value;

  void setUrutan(Urutan value) => urutan.value = value;
}
