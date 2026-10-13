import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/lapak_warga/data/datasources/opsi_lapak_data_source.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_item_saya_card.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/sheet_form_lapak.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';

class LapakSayaScreen extends StatelessWidget {
  const LapakSayaScreen({super.key, required this.produk});

  final ProdukLapak produk;

  Future<void> _bukaJual(BuildContext context) async {
    final opsi = const OpsiLapakDataSource().loadOpsi();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.95,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) => SheetFormLapak(
          judul: "Jual",
          tampilkanInfoPenjual: true,
          kategori: opsi.kategoriProduk,
          kondisi: opsi.kondisiProduk,
          lokasi: opsi.lokasi,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Lapak Saya",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Aktif",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Nonaktif",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _bukaJual(context),
            icon: const Icon(Iconsax.add),
            tooltip: 'Posting Lapak',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          DecoratedSliver(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 24),
              sliver: SliverMasonryGrid.count(
                childCount: 16,
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return LapakItemSayaCard(
                    isPelapakDetail: true,
                    product: produk,
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
