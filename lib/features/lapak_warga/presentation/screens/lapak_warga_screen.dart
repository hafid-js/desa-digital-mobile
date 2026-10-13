import 'package:desa_digital/features/lapak_warga/domain/entities/filter_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/urutan.dart';
import 'package:desa_digital/features/lapak_warga/presentation/controllers/lapak_warga_controller.dart';
import 'package:desa_digital/features/lapak_warga/presentation/screens/wishlist_screen.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/filter_lapak_sheet.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_app_bar.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_chip.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_detail_modal.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_item_card.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_kosong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LapakWargaScreen extends GetView<LapakWargaController> {
  const LapakWargaScreen({super.key});

  Future<void> _bukaFilter(BuildContext context) async {
    final opsi = controller.opsi;
    final hasil = await showModalBottomSheet<(FilterLapak, Urutan)>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterLapakSheet(
        kategori: opsi?.kategoriFilter ?? const [],
        lokasi: opsi?.lokasi ?? const [],
        penawaran: opsi?.penawaran ?? const [],
        kondisi: opsi?.kondisiProduk ?? const [],
        terakhirDitambahkan: opsi?.terakhirDitambahkan ?? const [],
        ketersediaan: opsi?.ketersediaan ?? const [],
        awal: controller.filter.value,
        urutan: controller.urutan.value,
      ),
    );

    if (hasil == null) return;

    controller.setFilter(hasil.$1);
    controller.setUrutan(hasil.$2);
  }

  void _showDetailModal(BuildContext context, ProdukLapak product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.9],
        builder: (context, scrollController) => ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: LapakDesaDetailModal(
            product: product,
            scrollController: scrollController,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _filterDanKategori(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () => _bukaFilter(context),
                  borderRadius: BorderRadius.circular(30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Iconsax.filter, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        'Filter & Urutkan',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final label
                            in controller.opsi?.kategoriProduk ??
                                const <String>[])
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: LapakChip(
                              label: label,
                              aktif: controller.kategoriTerpilih.value == label,
                              onTap: () => controller.pilihKategori(label),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final produk = controller.produk;

    return Scaffold(
      appBar: LapakAppBar(
        title: 'Lapak Warga',
        searchHint: 'Cari Dagangan Warga...',
        preferredHeight: 105,
        extraActions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => Get.to(() => const WishlistScreen()),
            icon: const Icon(Iconsax.shopping_bag),
            tooltip: 'Wishlist',
          ),
        ],
        bottom: _filterDanKategori(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: produk.isEmpty
            ? const LapakKosong()
            : MasonryGridView.count(
                itemCount: produk.length,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemBuilder: (context, index) {
                  final item = produk[index];
                  return LapakItemCard(
                    product: item,
                    onTap: () => _showDetailModal(context, item),
                  );
                },
              ),
      ),
    );
  }
}
