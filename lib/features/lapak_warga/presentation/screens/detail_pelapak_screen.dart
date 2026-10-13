import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/features/lapak_warga/domain/entities/produk_lapak.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_app_bar.dart';
import 'package:desa_digital/features/lapak_warga/presentation/widgets/lapak_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconsax/iconsax.dart';

class DetailPelapakScreen extends StatelessWidget {
  const DetailPelapakScreen({super.key, required this.produk});

  final ProdukLapak produk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LapakAppBar(
        title: 'Lapak Warga',
        searchHint: 'Cari di Etan Hooper...',
      ),
      body: Stack(
        children: [
          Positioned(
            top: 5,
            right: 12,
            left: 12,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          produk.userAvatar,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Material(
                          color: AppColors.tertiary,
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () {},
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    produk.seller,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    produk.location,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              color: AppColors.tertiary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "21 Produk",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Hubungi :",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.tertiary.withAlpha(40),
                              child: Icon(
                                Iconsax.call,
                                color: AppColors.tertiary,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 235)),
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
                        return LapakItemCard(
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
          ),
        ],
      ),
    );
  }
}
